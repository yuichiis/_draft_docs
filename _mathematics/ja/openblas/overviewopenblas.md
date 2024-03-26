概要
--------
Rindow-math-matrixはC言語などで記述された外部ライブラリを呼び出し行列演算を高速化できます。
線形代数ライブラリでもっとも有名なOpenBLASや、機械学習に有用なRindow-Matlibを呼び出すことができます。

最新のバージョン2からPHPのFFI機能を使ってC言語インターフェースのライブラリー呼び出しをします。(バージョン1ではPHP拡張を使っていました)

主に以下の低レイヤーインターフェースが提供されています。

- C言語とPHP間のデータ交換用に1次元のユニバーサルバッファを提供します。
- OpenBLASライブラリとほぼ同じ低レイヤーなインターフェースをPHPで利用できます。これにより配列形状に依存しない柔軟な使い方ができます。
- Rindow-matlibも同様にC言語とほぼ同じ低レイヤーなインターフェースをPHPで利用できます。
- [Rindow Math Matrix](/mathematics/matrix/matrix.html) と組み合わせて、非常に高速かつ高度な N 次元配列演算を実行できます。

PHPでディープラーニングをしたいときにとても便利です！

要件
------------

- PHP8.1 または PHP8.2 または PHP8.3
- Linux または Windows 10、11
- OpenBLASライブラリ 0.3.20 以降
- Rindow-Mathライブラリ 1.0 以降


Installation instructions from pre-build binaries
-------------------------------------------------

### Download pre-build binaries from each projects

You can perform very fast N-dimensional array operations in conjunction.
Download the pre-build binary files from each project's release page.

- Pre-build binaries
  - [Rindow Matlib](https://github.com/rindow/rindow-matlib/releases)
  - [OpenBLAS](https://github.com/xianyi/OpenBLAS/releases)

### Setup for Windows

Download the binary file, unzip it, and copy it to the execution directory.

- rindow-matlib-X.X.X-win64.zip
- OpenBLAS-X.X.X-x64.zip

Add FFI extension to php.ini

```shell
C:\TMP> cd \path\to\php\directory
C:\PHP> notepad php.ini

extension=ffi
C:\PHP> php -m

C:\TMP> PATH %PATH%;\path\to\binary\directories\bin
C:\TMP> cd \your\progject\directory
C:\PRJ> composer require rindow/rindow-math-matrix
C:\PRJ> composer require rindow/rindow-math-matrix-matlibffi
C:\PRJ> vendor/bin/rindow-math-matrix
Service Level   : Advanced
Buffer Factory  : Rindow\Math\Buffer\FFI\BufferFactory
BLAS Driver     : Rindow\OpenBLAS\FFI\Blas
LAPACK Driver   : Rindow\OpenBLAS\FFI\Lapack
Math Driver     : Rindow\Matlib\FFI\Matlib
```

### Setup for Ubuntu

Install each library using the apt command.

Make sure FFI extension is enabled.
```shell
$ php -m | grep FFI
FFI
```

Install the fast matrix calculation library.
And then set the rindow-matlib to serial mode for use with PHP.
```shell
$ mkdir -p /your/project/directory
$ cd /your/project/directory
$ sudo apt install libopenblas-base libpapacke
$ wget https://github.com/rindow/rindow-matlib/releases/download/X.X.X/rindow-matlib_X.X.X_amd64.deb
$ sudo apt install ./rindow-matlib_X.X.X_amd64.deb
$ sudo update-alternatives --config librindowmatlib.so
There are 2 choices for the alternative librindowmatlib.so (providing /usr/lib/librindowmatlib.so).

  Selection    Path                                             Priority   Status
------------------------------------------------------------
* 0            /usr/lib/rindowmatlib-openmp/librindowmatlib.so   95        auto mode
  1            /usr/lib/rindowmatlib-openmp/librindowmatlib.so   95        manual mode
  2            /usr/lib/rindowmatlib-serial/librindowmatlib.so   90        manual mode

Press <enter> to keep the current choice[*], or type selection number: 2

$ cd \your\progject\directory
$ composer require rindow/rindow-math-matrix
$ composer require rindow/rindow-math-matrix-matlibffi
$ vendor/bin/rindow-math-matrix
Service Level   : Advanced
Buffer Factory  : Rindow\Math\Buffer\FFI\BufferFactory
BLAS Driver     : Rindow\OpenBLAS\FFI\Blas
LAPACK Driver   : Rindow\OpenBLAS\FFI\Lapack
Math Driver     : Rindow\Matlib\FFI\Matlib
```

