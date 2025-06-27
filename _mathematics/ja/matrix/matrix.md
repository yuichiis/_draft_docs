概要
--------
"Rindow Math Matrix" は、ベクトル演算環境を提供するライブラリです。

多くの人が学習時間を節約できるように、PythonのNumPyに似せて作られています。

以下の特徴があります。

- 共通の配列オブジェクトインターフェース "NDArray" を実装。
- 柔軟なN次元配列演算ライブラリを提供。
- バックエンドの外部ライブラリにOpenBLASを利用可能。(オプション)
- OpenCLによってGPUなどのハードウェアを利用可能。(オプション)


モジュール構造
-------------
"Rindow Math Matrix" は、様々な動作環境に対応するために、モジュール化されています。
それぞれのモジュールは差し替え可能で、新たな機能を追加することができます。

構造図:

[構造図](/mathematics/matrix/images/structure.svg)




要件
------------
- PHP 8.1、8.2、8.3、8.4
   - (PHP 7.2から8.0の環境で使用する場合は、リリース1.1を使用してください。)
- Windows 10、11、または Linux (OpenBLASを使用する場合)


推奨
----------
- [**Rindow Math Plot**](/mathematics/plot/overviewplot.html): 数学データの可視化
- [**Rindow Matlib と OpenBLAS**](/mathematics/openblas/overviewopenblas.html): C言語インターフェースと高速演算
- [**OpenCL と CLBlast**](/mathematics/acceleration/opencl.html): GPUアクセラレーションをサポート





インストール
------------
### Rindow Math Matrix のインストール
composerを使用してセットアップしてください。

```shell
$ composer require rindow/rindow-math-matrix
```

グラフ表示が必要な場合は、rindow-math-plotをセットアップしてください。

Windowsの場合はphp.iniのFFI拡張を有効にします。
```
extension = gd
```
Linuxの場合はgd拡張をインストールします。
```shell
$ sudo apt install phpX.X-gd
```

rindow-math-plotをインストールします。
```shell
$ composer require rindow/rindow-math-plot
```

Linuxの場合、rindow-math-plotのために画像ビューアの設定が必要です。

```shell
$ RINDOW_MATH_PLOT_VIEWER=/some/bin/dir/png-file-viewer
$ export RINDOW_MATH_PLOT_VIEWER
```
注意: RINDOW_MATH_PLOT_VIEWER には "viewnior" などを指定してください。

### CPUのみで高速化する

最初にFFIの有効化と外部ライブラリのインストールをします。

**Windowsの場合**:

FFIを有効にします。
php.iniのFFI拡張を有効にします。
```
extension = ffi
```
ffiが有効になっていることを確認します。
```shell
work> php -m | find "FFI"
```

以下のサイトからOpenBLASのWindows用バイナリーをダウンロードして解凍してください。
- https://github.com/OpenMathLib/OpenBLAS/releases/
以下のサイトからRindow-MatlibのWindows用バイナリーをダウンロードして解凍してください。
- https://github.com/rindow/rindow-matlib/releases/

それぞれのbinディレクトリをPATHに設定します。
```shell
work> SET PATH=%PATH%;C:\OpenBLAS\bin;C:\Matlib\bin
```

**Linuxの場合**:

aptコマンドでFFI拡張とopenblasとlapackeのインストールも忘れずにしてください。
```shell
$ sudo apt install phpX.X-ffi libopenblas0 liblapacke
```
以下のサイトからRindow-MatlibのLinux用バイナリーをダウンロードして解凍してください。
- https://github.com/rindow/rindow-matlib/releases/
```shell
$ wget https://github.com/rindow/rindow-matlib/releases/rindow-matlib_X.X.X_amd64.deb
$ sudo apt install ./rindow-matlib_X.X.X_amd64.deb
```

高速化のためのサービスをインストールします。
**Windows、Linux共通**

rindow-math-matrix-matlibffiをインストールしてください。
```shell
$ composer require rindow/rindow-math-matrix-matlibffi
```
インストールされたことを確認してください。
```shell
$ vendor\bin\rindow-math-matrix
Service Level   : Advanced
Buffer Factory  : Rindow\Math\Buffer\FFI\BufferFactory
BLAS Driver     : Rindow\OpenBLAS\FFI\Blas
LAPACK Driver   : Rindow\OpenBLAS\FFI\Lapack
Math Driver     : Rindow\Matlib\FFI\Matlib
```
サービスレベルがBasicの場合は何らかの理由で外部ライブラリが利用できていません。
コマンドの詳細情報オプションで確認してください。
```shell
$ vendor\bin\rindow-math-matrix -v
```

詳しいインストール方法は[こちら](/mathematics/openblas/overviewopenblas.html)。

### GPUで高速化する
まずは前節の"CPUで高速化する"でライブラリの設定をします。
その後GPUの高速化ライブラリをインストールします。

**Windowsの場合**:

以下のサイトからCLBlastのWindows用バイナリーをダウンロードして解凍してください。
- https://github.com/CNugteren/CLBlast/releases

binディレクトリをPATHに設定します。
```shell
work> SET PATH=%PATH%;C:\CLBlast\bin
```

**Linuxの場合**:
OpenCLとCLBlastをインストールします。
OpenCLのドライバーはそれぞれのハードウェアごとに異なります。
Ubuntu標準では以下のものがあります。
- **Intel iGPU用**: intel-opencl-icd
- **AMD APU用**: mesa-opencl-icd
その他のGPUはそれぞれのメーカーに特化したドライバが必要です。

```shell
$ sudo apt install clinfo
$ sudo apt install XXX-XXX-icd
$ sudo apt install libclblast0
```

コマンドでサービスレベルが"Accelerated"になることを確認してください。
**Windows、Linux共通**
```shell
$ vendor\bin\rindow-math-matrix
Service Level   : Accelerated
Buffer Factory  : Rindow\Math\Buffer\FFI\BufferFactory
BLAS Driver     : Rindow\OpenBLAS\FFI\Blas
LAPACK Driver   : Rindow\OpenBLAS\FFI\Lapack
Math Driver     : Rindow\Matlib\FFI\Matlib
OpenCL Factory  : Rindow\OpenCL\FFI\OpenCLFactory
CLBlast Factory : Rindow\CLBlast\FFI\CLBlastFactory
```
サービスレベルがBasicかAdvanceの場合は何らかの理由で外部ライブラリが利用できていません。
コマンドの詳細情報オプションで確認してください。
```shell
$ vendor\bin\rindow-math-matrix -v
```

詳しいインストール方法は[こちら](/mathematics/acceleration/opencl.html)

### Rindow Math Matrix の使い方
```php
include 'vendor/autoload.php';

$mo = new Rindow\Math\Matrix\MatrixOperator();

$a = $mo->array([1.0, 2.0]);
$b = $mo->array([3.0, 4.0]);

$c = $mo->add($a,$b);

echo $mo->toString($c)."\n";

### このようなグラフを作成する場合:

$plt = new Rindow\Math\Plot\Plot();

$plt->bar(['x','y'],$c);
$plt->show();
```

線形代数ライブラリを使用する場合:
```php
include 'vendor/autoload.php';

$mo = new Rindow\Math\Matrix\MatrixOperator();
$la = $mo->la();

$a = $mo->array([[1.0, 2.0],[3.0, 4.0]]);
$b = $mo->array([[3.0, 4.0],[5.0, 6.0]]);

$c = $la->gemm($a,$b);

echo $mo->toString($c)."\n";

### これをグラフを作成する場合:

$plt = new Rindow\Math\Plot\Plot();

$plt->bar(['x','y'],$c);
$plt->show();
```

線形代数ライブラリのGPUバージョンを使用する場合:
```php
include 'vendor/autoload.php';

use Interop\Polite\Math\Matrix\OpenCL;

$mo = new Rindow\Math\Matrix\MatrixOperator();
$la = $mo->laAccelerated('clblast',['deviceType'=>OpenCL::CL_DEVICE_TYPE_GPU]);
$la->blocking(true);

$a = $mo->array([[1.0, 2.0],[3.0, 4.0]]);
$b = $mo->array([[3.0, 4.0],[5.0, 6.0]]);

$a = $la->array($a);
$b = $la->array($b);
$c = $la->gemm($a,$b);
$c = $la->toNDArray($c);

echo $mo->toString($c)."\n";

### これをグラフを作成する場合:

$plt = new Rindow\Math\Plot\Plot();

$plt->bar(['x','y'],$c);
$plt->show();
```
