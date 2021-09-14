---
layout: document
title: "Neural machine translation with attention on PHP"
---
このチュートリアルではPHP上のRecurrent Neural Network(RNN)とAttentionを使って、フランス語から英語に変換するモデルを構築します。

まず自然言語を取り扱う時によく使われるTokenizerにより文章をフランス語のSequenceと英語のSequenceに変換します。
あるSequenceから別のSequenceに変換するための学習モデルを、Sequence to sequence learningと呼びます。

この学習モデルの中でRecurrent Neural Network(RNN)とAttentionを使います。
さらにこのチュートリアルの中でAttentionはどの入力の部分がモデルの注意を引くかを表す様に使われます。人間と似たようなモデルを構築する事で変換の精度が上がります。


事前準備
-------
作業を始める前にRindow NeuralNetworksが動作するようにセットアップしてください。インストール手順は
[Rindow Neural Networks installation](/neuralnetworks/install.md)を参照してください。

PHPでもRNNに十分な速度で動作することを体験してください。
もしあなたがWindows環境を使用している場合は、Rindow CLBlast/OpenCLを活用することをお勧めします。

既に[Basic image clasification on PHP](basic-image-classification.html)のチュートリアルを終えられた方または同等の知識持つ方を対象とします。


データセット
----------------
http://www.manythings.org/anki/ によって様々な言語のデータが提供されています。
このデータは英語の文と他の言語に翻訳した文のペアを含んでいます。
このチュートリアルでは英語とフランス語のデータセットを使用します。

たとえばこんな感じ。
```
Let me do that.       Laissez moi faire ça.
```
このデータをモデルに入力可能なデータに変換します。

最初に英語の文とフランス語の文に分け、それぞれに文頭および文末のマーカーを付け加えます。
```
English:   <start> Let me do that. <end>
French:    <start> Laissez moi faire ça. <end>
```

次にこれをTokenizerによってSequenceに変換します。
Tokenizerの内部では以下の処理を行います。

+ 文からスペシャル文字を取り除く。
+ 単語に分割。
+ 単語辞書を作ります。
+ 単語を単語番号に変換しSequenceを作成
