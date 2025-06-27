コードと状況説明ありがとうございます。macOS環境でのみFFI利用時にセグメンテーションフォールトが断続的に発生するというのは、非常に厄介な問題ですね。考えられる原因と対処法をいくつか提案します。

**考えられる原因**

1.  **メモリ アライメントの問題:**
    *   macOS (特にARM64アーキテクチャのM1/M2チップ) は、特定のデータ型に対して厳密なメモリアライメントを要求することがあります。x86_64 (Intel Mac, Linux, Windows) では許容されるアライメント違反が、ARM64ではセグメンテーションフォールトを引き起こす可能性があります。
    *   `aligned()` メソッドで16バイトアライメントを試みていますが、これがmacOS環境、特にComplex型 (`rindow_complex_float`, `rindow_complex_double` - サイズ8バイトと16バイト) に対して適切であるか、あるいは `FFI::new()` で確保されるメモリが実際にそのアライメントを満たしているかが不確かです。`FFI::new("type[size]")` で確保されるメモリのアライメントは保証されていない可能性があります。

2.  **FFIオブジェクト (CData) のライフサイクルとガベージコレクション (GC):**
    *   PHPのFFIでは、CDataオブジェクトがPHP側で参照されなくなると、関連付けられたCのメモリが解放されます。しかし、`FFI::addr()` でポインタを取得したり、`FFI::memcpy()` を使ったりする際に、意図せずCDataオブジェクトへの参照が一時的になくなり、GCによってメモリが解放され、その後アクセスしようとしてセグフォに至るケースがありえます。特にテストが連続して実行される環境では、GCのタイミングによって問題が顕在化したりしなかったりすることがあります。
    *   `static FFI $ffi = null;` としてFFIインスタンスを共有していますが、これもテスト環境での実行順序によっては問題を引き起こす可能性がゼロではありません（通常は問題ないはずですが）。

3.  **Complex型の扱い:**
    *   `offsetSet` 内でComplex型を扱う際に `self::$ffi->new(self::$typeString[$this->dtype])` を呼び出して一時的なC構造体を作成し、それを配列要素に代入しています。この一時オブジェクトの生成・代入プロセスが、何らかの理由でメモリ破壊を引き起こしている可能性。本来は `$this->data[$offset]->real = $real;` のように直接代入できるはずです。
    *   ヘッダで定義された `rindow_complex_float/double` 構造体のアライメントやパディングが、macOSのコンパイラが期待するものと異なる可能性。

4.  **`dump()` / `load()` の `memcpy`:**
    *   `dump()` で一時バッファ `buf` を確保する際のサイズ計算 (`alignedBytes`) が過剰かもしれません。`$byte` (実際のデータサイズ) 分だけあれば十分なはずです。確保サイズと `FFI::string()` で読み取るサイズ、`memcpy` のサイズが一致していないと問題が起こる可能性があります。
    *   `FFI::string()` は、第一引数に与えられたCDataポインタから指定されたバイト数をPHP文字列にコピーします。一時的な `char` 配列を介さずに、直接 `$this->data` をキャストして渡す方がシンプルで安全かもしれません。

5.  **PHP FFI自体のプラットフォーム依存のバグ:**
    *   可能性は低いですが、PHPのFFI拡張機能にmacOS特有のバグが存在する可能性も否定できません。

**修正・検証の提案**

以下の順序で試してみることをお勧めします。

1.  **`aligned()` メソッドの無効化:**
    アライメントが原因か切り分けるために、一時的にアライメント処理を無効化してみます。

    ```php
    // Rindow\Math\Buffer\FFI\Buffer クラスの __construct 内
    public function __construct(int $size, int $dtype)
    {
        // ... (略) ...
        $this->size = $size;
        $this->dtype = $dtype;
        $declaration = self::$typeString[$dtype];
        // $size = $this->aligned($size,$dtype,16); // <-- この行をコメントアウト
        $allocSize = $this->size; // アライメントなしの元のサイズを使用
        $this->data = self::$ffi->new("{$declaration}[{$allocSize}]");
    }

    // aligned メソッド自体は残しても良いですが、呼ばれなくなります。
    /*
    protected function aligned(int $size, int $dtype,int $base) : int
    {
        // ... (実装はそのまま or return $size; にしても良い) ...
    }
    */
    ```
    これでセグフォが起きなくなるか、頻度が変わるか確認してください。

2.  **Complex型の `offsetSet` の修正:**
    一時的なCDataオブジェクトの生成をやめ、直接メンバに代入するように変更します。

    ```php
    // Rindow\Math\Buffer\FFI\Buffer クラスの offsetSet 内
    public function offsetSet(mixed $offset, mixed $value): void
    {
        $this->assertOffset('offsetSet', $offset);
        if ($this->isComplex()) {
            if (is_array($value)) {
                [$real, $imag] = $value;
            } elseif (is_object($value)) {
                // complex_t 型以外も考慮 (プロパティがあればOK)
                if (!property_exists($value, 'real') || !property_exists($value, 'imag')) {
                    throw new InvalidArgumentException("Complex object must have 'real' and 'imag' properties.");
                }
                $real = $value->real;
                $imag = $value->imag;
            } else {
                $type = gettype($value);
                throw new InvalidArgumentException("Cannot convert to complex number.: " . $type);
            }
            // FFI::new を使わず直接代入
            $this->data[$offset]->real = (float)$real; // 型キャストを追加して安全性を高める
            $this->data[$offset]->imag = (float)$imag; // 型キャストを追加して安全性を高める
        } else {
            // Check if bool and convert PHP bool to int (0 or 1)
            if ($this->dtype === NDArray::bool) {
                 $value = $value ? 1 : 0;
            }
            $this->data[$offset] = $value;
        }
    }

    // offsetGet も bool 型の変換を確認
    public function offsetGet(mixed $offset): mixed
    {
        $this->assertOffset('offsetGet',$offset);
        $value = $this->data[$offset];
        if($this->dtype===NDArray::bool) {
            // CData (uint8_t) から PHP bool へ
            $value = $value !== 0; // 0以外はtrue
        } elseif ($this->isComplex()) {
             // FFIの構造体をPHPオブジェクトに変換して返す (既存の挙動を踏襲する場合)
             // 必要であればここでPHPの complex_t に変換してもよいが、
             // FFI の CData オブジェクトをそのまま返しても ->real, ->imag でアクセスできるはず
             // return (object)['real' => $value->real, 'imag' => $value->imag];
        }
        return $value;
    }

    ```
    `offsetSet` で `(float)` キャストを追加し、`offsetGet` で `bool` への変換を ` !== 0` に変更しました。また、`offsetSet` の `bool` 型で PHP の `true/false` を C の `1/0` に変換する処理を追加しました。

3.  **`dump()` メソッドの修正:**
    一時バッファを使わず、直接 `FFI::string()` で文字列化します。

    ```php
    // Rindow\Math\Buffer\FFI\Buffer クラスの dump 内
    public function dump() : string
    {
        $byte = self::$valueSize[$this->dtype] * $this->size;
        // $alignedBytes = $this->aligned($byte,NDArray::int8,128); // 不要
        // $buf = self::$ffi->new("char[$alignedBytes]"); // 不要
        // FFI::memcpy($buf,$this->data,$byte); // 不要
        // return FFI::string($buf,$byte); // 不要

        // 直接キャストして文字列化
        if ($byte === 0) {
             return '';
        }
        // FFI::addr() を使ってポインタを取得し、それをキャストする方が安全かもしれない
        $ptr = FFI::addr($this->data[0]);
        return FFI::string(FFI::cast('char*', $ptr), $byte);
        // もしくは $this->data 自体をキャストする (配列の場合、通常はその先頭アドレスを指すはず)
        // return FFI::string(FFI::cast('char*', $this->data), $byte);
    }
    ```
    `FFI::addr($this->data[0])` を使う方が、配列の先頭要素のアドレスを明示的に取得できるため、より確実かもしれません。

4.  **GCの影響を減らす試み (やや高度):**
    もし上記で解決しない場合、CDataオブジェクトがGCされないように、テスト実行中に明示的に参照を保持することを試みます。ただし、これは根本解決ではなく、メモリリークのリスクがあります。

    ```php
    // BufferTest.php の setUp や各テストメソッド内
    protected $buffersToKeepAlive = [];

    public function testNormal()
    {
        $buf = $this->factory->Buffer(3,NDArray::float32);
        $this->buffersToKeepAlive[] = $buf; // テスト終了まで参照を保持

        // ... テストコード ...

        // テスト終了時に参照を解放 (PHPUnit の tearDown などで)
        // $this->buffersToKeepAlive = [];
    }

    public function tearDown(): void
    {
        $this->buffersToKeepAlive = [];
        // 必要であれば GC を強制実行してメモリ解放を促す
        // gc_collect_cycles();
    }
    ```
    これは問題の切り分けには役立つかもしれませんが、恒久的な対策ではありません。

5.  **Github Actionsでのデバッグ情報収集:**
    テスト実行コマンドの前に `ulimit -c unlimited` を実行し、セグフォ時にコアダンプが生成されるように設定します。そして、テスト失敗後に `lldb` (macOS標準) を使ってコアダンプからスタックトレースを取得するステップを追加します。

    ```yaml
    jobs:
      test:
        runs-on: macos-latest # または macos-11, macos-12 など
        steps:
          # ... checkout, setup php etc. ...
          - name: Enable core dumps
            run: ulimit -c unlimited
          - name: Run tests
            run: vendor/bin/phpunit tests/FFI/BufferTest.php
            # Continue on error to allow core dump analysis
            continue-on-error: true
            id: run_tests
          - name: Analyze core dump (if test failed)
            # Run only if the previous step failed
            if: steps.run_tests.outcome == 'failure'
            run: |
              echo "Attempting to analyze core dump..."
              # Core dump location might vary, check common places
              CORE_FILE=$(find /cores /var/tmp /tmp -name 'core.*' -print -quit 2>/dev/null)
              PHP_BIN=$(which php)
              if [[ -f "$CORE_FILE" && -n "$PHP_BIN" ]]; then
                echo "Core file found: $CORE_FILE"
                echo "PHP binary: $PHP_BIN"
                # Use lldb to get backtrace
                lldb "$PHP_BIN" -c "$CORE_FILE" -o "bt all" -o "quit"
              else
                echo "Core dump file not found or PHP binary not found."
              fi
              # Force the job to fail
              exit 1
    ```
    `lldb` の出力から、どのC関数呼び出しやPHPのどの部分でクラッシュしたかのヒントが得られるかもしれません。

**まとめ**

まずは提案1, 2, 3を試してみてください。特にアライメントの問題か、Complex型の扱いの問題である可能性が高いと思われます。`aligned()` の無効化、`offsetSet` での直接代入、`dump()` の単純化で挙動が変わるかを確認するのが最初のステップです。

それでも解決しない場合は、Github Actionsでのコアダンプ分析を進め、より詳細なクラッシュ情報を得ることを目指しましょう。
