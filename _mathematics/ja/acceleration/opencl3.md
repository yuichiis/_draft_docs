## 高性能計算のためのアクセラレーションデバイス活用 (Rindow-Math-Matrix GPUサポート)

### 1. 概要

Rindow-Math-Matrixは、計算アクセラレーションのためにOpenCLを採用しています。OpenCLを選択した主な理由は、GPUだけでなく、FPGAやシグナルプロセッサなど、将来的に多様な算術アクセラレーションデバイスへの対応可能性を秘めているためです。これにより、比較的手に入りやすいノートPC環境でもGPUによる高速化の恩恵を受けることが期待できます。

ただし、数値演算を高速化するためには、OpenCLのサポートだけでは不十分です。OpenCLを利用した高性能な演算ライブラリも必要となります。Rindow-Math-Matrixでは、以下のライブラリや機能を提供することで、OpenCLによるアクセラレーションを実現しています。

*   **CLBlast**: 現在活発に開発が進められている、OpenCLベースのBLAS (Basic Linear Algebra Subprograms) 互換ライブラリです。
*   **Rindow Math Matrix独自のOpenCL関数**: BLASに含まれない数学関数や、その他必要な操作をOpenCL上で実行可能にするための機能です。

### 2. 主要コンポーネント

GPUアクセラレーションを実現するために、Rindow-Math-Matrixは以下の主要なコンポーネントを利用・提供しています。

#### 2.1. Rindow OpenCL FFI

PHPからOpenCLを直接利用するためのライブラリです。
*   **役割**: PHPアプリケーションとOpenCLドライバー間のインターフェースを提供します。
*   **対応OpenCLバージョン**: OpenCL 1.1または1.2をサポートし、幅広い環境での利用を可能にしています。
*   **現状と将来**: 現在はRindowのニューラルネットワークライブラリでの使用を主目的として、必要最小限の機能セットとなっていますが、将来的には拡張される予定です。
*   **詳細**: [Rindow OpenCL FFI (GitHub)](https://github.com/rindow/rindow-opencl-ffi)

#### 2.2. Rindow CLBlast FFI

OpenCL上で動作するBLASライブラリであるCLBlastを、PHPから利用するためのバインディングです。
*   **CLBlast**: 高効率なBLAS演算をOpenCLで実現するライブラリです。[CLBlast詳細 (GitHub)](https://github.com/CNugteren/CLBlast)
*   **役割**: CLBlastの機能をPHPから呼び出せるようにします。
*   **詳細**: [Rindow CLBlast FFI (GitHub)](https://github.com/rindow/rindow-clblast)

#### 2.3. Rindow Math Matrix OpenCLMath ライブラリ

BLASライブラリだけではカバーできない、様々な数学関数や操作をOpenCL上で提供するための、Rindow Math Matrix内部ライブラリです。

### 3. システム要件

GPUアクセラレーション機能を利用するためのシステム要件は以下の通りです。

*   **PHP**: 8.1, 8.2, 8.3, 8.4
*   **PHPインターフェース**: `interop-phpobjects/polite-math` 1.0.6以降
*   **OpenCL**: OpenCL 1.1 以降のドライバーおよびライブラリ
*   **オペレーティングシステム**: Windows 10, 11 または Linux (Ubuntu 22.04 または Debian 12 以降)
*   **Rindowライブラリ群**:
    *   Rindow Math Matrix
    *   Rindow Math Buffer FFI
    *   Rindow OpenBLAS FFI
    *   Rindow Matlib FFI
    *   Rindow OpenCL FFI
    *   Rindow CLBlast FFI
*   **外部ライブラリ**:
    *   OpenBLAS 0.3.20 以降
    *   CLBlast 1.5.2 以降

### 4. セットアップ方法

#### 4.1. Windows 環境でのセットアップ

Windows環境では、多くの場合、OS標準でOpenCLが利用可能です。

1.  **ビルド済みバイナリのダウンロードと配置**:
    以下のライブラリのビルド済みバイナリをダウンロードし、任意の場所に展開します。
    *   [OpenBLAS](https://github.com/OpenMathLib/OpenBLAS/releases)
    *   [Rindow Matlib](https://github.com/rindow/matlib/releases)
    *   [CLBlast](https://github.com/CNugteren/CLBlast/releases)

2.  **実行パスの設定**:
    ダウンロードしたライブラリの`bin`ディレクトリにPATHを通します。例えば、`C:\OpenBLAS`, `C:\Matlib`, `C:\CLBlast` に展開した場合：
    ```shell
    C:TEMP>PATH %PATH%;C:\CLBlast\bin;C:\OpenBLAS\bin;C:\Matlib\bin
    ```

3.  **PHP FFI拡張の有効化**:
    `php.ini`ファイルを編集し、FFI拡張を有効にします。
    ```ini
    extension=ffi
    ```

4.  **Rindow Math Matrixのセットアップと確認**:
    Composerを使用して必要なパッケージをインストールし、設定を確認します。
    ```shell
    C:yourproject> composer require rindow/rindow-math-matrix
    C:yourproject> composer require rindow/rindow-math-matrix-matlibffi
    C:yourproject> vendor\bin\rindow-math-matrix
    ```
    出力結果で `Service Level` が `Accelerated` になっており、`OpenCL Factory` や `CLBlast Factory` が表示されていることを確認してください。
    ```
    Service Level   : Accelerated
    Buffer Factory  : Rindow\Math\Buffer\FFI\BufferFactory
    BLAS Driver     : Rindow\OpenBLAS\FFI\Blas
    LAPACK Driver   : Rindow\OpenBLAS\FFI\Lapack
    Math Driver     : Rindow\Matlib\FFI\Matlib
    OpenCL Factory  : Rindow\OpenCL\FFI\OpenCLFactory
    CLBlast Factory : Rindow\CLBlast\FFI\CLBlastFactory
    ```

5.  **GPUデバイス認識の確認 (トラブルシューティング)**:
    期待通りにGPUデバイスが認識されない場合は、`clinfo`コマンドでOpenCLデバイスの状態を確認します。
    ```shell
    C:tutorials>vendor\bin\clinfo
    Number of platforms(1)
    Platform(0)
        CL_PLATFORM_NAME=Intel(R) OpenCL
        CL_PLATFORM_PROFILE=FULL_PROFILE
    ....
    ```

#### 4.2. Ubuntu 環境でのセットアップ

1.  **必須ライブラリのインストール (OpenBLAS, Rindow Matlib)**:
    ```shell
    # OpenBLASとLAPACKのインストール
    $ sudo apt update
    $ sudo apt install libopenblas-base liblapacke

    # Rindow Matlibのインストール (X.X.X はバージョンに合わせてください)
    $ wget https://github.com/rindow/rindow-matlib/releases/download/X.X.X/rindow-matlib_X.X.X_amd64.deb
    $ sudo apt install ./rindow-matlib_X.X.X_amd64.deb
    ```
    *補足: Rindow-MatlibはPHPで使用するためにシリアルモードに設定する必要があります。(通常はデフォルトでそのように動作します)*

2.  **OpenCLドライバーのインストール**:
    環境に合わせてOpenCLドライバーをインストールします。まず`clinfo`をインストールして情報を確認できるようにします。
    ```shell
    $ sudo apt install clinfo
    ```
    次に、お使いのハードウェアに合わせたドライバーをインストールします (例: Intel GPUの場合)。
    ```shell
    $ sudo apt install intel-opencl-icd
    ```
    Ubuntuで標準的に利用可能なOpenCLドライバーには以下のようなものがあります:
    *   `mesa-opencl-icd`
    *   `beignet-opencl-icd`
    *   `intel-opencl-icd`
    *   `nvidia-opencl-icd-xxx` (xxxはバージョン番号)
    *   `pocl-opencl-icd`

    **注意**: Linuxの標準OpenCLドライバーは、環境やバージョンによって正常に動作しない場合があります。その際は、各ドライバーやバージョンに応じた個別対応が必要になることがあります。

3.  **OpenCL動作確認**:
    `clinfo`コマンドを実行し、OpenCLプラットフォームとデバイスが正しく認識されているか確認します。
    ```shell
    $ clinfo
    Number of platforms                               1
      Platform Name                                   Intel Gen OCL Driver
      Platform Vendor                                 Intel
    ....
    ```

4.  **CLBlastライブラリのインストール**:
    ```shell
    $ sudo apt install libclblast1
    ```

5.  **Rindow Math Matrixのセットアップと確認**:
    Composerを使用して必要なパッケージをインストールし、設定を確認します。
    ```shell
    $ composer require rindow/rindow-math-matrix
    $ composer require rindow/rindow-math-matrix-ffi # (原文では -matlibffi となっていますが、FFI全体を指すならこちらが適切か。文脈次第で修正)
    $ vendor/bin/rindow-math-matrix
    ```
    出力結果で `Service Level` が `Accelerated` になっており、`OpenCL Factory` や `CLBlast Factory` が表示されていることを確認してください (Windowsの場合と同様)。

### 5. アクセラレーテッドコンピューティングの利用方法

#### 5.1. GPU対応LinearAlgebraの生成

Rindow-Math-Matrixの標準的な`MatrixOperator`やデフォルトの`LinearAlgebra`オブジェクトは、CPUを使用して計算を行います。GPUアクセラレーションを利用するには、OpenCLに対応した`LinearAlgebra`互換オブジェクトを明示的に生成する必要があります。これにより、プログラム内でCPUとGPUを使い分けることが可能になります。

Rindow-Math-Matrix全体の[モジュール構成図](/mathematics/matrix/matrix.html#module-structure)を参照すると、GPU関連部分が標準環境から分離されていることが確認できます。

GPU対応の`LinearAlgebra`オブジェクトは、`MatrixOperator`の`laAccelerated()`メソッドを使用して生成します。現在提供されているのはCLBlastを利用する実装であるため、カタログ名として `'clblast'` を指定します。これにより、`LinearAlgebraCL`クラスのインスタンスが作成されます。

```php
use Rindow\Math\Matrix\MatrixOperator;
use Interop\Polite\Math\Matrix\OpenCL;

$mo = new MatrixOperator();

// CPU用LinearAlgebraオブジェクト
$la_cpu = $mo->la();

// GPU用LinearAlgebraオブジェクト (CLBlastを使用)
// デフォルトでGPUタイプのデバイスを使用するよう指定
$la_gpu = $mo->laAccelerated('clblast', ['deviceType' => OpenCL::CL_DEVICE_TYPE_GPU]);
```

Windows環境などでは、標準のOpenCLドライバーがGPUデバイスとCPUデバイスの両方を認識することがあります。その場合は、`deviceType`オプションでどちらを使用するかを指定する必要があります。

システムに複数のGPUが搭載されており、特定のGPUを使用したい場合は、OpenCLが認識しているプラットフォーム番号とデバイス番号を `'プラットフォームID,デバイスID'` の形式で指定します。

```php
// プラットフォームID 0, デバイスID 1 のGPUを使用する場合
$la_gpu = $mo->laAccelerated('clblast', ['device' => '0,1']);
```

#### 5.2. CPUとGPU間のメモリ管理

GPUを用いた演算では、データがCPUのメモリ空間にあるのか、GPUのメモリ空間にあるのかを常に意識する必要があります。

基本的なデータフローは以下のようになります。
> **入力データ (CPUメモリ) → GPUメモリへコピー → GPU上で演算 → 結果をGPUメモリに格納 → CPUメモリへコピー → 出力データ (CPUメモリ)**

一度GPUメモリにコピーされたデータは、GPU上で繰り返し演算に使用できます。また、演算結果が格納されたGPUメモリ上のデータも、続けて別のGPU演算の入力として使用できます。

*   **CPUメモリからGPUメモリへのデータ転送**: `LinearAlgebraCL`オブジェクトの`array()`メソッドを使用します。
*   **GPUメモリからCPUメモリへのデータ転送**: `LinearAlgebraCL`オブジェクトの`toNDArray()`メソッドを使用します。

```php
$a_cpu = $la_cpu->array([1, 2, 3]); // CPU上にNDArrayを作成

// CPU上のNDArrayをGPUメモリにコピーして、GPU用のNDArrayCLオブジェクトを作成
$a_gpu = $la_gpu->array($a_cpu);

// ... (a_gpu を使った何らかのGPU演算) ...
// 例: $b_gpu = $la_gpu->add($a_gpu, $a_gpu);

// GPUメモリ上の演算結果 ($b_gpu) をCPUメモリにコピー
$b_cpu = $la_gpu->toNDArray($b_gpu);

echo $mo->toString($b_cpu) . "\n";
```

このプロセスでGPUメモリ上に作成される多次元配列オブジェクトが `NDArrayCL` です。`LinearAlgebraCL` と `NDArrayCL` は、通常の `LinearAlgebra` と `NDArray` のように、それぞれ演算インターフェースとデータオブジェクトとして機能しますが、非同期実行の扱いや `ArrayAccess` のサポートなど、いくつかの点で異なります（後述）。

#### 5.3. OpenCLインターフェースとRindow OpenCL FFI

`LinearAlgebraCL`の内部では、OpenCL上で実際に演算を行う低レイヤーの演算ライブラリ群が動作しています。BLAS関数は`CLBlast`が、それ以外の数学関数はRindow-Math-Matrix内の`OpenCLMath`ライブラリが担当します。

これらのライブラリがPHPからOpenCL機能を利用できるようにするために、OpenCLの機能を抽象化した `Rindow OpenCL FFI` が使用されます。

**OpenCL抽象化ダイアグラム:**

![OpenCL Diagram](images/opencl.svg)
> *図のグレー部分は未実装です。*

##### Rindow OpenCL FFIの主要コンポーネント

*   **Platform/DeviceList**: OpenCLのPlatformオブジェクトとDeviceオブジェクトのリストを管理します。
*   **Context/Queue**: OpenCLのContextオブジェクトとCommand Queueオブジェクトです。`LinearAlgebraCL`では、通常、アプリケーション全体でそれぞれ1つずつあれば十分です。
*   **EventList**: OpenCLのEventオブジェクトをPHPで扱いやすくするための抽象化クラスです。コマンドキューに処理を投入 (enqueue) した際に返されるEventオブジェクトの管理や、先行する処理の完了を待つためのWaitEventListとして使用されます。`wait()`メソッドにより、特定の処理の完了を同期的に待つことができます。
*   **Buffer**: OpenCLのBuffer（GPUメモリ領域）を`DeviceBuffer`インターフェースとして抽象化したクラスです。**重要な注意点として、パフォーマンス低下を避けるため`ArrayAccess`（配列のような添字アクセス）はサポートされていません。** この設計は、個別の配列要素ごとの頻繁なデータ転送を避け、一連の演算がすべて終了した後にバッファ全体を転送する、という効率的な使用方法を想定しています。
*   **Program/Kernel**: OpenCLのProgramオブジェクトとKernelオブジェクトです。`OpenCLMath`ライブラリ内部でカーネルがキャッシュされるため、呼び出しのたびにカーネルがビルドされることはありません。

#### 5.4. 非同期実行と同期実行

OpenCLを用いた演算は、基本的に**非同期**に実行されます。つまり、GPUに演算処理を依頼した後、プログラムはすぐに次の処理に進み、GPUはその間バックグラウンドで計算を行います。計算結果を取得する際には、その計算処理が完了したことを示すイベントを待つ必要があります。

**内部での実行例 (イメージ):**
```php
// イベントリストを準備
$events = $opencl->EventList();
// カーネルを実行キューに追加 (非同期)
$kernel->enqueueNDRange(
    $queue,
    $global_work_size,
    $local_work_size,
    null,          // waitEvents (先行イベントリスト)
    $events,       // この処理の完了イベントを格納するリスト
    $waitEvents    // この処理の前に完了を待つべきイベントリスト
);
// 処理の完了を待つ (同期)
$events->wait();
```

したがって、`LinearAlgebraCL` をデフォルト設定で使用する場合、各演算の後に明示的にイベント完了を待つコードが必要になります。

**イベントリストを使用した同期:**
```php
$events = $lacl->newEventList(); // 新しいイベントリストを取得
$lacl->scal(
    2.0,
    $a_gpu,
    events: $events // この演算のイベントを$eventsに格納
);
$events->wait(); // scal演算の完了を待つ
```

または、コマンドキュー内のすべての処理が完了するのを待つ `finish()` メソッドも使用できます。
```php
$lacl->scal(2.0, $a_gpu);
// ... 他の演算 ...
$lacl->finish(); // キュー内の全処理の完了を待つ
```

毎回イベント待ちのコードを書くのは冗長になるため、非同期実行が特に必要ない場合は、`LinearAlgebraCL` のデフォルト動作として、各演算の完了を自動的に待つように設定できます。このブロッキング（同期）設定は、`LinearAlgebraCL`インスタンス生成後に一度行えば、そのインスタンスに対して永続的に有効です。

**デフォルトでの同期実行設定:**
```php
$lacl->blocking(true); // これ以降、この $lacl インスタンスでの演算は自動的に完了を待つ
$lacl->scal(2.0, $a_gpu); // この呼び出しは完了するまでブロックされる
```

また、BLAS関数以外の`OpenCLMath`ライブラリが提供する関数では、`waitEvents`オプションを指定することで、先行する特定の演算の完了を待ってから現在の演算を開始する、という依存関係を自動的に管理できます。

以下の例では、`scal()`演算の完了を待ってから`add()`演算が実行されます。
```php
$scal_events = $lacl->newEventList();
$lacl->scal(
    2.0,
    $a_gpu,
    events: $scal_events
);

$add_events = $lacl->newEventList();
$lacl->add(
    $a_gpu,
    $b_gpu,
    events: $add_events,
    waitEvents: $scal_events // $scal_eventsに含まれるイベントの完了を待つ
);
$add_events->wait(); // add演算の完了を待つ
```

**重要な制約事項:**
> 現在、OpenCL上のBLASライブラリとして事実上の標準となっている **CLBlastでは、この`waitEvents`機能がサポートされていません。** この制約は、複数のBLAS演算をパイプライン化して効率的に実行する上で大きな課題となります。CLBlastを使用している限り、BLAS演算間でのきめ細やかな非同期実行と依存関係の管理は困難であり、非同期実行によるパフォーマンス向上の恩恵を十分に受けることが難しい状況であることをご留意ください。

