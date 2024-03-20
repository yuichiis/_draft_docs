Rindow ニューラルネットワークライブラリ
====================================

Rindow ニューラルネットワークライブラリは、ディープラーニング用の高レベルなニューラルネットワークライブラリです。

概要
----

Python の Keras のように、PHP で簡単にネットワークモデルを書くことができます。

ウェブサイト：
- Rindow プロジェクト: https://rindow.github.io/
- Rindow ニューラルネットワーク: https://rindow.github.io/neuralnetworks

高速化
-----

外部ライブラリのrindow-matlibやOpenBLASを使用すると、TensorFlow の CPU バージョンに近い速度で計算できます。
ラップトップで学習させたモデルは、一般的なウェブホスティングで利用できます。
人気の PHP ウェブホスティング サービスでもディープラーニングを利用できます。

GPU アクセラレーション
--------------------
OpenCL を使った GPU アクセラレーションに対応しています。
OpenCLに対応していればn-vidia以外のGPUでも使うことができます。あなたのラップトップパソコンに搭載されたインテグレーションGPUでも利用可能です。


連携ライブラリ
--------------------
Rindow Math Matrix: 科学技術計算ライブラリ
Rindow Matlib: 機械学習に適した高速行列演算ライブラリー
OpenBLAS: 高速行列演算ライブラリー
Rindow Math Plot: 機械学習結果の可視化
OpenCL: GPU演算プログラミングインターフェース
CLBlast: OpenCLを使った高速行列演算ライブラリー

必要環境
--------------------

PHP 8.1、8.2、8.3
PHP 7.x 環境の場合は、Release 1.x を使用してください。

インストール
--------------------

Composer を使ってインストールしてください。
$ composer require rindow/rindow-neuralnetworks
$ composer require rindow/rindow-math-plot

そのまま使用すると学習時間がかかります。高速化のため、高速演算ライブラリーを導入することを強く推奨します。


外部ライブラリをセットアップしてください。
プリビルドバイナリ：
- Rindow-matlib: https://github.com/rindow/rindow-matlib/releases
- OpenBLAS: https://github.com/xianyi/OpenBLAS/releases

$ composer require rindow/rindow-math-matlibffi

メモリ拡張
--------------------
使用するデータ量に応じて、PHP が使用する最大メモリ量を増やす必要があります。

特に画像データを扱う場合、サンプルデータ量が膨大になり、想像以上にメモリ容量が必要になります。

例えば、php.ini の memory_limit を次のように変更してください。

memory_limit = 8G

モデル記述
--------------------

サンプルディレクトリには、簡単な画像学習のソースコードが用意されています。

次のように実行してください。

$ RINDOW_MATH_PLOT_VIEWER=/パス/への/ビューアー
$ export RINDOW_MATH_PLOT_VIEWER
$ mkdir samples
$ cd samples
$ cp ../vendor/rindow/rindow-neuralnetworks/samples/basic-image-clasification.php .
$ php basic-image-clasification.php
※ RINDOW_MATH_PLOT_VIEWER には適切なビューアーを指定してください。

正しく実行できれば、学習過程のグラフが表示されます。


GPU/OpenCL サポート
--------------------

バイナリをダウンロードしてください。
- CLBlast: https://github.com/CNugteren/CLBlast/releases

バイナリーファイルを環境に合わせてセットアップしてください。
詳しい手順はこちらhttps://github.com/rindow/rindow-math-matrix-matlibffi/

環境変数を設定してください。

$ RINDOW_NEURALNETWORKS_BACKEND=rindowclblast::GPU
$ export RINDOW_NEURALNETWORKS_BACKEND
$ cd samples
$ php basic-image-classification.php

※ RINDOW_NEURALNETWORKS_BACKEND には、rindowclblast などの名前だけでなく、OpenCL デバイスの種類や Platform-ID と Device-ID のセットを指定できます。例えば、"rindowclblast::GPU" または "rindowclblast::0,0"

