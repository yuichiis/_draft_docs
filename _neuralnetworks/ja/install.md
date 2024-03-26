---
layout: document
title: "Rindow NeuralNetworksインストール"
---

- [動作環境](動作環境)
- [Windowsの場合のインストール手順](Windowsの場合のインストール手順)
- [Ubuntuの場合のインストール手順](Ubuntuの場合のインストール手順)
- [GPU/OpenCL support](GPU/OpenCL support)


動作環境
---------------------
Rindow Neural Networks は、次の動作環境でテストされています。

・PHP 8.1、8.2、8.3 (PHP 7.x,8.0環境で使用する場合は、Release 1.xをご利用ください。)
- Windows 10 20H2以降。
- Ubuntu 20.04、22.04
- AMD/Intel CPU/APU 64bit(SSE2以降)
- OpenBLAS (0.3.20 Windows-x64、0.3.20 Ubuntu-2204、0.3.8 Ubuntu-2004)
- CLBlast (1.5.2以降、Windows-x64、Ubuntu-2204、Ubuntu-2004)

また、Intel/AMD CPU/APU および OpenCL ドライバーを備えた統合グラフィックスでも動作します。


Windowsの場合のインストール手順
----------------------------------
PHPのインストール

Windows 10/11 の場合は、Windows 用 PHP をインストールします。

+ PHP x64 バージョンを https://windows.php.net/download/ からダウンロードします。Non Thread SafeバージョンとThread Safeバージョンのどちらでも構いません。
+ 選択した場所に解凍します。
+ php.ini-developmentをコピーしてphp.iniを作成します。
+ PHP.EXEの実行PATHを設定します。
+ PHP が PHP -v で動作することを確認します。

```shell
C:TEMP>COPY C:\php\php.ini-development C:\php\php.ini
あなたのお好みにphp.iniを編集。

C:TEMP>PATH %PATH%;C:\php
C:TEMP>php -v
PHP 8.3.4 (cli) (built: Mar 13 2024 11:42:47) (NTS Visual C++ 2019 x64)
Copyright (c) The PHP Group
Zend Engine v4.3.4, Copyright (c) Zend Technologies
    with Zend OPcache v8.3.4, Copyright (c), by Zend Technologies
C:TEMP>
```

composerをインストールします。

+ https://getcomposer.org/download/ からcomposerをダウンロードします。
+ composer.pharを実行PATHの設定されたディレクトリーにコピーします。
+ 同じ場所にcomposer.batを作ります。

```shell
C:TEMP>COPY composer.phar C:\bin
C:TEMP>CD \bin
C:bin>echo @php "%~dp0composer.phar" %*>composer.bat
```

Rindow Neural Networksに必要な PHP 拡張機能をインストールします。

+ https://github.com/xianyi/OpenBLAS/releases から対応するプレビルドバイナリファイル をダウンロードして解凍します。 
+ https://github.com/rindow/rindow-matlib/releases から対応するプレビルドバイナリファイル をダウンロードして解凍します。 
+ OpenBLASとRindow-MatlibのDLLパスを実行パスに設定します。
+ php.iniに必要な設定を行います。
     - memory_limit = 8G
     - extension = ffi
     - extension = gd
     - extension = mbstring
     - extension = openssl
     - extension = pdo_sqlite
     - extension = zip
+ PHP拡張 が PHP -m でロードされていることを確認してください。


```shell
C:TEMP>PATH %PATH%;C:\OpenBLAS\OpenBLAS-0.3.26-x64\bin
C:TEMP>PATH %PATH%;C:\Matlib\rindow-matlib-1.0.0-win64\bin
php.iniを編集
C:TEMP>php -m
[PHP Modules]
...
ffi
...
pdo_sqlite
...
C:TEMP>
```

Rindow NeuralNetworksをインストールします。

+ あなたのプロジェクトディレクトリを作成します。
+ composerでrindow/rindow-neuralnetworksをインストールします。
+ 高速化の為にcomposerでrindow/rindow-math-matrlix-matlibffiをインストールします。
+ グラフ表示の為にcomposerでrindow/rindow-math-plotをインストールします。
+ rindow-math-matrlixの状態がAdvancedかAcceleratedになっていることを確認します。

```shell
C:TEMP>MKDIR \tutorials
C:TEMP>CD \tutorials
C:tutorials>composer require rindow/rindow-neuralnetworks
C:tutorials>composer require rindow/rindow-matrlix-matlibffi
C:tutorials>vendor/bin/rindow-math-matrix
Service Level   : Advanced
Buffer Factory  : Rindow\Math\Buffer\FFI\BufferFactory
BLAS Driver     : Rindow\OpenBLAS\FFI\Blas
LAPACK Driver   : Rindow\OpenBLAS\FFI\Lapack
Math Driver     : Rindow\Matlib\FFI\Matlib
```

サンプルプログラムを実行

+ サンプルを実行して動作確認します。
+ 結果がグラフ表示されます。


```shell
C:tutorials>MKDIR samples
C:tutorials>CD samples
C:tutorials\samples>COPY ..\vendor\rindow\rindow-neuralnetworks\samples\* .
C:tutorials\samples>php mnist-basic-clasification.php
Downloading train-images-idx3-ubyte.gz ...Done
....
Epoch 4/5 [.........................] 1 sec. remaining:00:00  - 2 sec.
 loss:0.1264 accuracy:0.9640 val_loss:0.1246 val_accuracy:0.9604
Epoch 5/5 [.........................] 1 sec. remaining:00:00  - 2 sec.
 loss:0.1054 accuracy:0.9698 val_loss:0.1129 val_accuracy:0.9675
グラフ表示されます
```

Ubuntuの場合のインストール手順
-----------------------------------------
phpをインストールします。

+ apt コマンドでphp-cliとphp-mbstringとunzipをインストールします。

```shell
$ sudo apt install php-cli8.3 php8.3-mbstring php8.3-curl php8.3-sqlite3 php8.3-gd php8.3-xml php8.3-opcache unzip
$ php -v
PHP 8.3.4 (cli) (built: Mar 16 2024 08:40:08) (NTS)
Copyright (c) The PHP Group
Zend Engine v4.3.4, Copyright (c) Zend Technologies
    with Zend OPcache v8.3.4, Copyright (c), by Zend Technologies
```

composerをインストールします。

+ https://getcomposer.org/download/ からcomposerをダウンロードします。
+ composer.pharを実行PATHの設定されたディレクトリーにコピーします。
+ 同じ場所にcomposerを作ります。

```shell
$ cp composer.phar ~/.local/bin
$ cd ~/.local/bin
$ cat > composer
#!/usr/bin/env sh
dir=$(cd "${HOME}/.local/bin" && pwd)
php "${dir}/composer.phar" "$@"
^Z
$ chmod +x composer
$ composer -V
Composer version 2.6.6 2023-12-08 18:32:26
```


Rindow NeuralNetworksに必要なライブラリをインストールします。

+ OpenBLASをaptコマンドでインストール
+ https://github.com/rindow/rindow-matlib/releases からRindow-Matlibのプレビルドバイナリファイルの最新バージョンをダウンロードします。
+ ダウンロードしたdebファイルをaptコマンドでインストールします。
+ PHPで使えるようにRindow-Matlibをserialモードに設定します。

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

Rindow NeuralNetworksをインストールします。

+ rindow-math-plotの画像表示コマンドを設定します。
+ あなたのプロジェクトディレクトリを作成します。
+ composerでrindow/rindow-neuralnetworksをインストールします。
+ 高速化の為にcomposerでrindow/rindow-math-matrix-matlibffiをインストールします。
+ グラフ表示の為にcomposerでrindow/rindow-math-plotをインストールします。
+ rindow-math-matrlixの状態がAdvancedかAcceleratedになっていることを確認します。

```shell
$ RINDOW_MATH_PLOT_VIEWER=/some/bin/dir/png-file-viewer
$ export RINDOW_MATH_PLOT_VIEWER
$ mkdir ~/tutorials
$ cd ~/tutorials
$ composer require rindow/rindow-neuralnetworks
$ composer require rindow/rindow-math-plot
$ vendor/bin/rindow-math-matrix
Service Level   : Advanced
Buffer Factory  : Rindow\Math\Buffer\FFI\BufferFactory
BLAS Driver     : Rindow\OpenBLAS\FFI\Blas
LAPACK Driver   : Rindow\OpenBLAS\FFI\Lapack
Math Driver     : Rindow\Matlib\FFI\Matlib
```

サンプルプログラムを実行

+ サンプルを実行して動作確認します。
+ 結果がグラフ表示されます。

```shell
$ mkdir samples
$ cd samples
$ cp ../vendor/rindow/rindow-neuralnetworks/samples/* .
$ php mnist-basic-clasification.php
Downloading train-images-idx3-ubyte.gz ...Done
....
Epoch 4/5 ........................ - 10 sec.
 loss:0.1276 accuracy:0.9641 val_loss:0.1162 val_accuracy:0.9649
Epoch 5/5 ........................ - 11 sec.
 loss:0.1063 accuracy:0.9703 val_loss:0.1059 val_accuracy:0.9688
```
Note: Specify "viewnior" etc. for RINDOW_MATH_PLOT_VIEWER

結果がグラフ表示されます。

![Result](images/gettingstarted-result.png)

GPU/OpenCL support for Windows
------------------------------
Windowsは標準でOpenCLが使える状態です。

CLBlastライブラリをダウンロードして実行パスを設定してください。

- [CLBlast library](https://github.com/CNugteren/CLBlast/releases)

```shell
C:TEMP>PATH %PATH%;C:\CLBlast\CLBlast-1.6.2-Windows-x64\bin
```

rindow-neuralnetworksのバックエンドでOpenCLを使用するように設定します。

+ rindow-math-matrixがAcceleratedになり、OpenCLのドライバーが認識されていることを確認します。
+ rindow-neuralnetworksのバックエンドでGPUを使うように環境変数に設定します。
+ サンプルプログラムを実行します。


```shell
C:tutorials>vendor\bin\rindow-math-matrix
Service Level   : Accelerated
Buffer Factory  : Rindow\Math\Buffer\FFI\BufferFactory
BLAS Driver     : Rindow\OpenBLAS\FFI\Blas
LAPACK Driver   : Rindow\OpenBLAS\FFI\Lapack
Math Driver     : Rindow\Matlib\FFI\Matlib
OpenCL Factory  : Rindow\OpenCL\FFI\OpenCLFactory
CLBlast Factory : Rindow\CLBlast\FFI\CLBlastFactory

C:tutorials>SET RINDOW_NEURALNETWORKS_BACKEND=rindowclblast::GPU
C:tutorials>cd samples
C:samples>php basic-image-clasification.php
```
注: RINDOW_NEURALNETWORKS_BACKEND は、rindowclblast などの名前に加えて、OpenCL デバイス タイプ、またはプラットフォーム ID とデバイス ID のセットを指定できます。GPUが2個以上ある場合にはこの指定方法を使って特定できます。 例えば;

- rindowclblast       => platform #0, device #0
- rindowclblast::GPU  => GPU type device: Integrated GPU, etc.
- rindowclblast::CPU  => CPU type device: pocl-opencl-icd, etc.
- rindowclblast::0,0  => platform #0, device #0
- rindowclblast::0,1  => platform #0, device #1
- rindowclblast::1,0  => platform #1, device #0

もし、うまくターゲットのGPUに設定できない場合はclinfoコマンドでOpenCLのデバイスの状態を確認しください。
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
OpenCL が Linux 環境で正しく動作することが大前提です。 
（それはかなり難しいことです）

OpenCL環境をインストールします。

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

Linux標準のOpenCLドライバーはまともに動作しないので、ドライバーやバージョンごとに何とか動くように臨機応変に対処します。

clinfoコマンドでOpenCLが動作していることを確認してください。
```shell
$ clinfo
Number of platforms                               1
  Platform Name                                   Intel Gen OCL Driver
  Platform Vendor                                 Intel
....
...
..
```

CLBlastライブラリをダウンロードしてインストールしてください。
ダウンロードとインストールを簡単にするためのスクリプトを使用できます。

+ 最新バージョンを確認: [CLBlast library](https://github.com/CNugteren/CLBlast/releases)
+ スクリプトをコピー
+ スクリプトの先頭にあるバージョンを変更
+ スクリプトを実行してdebファイルを作成
+ debファイルをインストール

```shell
$ cp vendor/rindow/rindow-clblast-ffi/clblast-packdeb.sh .
$ vi clblast-packdeb.sh
CLBLASTVERSION=1.6.2   <===== 変更
$ sh clblast-packdeb.sh
$ sudo apt install ./clblast_X.X.X-1+ubuntuXX.XX_amd64.deb
```

