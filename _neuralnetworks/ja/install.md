---
layout: document
title: "Rindow NeuralNetworksインストール"
---

- [動作環境](動作環境)
- [Windowsの場合のインストール手順](Windowsの場合のインストール手順)
- [Ubuntuの場合のインストール手順](Ubuntuの場合のインストール手順)
- [GPU/OpenCL support](GPU/OpenCL support)



動作環境
-----------------------------------------
Rindow NeuralNetworksは以下の動作環境でテストしています。

- PHP 7.2, 7.3, 7.4
- Windows 10 20H2
- Ubuntu 18.04, 20.04
- AMD CPU/APU 64bit(SSE2)
- OpenBLAS (0.3.13 Windows-x64, 0.3.8 Ubuntu2004, 0.2.20 Ubuntu1804)

Intel CPUでも動作するでしょう。

Windowsの場合のインストール手順
-----------------------------------------
PHPのインストール

Windows10では、Windows版PHPをインストールします。

+ https://windows.php.net/download/ から PHP7.4(または7.2,7.3) x64 Thread Safe版をダウンロードしてください。
+ お好みの場所に解凍します。
+ php.ini-developmentをコピーしてphp.ini作成します。
+ PHP.EXEに対する実行PATHを設定します。
+ PHP -vでPHPが動作することを確かめてください。

```shell
C:TEMP>COPY C:\php\php74\php.ini-development C:\php\php74\php.ini
あなたのお好みにphp.iniを編集。
C:TEMP>PATH %PATH%;C:\php\php74
C:TEMP>php -v
PHP 7.4.13 (cli) (built: Nov 24 2020 12:43:32) ( ZTS Visual C++ 2017 x64 )
Copyright (c) The PHP Group
Zend Engine v3.4.0, Copyright (c) Zend Technologies
    with Zend OPcache v7.4.13, Copyright (c), by Zend Technologies
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

Rindow NeuralNetworksに必要なPHP拡張をインストールします。

+ https://github.com/rindow/rindow-openblas/releases から最新バージョンのrindow_openblasをダウンロードして解凍します。
+ https://github.com/xianyi/OpenBLAS/releases から対応するリリース番号のOpenBLASをダウンロードして解凍します。
+ 実行パスにOpenBLASのDLLのパスを設定しします。
+ php_rindow_openblas.dllをPHPのextディレクトリコピーします。
+ php.iniに必要な設定をします。
    - memory_limit = 8G
    - extension=rindow_openblas
    - extension=pdo_sqlite
    - extension=gd2
    - extension=mbstring
    - extension=openssl
+ PHP -mでrindow_openblasがロードされている事を確認します。

```shell
C:TEMP>PATH %PATH%;C:\OpenBLAS\OpenBLAS-0.3.13-x64\bin
C:TEMP>COPY php_rindow_openblas-0.1.6-7.4-ts-vc15-x64\php_rindow_openblas.dll C:\php\php-7.4.13-Win32-vc15-x64\ext
php.iniを編集
C:TEMP>php -m
[PHP Modules]
...
pdo_sqlite
...
rindow_openblas
...
C:TEMP>
```

Rindow NeuralNetworksをインストールします。

+ あなたのプロジェクトディレクトリを作成します。
+ composerでrindow/rindow-neuralnetworksをインストールします。
+ グラフ表示の為にcomposerでrindow/rindow-math-plotをインストールします。
+ サンプルを実行して動作確認します。
+ 結果がグラフ表示されます。

```shell
C:TEMP>MKDIR \tutorials
C:TEMP>CD \tutorials
C:tutorials>composer require rindow/rindow-neuralnetworks
C:tutorials>MKDIR samples
C:tutorials>CD samples
C:tutorials\samples>COPY ..\vendor\rindow\rindow-neuralnetworks\samples\* .
C:tutorials\samples>php mnist-basic-clasification.php
Downloading train-images-idx3-ubyte.gz ...Done
....
Epoch 4/5 ........................ - 10 sec.
 loss:0.1276 accuracy:0.9641 val_loss:0.1162 val_accuracy:0.9649
Epoch 5/5 ........................ - 11 sec.
 loss:0.1063 accuracy:0.9703 val_loss:0.1059 val_accuracy:0.9688
グラフ表示されます
```

Ubuntuの場合のインストール手順
-----------------------------------------
phpをインストールします。

+ apt コマンドでphp-cliとphp-mbstringとunzipをインストールします。

```shell
$ sudo apt install php-cli7.4 php7.4-mbstring php7.4-sqlite3 php7.4-gd unzip
$ php -v
PHP 7.4.3 (cli) (built: Oct  6 2020 15:47:56) ( NTS )
Copyright (c) The PHP Group
Zend Engine v3.4.0, Copyright (c) Zend Technologies
    with Zend OPcache v7.4.3, Copyright (c), by Zend Technologies
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
Composer version 2.0.8 2020-12-03 17:20:38
```


Rindow NeuralNetworksに必要なPHP拡張をインストールします。

+ https://github.com/rindow/rindow-openblas/releases から最新バージョンのrindow_openblasをダウンロードします。
+ ダウンロードしたdebファイルをaptコマンドでインストールします。
+ PHP -mでrindow_openblasがロードされている事を確認します。

```shell
$ sudo apt install ./rindow-openblas-php7.4_0.2.0-1+ubuntu20.04_amd64.deb
$ php -m
[PHP Modules]
...
rindow_openblas
...
```

Rindow NeuralNetworksをインストールします。

+ rindow-math-plotの画像表示コマンドを設定します。
+ あなたのプロジェクトディレクトリを作成します。
+ composerでrindow/rindow-neuralnetworksをインストールします。
+ グラフ表示の為にcomposerでrindow/rindow-math-plotをインストールします。
+ サンプルを実行して動作確認します。
+ 結果がグラフ表示されます。

```shell
$ RINDOW_MATH_PLOT_VIEWER=/some/bin/dir/png-file-viewer
$ export RINDOW_MATH_PLOT_VIEWER
$ mkdir ~/tutorials
$ cd ~/tutorials
$ composer require rindow/rindow-neuralnetworks
$ composer require rindow/rindow-math-plot
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
結果がグラフ表示されます。

![Result](images/gettingstarted-result.png)

GPU/OpenCL support
------------------

Download binaries and setup PHP extension and libraries.

- [Rindow OpenCL extension](https://github.com/rindow/rindow-opencl/releases)
- [Rindow CLBlast extension](https://github.com/rindow/rindow-clblast/releases)
- [CLBlast library](https://github.com/CNugteren/CLBlast/releases)

Set environment variable.

```shell
C:tutorials>RINDOW_NEURALNETWORKS_BACKEND=clblast
C:tutorials>export RINDOW_NEURALNETWORKS_BACKEND
C:tutorials>cd samples
C:samples>php mnist-basic-clasification.php
```
