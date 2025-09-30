import asyncio
import uuid
from fastapi import FastAPI, Request
from fastapi.responses import HTMLResponse
from sse_starlette.sse import EventSourceResponse

app = FastAPI()

# 実行中のタスクの出力を保存するための辞書
# { "task_id": [output_line_1, output_line_2, ...] }
task_outputs = {}

async def run_command_stream(command: str, task_id: str):
    """
    コマンドを非同期で実行し、出力をtask_outputsにリアルタイムで追加する
    """
    # task_outputsにこのタスクID用のリストを作成
    task_outputs[task_id] = []

    # コマンドをサブプロセスとして実行
    process = await asyncio.create_subprocess_shell(
        command,
        stdout=asyncio.subprocess.PIPE,
        stderr=asyncio.subprocess.PIPE
    )

    # 標準出力と標準エラー出力をリアルタイムで読み取る
    # communicate() を使わないのがポイント
    while True:
        # どちらかの出力があるまで待つ
        tasks = [
            asyncio.create_task(process.stdout.readline()),
            asyncio.create_task(process.stderr.readline())
        ]
        done, pending = await asyncio.wait(tasks, return_when=asyncio.FIRST_COMPLETED)

        # 完了したタスクの出力を処理
        for task in done:
            line_bytes = task.result()
            if line_bytes:
                line = line_bytes.decode('utf-8').strip()
                task_outputs[task_id].append(line)
            else:
                # 出力が終わったらループを抜ける準備
                for p_task in pending:
                    p_task.cancel()
                break
        else:
            continue
        break
    
    # プロセスの終了を待つ
    await process.wait()
    
    # 処理終了の目印を追加
    task_outputs[task_id].append("---END---")


@app.post("/execute")
async def execute_command(request: Request):
    """
    コマンド実行を開始するエンドポイント
    """
    # 本番環境ではセキュリティに細心の注意を払うこと！
    # ここでは例として 'ping' コマンドを実行する
    # command = "ping -c 5 8.8.8.8" # Linux/macOS
    command = "ping -n 5 8.8.8.8"  # Windows
    
    task_id = str(uuid.uuid4())
    
    # コマンドをバックグラウンドで実行（リクエストはすぐに返る）
    asyncio.create_task(run_command_stream(command, task_id))
    
    return {"task_id": task_id}


@app.get("/stream/{task_id}")
async def stream_results(task_id: str):
    """
    指定されたタスクIDの実行結果をSSEでストリーミング配信する
    """
    async def event_generator():
        index = 0
        try:
            while True:
                if task_id in task_outputs and index < len(task_outputs[task_id]):
                    output = task_outputs[task_id][index]
                    index += 1
                    if output == "---END---":
                        yield {"data": "コマンドの実行が完了しました。"}
                        break
                    yield {"data": output}
                await asyncio.sleep(0.1) # ポーリング間隔
        except asyncio.CancelledError:
            # クライアントが接続を切断した場合の処理
            print(f"Client for task {task_id} disconnected.")
        finally:
            # ストリームが終了したらタスクの出力を削除（メモリ解放）
            if task_id in task_outputs:
                del task_outputs[task_id]
                print(f"Cleaned up task {task_id}")

    return EventSourceResponse(event_generator())


# フロントエンドのHTMLを返す
@app.get("/", response_class=HTMLResponse)
async def read_root():
    with open("index.html", "r", encoding="utf-8") as f:
        return f.read()

