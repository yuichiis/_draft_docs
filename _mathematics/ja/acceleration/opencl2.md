High-Performance Computing via Accelaration Devices
===================================================

概要
--------
Rindow-Math-MatrixがアクセラレーションデバイスへのアクセスのためにOpenCL を最初に選択したのは、GPU を含むさまざまな算術アクセラレーションをサポートしているためです。
これにより、安価なノートPC環境でもGPUの高速化が期待でき、さらに将来的にFPGAやシグナルプロセッサなどへの適応の可能性もあります。

数値演算を高速化するには、OpenCL のサポートだけでなく、OpenCL を使用した演算ライブラリも必要です。 CLBlast は、現在開発が進められている BLAS 互換ライブラリです。
これに加えて、Rindow Math Matrix では、BLAS以外のMATH関数やさまざまな必要な操作をOpenCL上でできるようにしています。

Rindow OpenCL FFI
-----------------------
OpenCL は、[Rindow OpenCL FFI](https://github.com/rindow/rindow-opencl-ffi) を通じて PHP から使用できます。
OpenCLのバージョンは1.1または1.2に限定されており、幅広い環境への対応が可能です。

私たちの目標は、Rindow ニューラル ネットワーク ライブラリで使用することなので、現時点では必要最小限の機能しかありません。 将来的には拡張される予定です。


Rindow CLBlast FFI
-----------------------
CLBlast は OpenCL 上の BLAS ライブラリです。 [詳細はこちら](https://github.com/CNugteren/CLBlast)。

[Rindow CLBlast FFI](https://github.com/rindow/rindow-clblast) は、上記のライブラリの PHP バインディングです。


Rindow Math Matrix の OpenCLMath ライブラリ
--------------------------------------
BLAS ライブラリには含まれていない OpenCL 上の便利な関数を提供します。


要件
------------

- PHP8.1, PHP8.2, PHP8.3, PHP8.4
- PHPインターフェース interop-phpobjects/polite-math 1.0.6以降
- OpenCL 1.1 以降の ドライバー/ライブラリ。
- Windows 10、11またはLinux(Ubuntu 22.04またはDebian 12以降)
- Rindow Math Matrix
- Rindow Math Buffer FFI
- Rindow OpenBLAS FFI
- Rindow Matlib FFI
- Rindow OpenCL FFI
- Rindow CLBlast FFI
- OpenBLAS 0.3.20 以降
- CLBlast 1.5.2 以降

GPU/OpenCLサポートのセットアップ方法 for Windows
------------------------------
WindowsはデフォルトでOpenCLが使えます。

以下のビルド済みバイナリーをダウンロードしてセットアップしてください。

- [OpenBLAS](https://github.com/OpenMathLib/OpenBLAS/releases)
- [Rindow Matlib](https://github.com/rindow/matlib/releases)
- [CLBlast](https://github.com/CNugteren/CLBlast/releases)

それぞれの実行パスを設定します。
```shell
C:TEMP>PATH %PATH%;C:\CLBlast\bin;C:\OpenBLAS\bin;C:\Matlib\bin
```

Configure the PHP. Edit php.ini to use FFI extension
php.iniを編集してFFI拡張を使つかえるようにPHPを設定します。

```shell
extension = ffi
```

rindow-math-matrixをOpenCLがつかえるようにセットアップします。
そしてサービスレベルがAcceleratedになっていることを確認してください。
```shell
C:yourproject> composer require rindow/rindow-math-matrix
C:yourproject> composer require rindow/rindow-math-matrix-matlibffi
C:yourproject> vendor\bin\rindow-math-matrix
Service Level   : Accelerated
Buffer Factory  : Rindow\Math\Buffer\FFI\BufferFactory
BLAS Driver     : Rindow\OpenBLAS\FFI\Blas
LAPACK Driver   : Rindow\OpenBLAS\FFI\Lapack
Math Driver     : Rindow\Matlib\FFI\Matlib
OpenCL Factory  : Rindow\OpenCL\FFI\OpenCLFactory
CLBlast Factory : Rindow\CLBlast\FFI\CLBlastFactory

```

もし使いたいGPUデバイスに設定できなかった場合は、clinfoコマンドでデバイスの状態を確認してください。
```shell
C:tutorials>vendor\bin\clinfo
Number of platforms(1)
Platform(0)
    CL_PLATFORM_NAME=Intel(R) OpenCL
    CL_PLATFORM_PROFILE=FULL_PROFILE
....
...
..
```


GPU/OpenCLサポートのセットアップ方法 for Ubuntu
------------------------------
Install the libraries required.

+ Install OpenBLAS with apt command
+ Download the latest version of Rindow-Matlib's pre-built binary files from https://github.com/rindow/rindow-matlib/releases.
+ Install the downloaded deb file using the apt command.
+ Set Rindow-Matlib to serial mode for use with PHP.

Install the rindow-matlib and openblas
```shell
$ sudo apt install libopenblas-base liblapacke
$ wget https://github.com/rindow/rindow-matlib/releases/download/X.X.X/rindow-matlib_X.X.X_amd64.deb
$ sudo apt install ./rindow-matlib_X.X.X_amd64.deb
```

Install the OpenCL for your environment.

```shell
$ sudo apt install clinfo
$ sudo apt install intel-opencl-icd
```
Ubuntu standard OpenCL drivers include:
- mesa-opencl-icd
- beignet-opencl-icd
- intel-opencl-icd
- nvidia-opencl-icd-xxx
- pocl-opencl-icd

The standard Linux OpenCL driver does not work properly, so we deal with it on a case-by-case basis to make it work somehow for each driver and version.

Check that OpenCL is running using the clinfo command.

```shell
$ clinfo
Number of platforms                               1
  Platform Name                                   Intel Gen OCL Driver
  Platform Vendor                                 Intel
....
...
..
```

install the CLBlast library.

```shell
$ sudo apt install libclblast1
```

Configure the rindow-math-matrix.

+ Verify that rindow-math-matrix is Accelerated and the OpenCL driver is recognized.

```shell
$ composer rindow/rindow-math-matrix
$ composer rindow/rindow-math-matrix-ffi
$ vendor\bin\rindow-math-matrix
Service Level   : Accelerated
Buffer Factory  : Rindow\Math\Buffer\FFI\BufferFactory
BLAS Driver     : Rindow\OpenBLAS\FFI\Blas
LAPACK Driver   : Rindow\OpenBLAS\FFI\Lapack
Math Driver     : Rindow\Matlib\FFI\Matlib
OpenCL Factory  : Rindow\OpenCL\FFI\OpenCLFactory
CLBlast Factory : Rindow\CLBlast\FFI\CLBlastFactory

```

Accelarated Computingの使い方
------------------------

### GPU対応LinearAlgebraの生成
rindow-math-matrixのMatrixOperatorやデフォルトのLinearAlgebraは通常の計算ではCPUを使います。
GPUを使った計算を行いたい場合はOpenCL対応のLinearAlgebra互換ライブラリを明示的に呼び出します。
これによりCPUとGPUをプログラム内で使分けることが出来ます。

Rindow-Math-Matrix全体の[ブロック図](/mathematics/matrix/matrix.html#module-structure)でGPU部分が標準の環境から分離している事を確認できます。

ライブラリインスタンスの生成には`laAccelerated()`を使います。
現在提供しているのはCLBlast用の互換ライブラリなので'clblast'というカタログ名で作成します。
これによりRindow-Math-Matrixが標準で提供しているLinearAlgebra互換のGPU用ライブラリである`LinearAlgebraCL`が作成されます。

また、このとき使用するOpenCLのデバイスをデバイスタイプで指定することが出来ます。一般にWindowsの標準OpenCLドライバーはGPUとCPUのデバイスタイプを実装しているため、どちらを使用するか指定する必要があります。

```php
use Rindow\Math\Matrix\MatrixOperator;
use Interop\Polite\Math\Matrix\OpenCL;

$mo = new MatrixOperator();
$la_cpu = $mo->la();
$la_gpu = $mo->laAccelerated('clblast',['deviceType'=>OpenCL::CL_DEVICE_TYPE_GPU]);
```

もし、GPUがシステムに複数ある場合は、OpenCLが認識しているプラットフォーム番号とデバイス番号を指定してください。

```php
# Platform ID = 0
# Device ID = 1
$la_gpu = $mo->laAccelerated('clblast',['device'=>'0,1']);
```

### CPUとGPUのメモリー空間

GPUを使った演算を行い場合は、常に今どのメモリー空間を使用しているのかを意識する必要があります。
プログラムが用意するデータは最初はすべてCPUのメモリー空間上にあり、そのデータをGPUのメモリー空間にコピーしてから演算を行います。
計算結果を取得したい場合はその逆にGPUからCPUにコピーして使用します。
ただし、一度GPU上にコピーしたデータはそのまま何回も使う事ができ、さらに計算結果の入ったGPU上のデータもそのまま次のGPUの計算で使用することが出来ます。

> Input Data => CPU Memory => GPU Memory => GPU => GPU Memory => CPU Memory => Output Data

CPUメモリー空間からGPUメモリー空間への転送は`LinearAlgebraCL`の`array()`関数で行い、
GPUメモリー空間からCPUメモリー空間への転送は`LinearAlgebraCL`の`toNDArray()`関数で行います。

```php
$a_cpu = $la_cpu->array([1,2,3]);
$a_gpu = $la_gpu->array($a_cpu);
......なにか計算
$b_cpu = $la_gpu->toNDArray($b_gpu);
echo $mo->toString($b_cpu)."\n";
```

この時に作成されたNDArray相当の多次元配列オブジェクトが`NDArrayCL`です。
`LinearAlgebraCL`と`NDArrayCL`は通常のNDArrayオブジェクトとLinearAlgebraのように、関数とデータとして使用することが出来ます。
ただし、非同期実行やArrayAccessなどの点で通常とは違う部分があります。これらは後述します。


### OpenCLインターフェース
`LinearAlgebraCL`の内部では低レイヤー演算インターフェースを提供する演算ライブラリ群がOpenCL上で演算を行います。BLAS関数を`CLBlast`が担当し、BLAS以外をrindow-math-matrix内の`OpenCLMath`ライブラリが担当します。

`LinearAlgebraCL`や各低レイヤーライブラリががOpenCLをPHPで使えるようにするためにOpenCLインターフェースを抽象化したRindow OpenCL FFIを使用します。

OpenCL 抽象化ダイアグラム:

![OpenCL Diagram](images/opencl.svg)

> 図のグレー部分は未実装


### Rindow OpenCL FFIの主な構成要素
- **Platform/DeivceList**:
  + OpenCLのPlatformオブジェクトとDeivceオブジェクトのリストです。
- **Context/Queue**:
  + OpenCLのConextオブジェクトとQueueオブジェクトです。基本的には`LinearAlgebraCL`では全体で１つずつあれば十分です。
- **EventList**:
  + OpenCLのEventオブジェクトをPHPで管理しやすく抽象化したクラスです。
  + Queueへ処理をEnqueueした時に返されるEventオブジェクト受け取りや、前処理を待つためのWaitEventListに使用します。
  + wait()を使って処理の終了イベント待ちが出来ます。
- **Buffer**:
  + OpenCLのBufferはGPUメモリー領域を`DeviceBuffer`インターフェースとして抽象化したクラスです。
  + 処理効率が著しく下がるため`ArrayAccess`を禁止しています。したがって個別の配列要素ごとのデータ転送はせず、一連の演算がすべて終了した後にバッファー全体を転送するという使用方法を想定して設計されています。
- **Program/Kernel**:
  + OpenCLのProgramオブジェクトとKernelオブジェクトです。OpenCLMathの中でキャッシュされるため呼び出すたびにKernelがbuildされる事はありません。


### 非同期実行/同期実行

OpenCLを使った演算は通常は非同期に実行されます。
GPUに実行を依頼したあと終了イベントを待ってから計算結果を取得します。

内部での実行例
```php
$events =  $opencl->EventList();
$kernel->enqueueNDRange(
  $queue,
  $global_work_size,
  $local_work_size,
  null,
  $events,
  $waitEvents,
);
$events->wait();
```

したがって`LinearAlgebraCL`のデフォルト状態ではイベント待ちをする必要があります。
```php
$events =  $lacl->newEventList();
$lacl->scal(
  2.0,$a,
  events:$events,
);
$events->wait();
```
または
```php
$lacl->scal(2.0,$a);
$lacl->finish();
```

イベント待ちのコードを毎回書くのは冗長なため、非同期実行が必要ない場合はデフォルトで動作で終了イベントを待つ指定ができます。ブロッキングの指定は`LinearAlgebraCL`を生成後に１度設定すればずっと有効です。

```php
$lacl->blocking(true);
$lacl->scal(2.0,$a);
```


またBLAS関数以外はOpenCLのwaitEventsを指定して、前の演算の終了待ちを自動化することが出来ます。
以下のコードではscal()の実行の終了を待ってからadd()が実行されます。

```php
$scal_events =  $lacl->newEventList();
$lacl->scal(
  2.0,$a,
  events:$scal_events,
);
$add_events =  $lacl->newEventList();
$lacl->add(
  $a,$b,
  events:$add_events,
  waitEvents:$scal_events,
);
$add_events->wait();
```

> 事実上のOpenCL上のBLASのデファクトスタンダードであるCLBlastでは、このwaitEventがサポートされていません。この問題は計算のパイプライン構築に致命的な影響があり、CLBlastを使用している以上は非同期実行の恩恵を受けることが非常に困難であることを私たちは認識しています。


