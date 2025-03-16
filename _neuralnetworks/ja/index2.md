---
layout: document
title: "Rindow Neural Networks"
meta_description: "Rindow Neural NetworksはPHP用の高レベルニューラルネットワークライブラリです。Kerasに似た記述方法を使用して、Pythonと同様にPHPで機械学習モデルを記述できることを目指しています。"
next_section: gettingstarted
---

<div class="container">
  <div class="row">
    <div class="col-lg-4">
      <img class="bd-placeholder-img rounded" width="200" height="200" alt="簡単に構築" src="images/easy-to-build.png">
      <h3>簡単に構築</h3>
      <p>豊富なDNN、CNN、RNN、(マルチヘッド)アテンションなどのコンポーネントを組み合わせて、簡単にモデルを構築できる高次元ニューラルネットワークライブラリです。</p>
    </div><!-- /.col-lg-4 -->
    <div class="col-lg-4">
      <img class="bd-placeholder-img rounded" width="200" height="200" alt="簡単に確認" src="images/easy-to-check.png">
      <h3>簡単に確認</h3>
      <p>モデルのトレーニングが簡単で、学習過程をグラフ化するための周辺ツールも利用可能です。</p>
    </div><!-- /.col-lg-4 -->
    <div class="col-lg-4">
      <img class="bd-placeholder-img rounded" width="200" height="200" alt="簡単に加速" src="/assets/themes/rindow/img/gears.svg">
      <h3>簡単に加速</h3>
      <p>TensorflowのCPUバージョンと同等の速度を持つPHP FFIと、NVidiaなしで動作するGPUアクセラレーションが利用可能です。</p>
    </div><!-- /.col-lg-4 -->
  </div><!-- /.row -->
  <div class="row">
    <div class="col-lg-4">
        <p>.</p>
    </div><!-- /.col-lg-4 -->
  </div><!-- /.row -->
</div><!-- /.container -->


Rindow Neural Networksとは
--------------------------
Rindow Neural NetworksはPHP用の高レベルニューラルネットワークライブラリです。
PHPで強力な機械学習を実現できます。

- DNN、CNN、RNN、アテンションの機械学習モデルを構築できます。
- PythonとKerasの知識をそのまま活用できます。
- 人気のあるコンピュータビジョンや自然言語処理のサンプルが利用可能です。
- 高速計算ライブラリを呼び出すことで、TensorFlowのCPUバージョンと同等の速度でデータを処理できます。
- 専用の機械学習環境は不要です。安価なノートパソコンでも実行可能です。
- 興味深いサンプルプログラムが付属しています。

目標は、PythonのKerasに似た方法でPHPで機械学習モデルを簡単に作成できるようにすることです。

OpenBLASとRindow-Matlibを使用すると、
TensorFlowのCPUバージョンに近い速度で計算できます。
ノートパソコンでトレーニングされた事前トレーニング済みモデルが人気のあるウェブホスティングで利用可能です。
人気のあるPHPウェブホスティングサービスでディープラーニングの恩恵を受けることもできます。

OpenCLとCLblastを使用したGPUアクセラレーションをサポートしています。安価なノートパソコンに統合されたGPUを活用できます。NVidiaグラフィックスカードは不要です。

以下の機能があります。

- 高レベルのニューラルネットワークの記述
- 高速計算ライブラリとの連携
- 計算ライブラリの拡張性を考慮した設計
- 開発者がこのライブラリの使い方を学ぶ時間を節約するためにKerasに似たインターフェースを採用

Rindow Neural Networksは通常、以下と連携して動作します。

- Rindow-Matlib: 機械学習に適した科学的行列計算ライブラリ
- OpenBLAS: 最も人気のある高速行列計算ライブラリ
- Rindow Math Plot: 機械学習の結果を視覚化
- OpenCL: GPUプログラミングのためのフレームワーク
- CLBlast: GPU上のBLAS (OpenCL)

サンプルプログラム
-------------------
<div class="container">
  <div class="row">
    <div class="col-lg-4">
      <img class="bd-placeholder-img rounded" width="200" height="200" alt="サンプル1" src="images/basic-classification.png">
    </div><!-- /.col-lg-4 -->
    <div class="col-lg-4">
      <img class="bd-placeholder-img rounded" width="200" height="200" alt="サンプル2" src="images/easy-to-check.png">
    </div><!-- /.col-lg-4 -->
    <div class="col-lg-4">
      <img class="bd-placeholder-img rounded" width="200" height="200" alt="サンプル3" src="images/neural-machine-translation.png">
    </div><!-- /.col-lg-4 -->
  </div><!-- /.row -->
</div><!-- /.container -->

- 全結合ニューラルネットワーク(FNN)による基本的な画像分類
- 畳み込みニューラルネットワーク(CNN)による画像分類
- リカレントニューラルネットワーク(RNN)による数値加算テキスト生成
- アテンション(RNN with Attention)によるニューラル機械翻訳
- トランスフォーマーモデルによるニューラル機械翻訳


チュートリアル
---------------
ステップバイステップのチュートリアルを作成する予定です。

[PHPでの機械学習チュートリアル](tutorials/tutorials.html)ページをご覧ください。

- [基本的な画像分類](tutorials/basic-image-classification.html)
- [畳み込みニューラルネットワーク(CNN)](tutorials/convolution-neural-network.html)
- [PHPでのseq2seqによる数値加算の学習](tutorials/learn-add-numbers-with-rnn.html)
- [PHPでのアテンションによるニューラル機械翻訳](tutorials/neural-machine-translation-with-attention.html)


なぜPHPでディープラーニングを行うのか？
----------------------------------------

> - "ディープラーニングを行いたいなら、Pythonを使うべきです。"
> - “Pythonを学べばいいだけです！”
> - "Pythonは素晴らしい機械学習の開発環境ではないですか？"

その通りです。

では、なぜPython以外は使うことができないのでしょうか？

ディープラーニングのためにプラットフォームに制約される必要がありますか？
絶対に必要ありません！

ディープラーニング/MLはシステム全体の一部に過ぎません。これはライブラリ内の小さな機能群に過ぎません。
"Hello!"と出力するだけで、誰でもどこでも使用できます。

PHPを使用できないのは不自然です。


要件
----

- PHP 8.1, 8.2, 8.3, 8.4 (PHP 7.xおよび8.0で使用したい場合は、バージョン1.xを使用してください。)
- OpenBLASおよびRindow-Matlibを使用するには、Windows 10/11またはUbuntu 22.04またはDebian 12、またはそれ以降が必要です。
- Rindow Math Matrix

推奨
----

- Rindow Math Plot (結果をグラフで表示)
- GD / GD2 拡張 (グラフ表示に使用)
- pdo_sqlite 拡張 (トレーニング済みモデルの保存に使用)
- FFI 拡張 (高速な計算に使用)
- OpenBLAS/Rindow-Matlib (高速な計算に使用)
- OpenCL/CLBlast (GPUアクセラレーション)

リリースノート
---------------
各種リリースノートは以下の通りです

- [Rindow Neuralnetworks](https://github.com/rindow/rindow-neuralnetworks/releases)
- [Rindow Math Matrix](https://github.com/rindow/rindow-math-matrix/releases)
- [Rindow Matlib](https://github.com/rindow/rindow-matlib/releases)

注意
----
このニューラルネットワークライブラリは始まったばかりです。まだ不足している機能がたくさんあることを理解しています。ご容赦ください。

現在、Rindow Neural NetworksはRindowフレームワークをサポートしていません。通常のPHPプログラミングのようにスタンドアロンでオブジェクトのライフサイクルを管理します。将来的にはRindowフレームワークで利用可能になります。

このテキストは機械翻訳を使用して書かれています。ネイティブの英語話者がテキストを修正するのを助けてくれることを願っています。
