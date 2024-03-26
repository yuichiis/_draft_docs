概要
--------
OpenCL を最初に選択したのは、GPU を含むさまざまな算術アクセラレーションをサポートしているためです。
これにより、安価なノートPC環境でもGPUの高速化が期待できます。

数値演算を高速化するには、OpenCL のサポートだけでなく、OpenCL を使用した演算ライブラリも必要です。 CLBlast は、現在開発が進められている BLAS 互換ライブラリです。
これに加えて、Rindow Math Matrix では、それ以外のMATH関数やさまざまな必要な操作をOpenCL上でできるようにしています。

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

- PHP8.1 または PHP8.2 または PHP8.3
- interop-phpobjects/polite-math 1.0.6以降
- OpenCL 1.1 以降の ドライバー/ライブラリ。
- Windows 10、11またはLinux(Ubuntu 20.04以降)
- Rindow Math Matrix
- Rindow Math Buffer FFI
- Rindow OpenBLAS FFI
- Rindow Matlib FFI
- Rindow OpenCL FFI
- Rindow CLBlast FFI
- OpenBLAS 0.3.20 以降
- CLBlast 1.5.2 以降

GPU/OpenCL support for Windows
------------------------------
OpenCL can be used by default on Windows.

Please download the pre-build binaries and set the execution path.

- [OpenBLAS](https://github.com/OpenMathLib/OpenBLAS/releases)
- [Rindow Matlib](https://github.com/rindow/matlib/releases)
- [CLBlast](https://github.com/CNugteren/CLBlast/releases)

```shell
C:TEMP>PATH %PATH%;C:\CLBlast\bin;C:\OpenBLAS\bin;C:\Matlib\bin
```

Configure the PHP. Edit php.ini to use FFI extension

```shell
extension = ffi
```

Set up rindow-math-matrix to use OpenCL using composer. And make sure you are in Advanced mode.

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
If you are unable to successfully set the target GPU, please check the OpenCL device status using the clinfo command.

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


GPU/OpenCL support for Ubuntu
------------------------------
Install the libraries required.

+ Install OpenBLAS with apt command
+ Download the latest version of Rindow-Matlib's pre-built binary files from https://github.com/rindow/rindow-matlib/releases.
+ Install the downloaded deb file using the apt command.
+ Set Rindow-Matlib to serial mode for use with PHP.

```shell
$ sudo apt install libopenblas-base liblapacke
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
```

It is essential that OpenCL works properly in the Linux environment.
(That's quite difficult)

Install the OpenCL environment.

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

Download and install the CLBlast library.
Scripts are available for easy download and installation.

+ Check the latest version: [CLBlast library](https://github.com/CNugteren/CLBlast/releases)
+ Copy script
+ Change the version at the beginning of the script
+ Run script and create deb file
+ Install deb file

```shell
$ cp vendor/rindow/rindow-clblast-ffi/clblast-packdeb.sh .
$ vi clblast-packdeb.sh
CLBLASTVERSION=1.6.2   <===== change
$ sh clblast-packdeb.sh
$ sudo apt install ./clblast_X.X.X-1+ubuntuXX.XX_amd64.deb
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
