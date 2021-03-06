Rindow Neural Networksは、PHP用の高レベルのニューラルネットワークライブラリです。
PHPで強力な機械学習を実現できます。

-DNN、CNN、RNN、およびアテンションの機械学習モデルを構築できます。
--PythonとKerasの知識をそのまま使用できます。
-人気のあるコンピュータビジョンと自然言語処理のサンプルが利用可能です。
-PHP拡張機能は、TensorFlow CPUバージョンの2倍の速度でデータを処理できます。
-専用の機械学習環境は必要ありません。それは安価なラップトップで行うことができます。
-面白いサンプルプログラムがついています。

目標は、PythonのKerasと同じように、PHPで機械学習モデルを簡単に作成できるようにすることです。

rindow_openblas php拡張機能を使用する場合、
CPUバージョンのテンソルフローに近い速度で計算できます。
ラップトップでトレーニングされたトレーニング済みモデルは、一般的なWebホスティングで利用できます。
また、人気のあるPHPWebホスティングサービスに関するディープラーニングの恩恵を受けることもできます。

rindow_clblasでOpenCLを使用したGPUアクセラレーションをサポートします。これは実験的な試みです。速度はまだそれほど速くありません。 Windows版とのみ互換性があります。

以下の特徴があります。

-高レベルのニューラルネットワークの説明
-高速オペレーションライブラリとの連携
-操作ライブラリのスケーラビリティを考慮した設計
-開発者がこのライブラリの使用方法を学ぶ時間を節約するために、Kerasと同様のインターフェースを採用しています。

Rindowニューラルネットワークは通常、次のものと連携します。

-Rindow Math Matrix：科学的な行列演算ライブラリ
-Rindow OpenBLAS拡張機能：OpenBLASのPHP拡張機能
-Rindow Math Plot：機械学習の結果を視覚化する
-Rindow CLBlast拡張機能：GPU上のBLASのPHP拡張機能（OpenCL）

サンプルプログラム
----------------

- Images basic classification with Full-connected Neural Networks(FNN)
- Images classification with Convolution Neural Networks(CNN)
- Numeric addition text generation with Recurrent Neural Networks(RNN)
- Neural machine language translation with Attention(RNN with Attention)

なぜPHPでディープラーニングを行うのですか？
------------------------------

>-「ディープラーニングを行う場合は、Pythonを使用する必要があります。」
>-「とにかくPythonを勉強することはできません。」
>-「Pythonは優れたディープラーニングフレームワークではありませんか？」

あなたの言うことは正しいです。

では、なぜPythonを使用する必要があるのでしょうか。

ディープラーニングのためにプラットフォームに制約を課す必要がありますか？
必要ありません！

ディープラーニング/ MLは、システム全体のごく一部にすぎません。これは、ライブラリ内の関数のほんの小さなグループです。
「Hello！」を印刷するだけでなく、誰でもどこでも使用できるはずです。

PHPを使用できないのはもっと不自然です。


要件
------------

-PHP7.2以降。
-rindow_openblas拡張機能を使用するには、Windows10またはLinux環境が必要です。

注意
--------
このニューラルネットワークライブラリはまだ始まったばかりです。私はそれがまだ不足していることを理解しています。憐れんでください。

現在、Rindow NeuralNetworksはRindowフレームワークをサポートしていません。通常のPHPプログラミングと同様に、スタンドアロンの方法でオブジェクトのライフサイクルを管理します。将来的にはRindowフレームワークで利用できるようになります。

このテキストは機械翻訳を使用して書かれています。英語を母国語とする人がテキストの修正に役立つことを願っています。
