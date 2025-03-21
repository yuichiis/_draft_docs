---
layout: document
title: "PHPでのトランスフォーマーモデルを用いたニューラル機械翻訳"
upper_section: tutorials/tutorials
previous_section: tutorials/neural-machine-translation-with-attention
---
このチュートリアルでは、PHPでトランスフォーマーモデルを使用して、フランス語から英語への変換モデルを構築します。

トランスフォーマーモデルとは
-----------------------------

トランスフォーマーは、アテンションメカニズムを利用した翻訳モデルです。
自然言語処理だけでなく、様々なタスクに適用可能で、非常に強力なモデルです。
RNNブロックを使用せず、アテンションのみを使用しているため、並列計算の効率が向上し、高速な学習と推論が可能です。

![アテンションの画像](images/neural-machine-translation-attention.png)


事前準備
-------
開始する前に、Rindow Neural Networksをセットアップしてください。インストール手順は
[Rindow Neural Networksのインストール](/neuralnetworks/install.md)を参照してください。

PHPでもTransformerが十分に高速に動作することを体験してください。
Windows環境を使用している場合は、Rindow CLBlast / OpenCLの使用をお勧めします。

[PHPでの基本的な画像分類](basic-image-classification.html)チュートリアルを完了した方、または同等の知識を持っている方に向けています。

データセット
-------------
http://www.manythings.org/anki/ から提供される様々な言語のデータを使用します。
このデータには、英語の文と他の言語に翻訳された文のペアが含まれています。
このチュートリアルでは、英語とフランス語のデータセットを使用します。

例えば、以下のようになります。
```
Let me do that.       Laissez moi faire ça.
```
このデータをモデルに入力できるデータに変換します。

まず、文を英語とフランス語の文に分割し、それぞれの文の先頭と末尾にマーカーを追加します。

```
English:   <start> Let me do that. <end>
French:    <start> Laissez moi faire ça. <end>
```

次に、これをトークナイザーでシーケンスに変換します。
トークナイザー内で以下の処理が行われます。

+ 文から特殊文字を削除します。
+ 単語に分割します。
+ 単語辞書を作成します。
+ 単語を単語番号に変換してシーケンスを作成します。

変換されたシーケンスを最大長にパディングし、入力シーケンスが完成します。
フランス語のデータセットには190,000の文ペアがあるので、適切な場所でカットし、順序をシャッフルします。

これらのことを実行するコードを以下に示します。
```php
ここにデータセットクラスのコードが入る
```

データセットを作成してみましょう。
```php
ここにデータセットクラスをインスタンス化して、データをロードするコードが入る
```


Transformerモデルの構造
----------------------
Transformerモデルは、エンコーダーとデコーダーから構成されるエンコーダー・デコーダーモデルです。

エンコーダーは入力されたフランス語の文章を処理し、意味を抽出します。
デコーダーはエンコーダーから受け取った意味から英語の文章を生成します。
エンコーダー、デコーダーともに、内部に同様のブロックを6回繰り返す構造を持ちます。
チュートリアルのコードでは繰り返し回数を指定できるようになっています。

### ブロックの構造
各ブロックは、Multi-Head Attention、Feed Forward Network、Add & Layer Normalizationから構成されます。

- **Multi-Head Attention**: 入力情報の中で、どの情報に注目すべきかを判断し、処理する仕組みです。
- **Feed Forward Network**: 通常のニューラルネットワークで、系列ごとに適用されます。
- **Residual Connection(加算処理)とLayer Normalization**: 学習を安定化・高速化します。

![トランスフォーマーモデル](images/neural-machine-translation-transformer.png)

### ポジショナルエンベディング
入力はフランス語の文章で、単語をベクトルに変換したものが入力されます。
出力は英語の文章で、各単語の生成確率が出力されます。
入力と出力の教師データには、単語をベクトルに変換する処理（Embedding）と、位置情報を加える処理（Positional Encoding）が行われます。
このサンプルでは正弦波を用いたポジショナルエンコーディングをしています。


```php
ここにポジショナルエンベディングのコードが入る
```

位置情報がどのようにエンコーデングされてるか見てみましょう。
位置ごとに異なる数値が足される事が分かります。

```php
$plt = new Plot(null,$mo);

$numWords = 1000;
$maxLength = 16;
$depth = 16;
$embedding = new PositionalEmbedding(
    $nn,
    vocab_size:$numWords,
    d_model:$depth,
);
$positionalEncoding = $embedding->positionalEncoding($maxLength, $depth);
$positionalEncoding = $K->ndarray($positionalEncoding);
$plt->figure();
$plt->plot($positionalEncoding);
$plt->title('positional encoding');
$plt->show();
```

### Residual ConnectionとLayer Normalization

Residual Connectionは、深いニューラルネットワークにおいて、勾配消失問題を緩和し、学習を安定化させるために導入された手法です。各サブレイヤーの出力に、元の入力を加算することで、Residual Connectionを実現しています。
Layer Normalizationは、バッチサイズに依存せず、学習を安定化させることができます。


### マルチヘッドアテンション
Multi-Head Attentionは、入力情報を様々な角度から比較し、どこに注目すべきかを制御する機構です。

距離に関係なく、どの情報にも注目できるため、様々なタスクに応用可能です。
マルチヘッドアテンションの中核となるScaled Dot-Product Attentionは、クエリ（Query）とキー（Key）の内積を計算し、類似度を基にバリュー（Value）を重みづけして足し合わせます。
クエリとキーが類似している場合、対応するバリューが強く反映される仕組みです。
Multi-Headとあるように、入力を複数の異なる方法で複数回アテンションを計算し、それぞれの結果を結合することで、
様々な角度からの情報の比較を可能にしています。

Rindow Neural Networksではマルチヘッドアテンションを一つのレイヤーとして提供しています。
これによって簡単にマルチヘッドアテンションの強力な能力を簡単に使うことができます。

```php
ここに３つのマルチヘッドアテンションのコードが入る
```

### フィードフォワードネットワーク

Multi-Head Attentionの後に、フィードフォワードネットワークが配置されています。このネットワークは、各単語の埋め込みベクトルに対して、非線形な変換を適用し、モデルの表現力を高める役割を担っています。

```php
ここにフィードフォワードのコードが入る
```

### エンコーダーブロック
エンコーダーは入力されたフランス語の文章を処理し、意味を抽出します。

```php
ここにエンコーダーレイヤーとエンコーダーのコードが入る
```

### デコーダーブロック
デコーダーはエンコーダーから受け取った意味から英語の文章を生成します。

デコーダーブロックではMasked Multi-Head Attentionが使用されています。これはCausal Self-Attentionとして知られています。
通常の自己注意（Self-Attention）とは異なり、Causal Self-Attentionは、入力シーケンス内の過去の位置の情報のみを参照するように制限されています。つまり、ある位置の単語は、その位置より後の位置の単語の情報を見ることはできません。
この制限は、主にテキスト生成タスクにおいて重要です。テキスト生成では、過去に生成された単語に基づいて次の単語を生成する必要があるため、未来の情報を見てしまうと、生成されるテキストが不自然になってしまいます。Causal Self-Attentionは、このような未来の情報漏洩を防ぎ、自然なテキスト生成を可能にします。

出力の教師データ（ここでは英語の文）にこれを使うことで前の単語だけから影響を受けて続く単語を次々に予測できるようになります。

また、クロスアテンションでは、キーとバリューにエンコーダーの出力を使用し、クエリにデコーダーの入力を使用します。
出力の教師データのそれぞれのポジションごとに入力に関連性の高い情報が出力されます。

```php
ここにデコーダーレイヤーとデコーダーのコードが入る
```

### トランスフォーマーモデルの作成
組み合わせてトランスフォーマーモデルの作成を作成しましょう。

```php
ここにトランスフォーマーモデルのコードが入る
```

### 損失関数と指標関数

損失関数では不要部分の影響を受けないようにマスクしてから計算します。

また指標関数も同様にマスクします。
比較の対象のラベル値は出力の教師データから一つ先の単語を対象とします。
これにより予測すべき単語を教えることができます。

```php
ここに損失関数と指標関数とラベル作成のコードが入る
```

### トレーニング
トレーニングはラーニングレイトを徐々に下げていくためのスケジューラーを使用します。

```php
ここにスケジューラーとトレーニングのコードが入る
```

```
Generating data...
num_examples: 20000
num_words:
epoch: 10
batchSize: 64
embedding_dim: 256
num_heads: 8
dff: 512
num_layers: 4
Total questions: 20000
Input  word dictionary: 6814(6814)
Target word dictionary: 3294(3294)
Input length: 17
Output length: 9
device type: GPU
Compile model...
Layer(type)                  Output Shape               Param #
==================================================================
embedding.posemb.encoder.tran(17,256)                   1744384
mask.posemb.encoder.transform(17,256)                   0
mha.globalattn.enc_layer0.enc(17,256)                   2103552
layernorm.globalattn.enc_laye(17,256)                   512
add.globalattn.enc_layer0.enc(17,256)                   0
ff1.ffn.enc_layer0.encoder.tr(17,512)                   131584
ff2.ffn.enc_layer0.encoder.tr(17,256)                   131328
dropout.ffn.enc_layer0.encode(17,256)                   0
add.ffn.enc_layer0.encoder.tr(17,256)                   0
layernorm.ffn.enc_layer0.enco(17,256)                   512
mha.globalattn.enc_layer1.enc(17,256)                   2103552
layernorm.globalattn.enc_laye(17,256)                   512
add.globalattn.enc_layer1.enc(17,256)                   0
ff1.ffn.enc_layer1.encoder.tr(17,512)                   131584
ff2.ffn.enc_layer1.encoder.tr(17,256)                   131328
dropout.ffn.enc_layer1.encode(17,256)                   0
add.ffn.enc_layer1.encoder.tr(17,256)                   0
layernorm.ffn.enc_layer1.enco(17,256)                   512
mha.globalattn.enc_layer2.enc(17,256)                   2103552
layernorm.globalattn.enc_laye(17,256)                   512
add.globalattn.enc_layer2.enc(17,256)                   0
ff1.ffn.enc_layer2.encoder.tr(17,512)                   131584
ff2.ffn.enc_layer2.encoder.tr(17,256)                   131328
dropout.ffn.enc_layer2.encode(17,256)                   0
add.ffn.enc_layer2.encoder.tr(17,256)                   0
layernorm.ffn.enc_layer2.enco(17,256)                   512
mha.globalattn.enc_layer3.enc(17,256)                   2103552
layernorm.globalattn.enc_laye(17,256)                   512
add.globalattn.enc_layer3.enc(17,256)                   0
ff1.ffn.enc_layer3.encoder.tr(17,512)                   131584
ff2.ffn.enc_layer3.encoder.tr(17,256)                   131328
dropout.ffn.enc_layer3.encode(17,256)                   0
add.ffn.enc_layer3.encoder.tr(17,256)                   0
layernorm.ffn.enc_layer3.enco(17,256)                   512
dropout.encoder.transformer(D(17,256)                   0
embedding.posemb.decoder.tran(9,256)                    843264
mask.posemb.decoder.transform(9,256)                    0
dropout.decoder.transformer(D(9,256)                    0
mha.causalatten.dec_layer0.de(9,256)                    2103552
layernorm.causalatten.dec_lay(9,256)                    512
add.causalatten.dec_layer0.de(9,256)                    0
mha.crossAttn.dec_layer0.deco(9,256)                    2103552
layernorm.crossAttn.dec_layer(9,256)                    512
add.crossAttn.dec_layer0.deco(9,256)                    0
ff1.ffn.dec_layer0.decoder.tr(9,512)                    131584
ff2.ffn.dec_layer0.decoder.tr(9,256)                    131328
dropout.ffn.dec_layer0.decode(9,256)                    0
add.ffn.dec_layer0.decoder.tr(9,256)                    0
layernorm.ffn.dec_layer0.deco(9,256)                    512
mha.causalatten.dec_layer1.de(9,256)                    2103552
layernorm.causalatten.dec_lay(9,256)                    512
add.causalatten.dec_layer1.de(9,256)                    0
mha.crossAttn.dec_layer1.deco(9,256)                    2103552
layernorm.crossAttn.dec_layer(9,256)                    512
add.crossAttn.dec_layer1.deco(9,256)                    0
ff1.ffn.dec_layer1.decoder.tr(9,512)                    131584
ff2.ffn.dec_layer1.decoder.tr(9,256)                    131328
dropout.ffn.dec_layer1.decode(9,256)                    0
add.ffn.dec_layer1.decoder.tr(9,256)                    0
layernorm.ffn.dec_layer1.deco(9,256)                    512
mha.causalatten.dec_layer2.de(9,256)                    2103552
layernorm.causalatten.dec_lay(9,256)                    512
add.causalatten.dec_layer2.de(9,256)                    0
mha.crossAttn.dec_layer2.deco(9,256)                    2103552
layernorm.crossAttn.dec_layer(9,256)                    512
add.crossAttn.dec_layer2.deco(9,256)                    0
ff1.ffn.dec_layer2.decoder.tr(9,512)                    131584
ff2.ffn.dec_layer2.decoder.tr(9,256)                    131328
dropout.ffn.dec_layer2.decode(9,256)                    0
add.ffn.dec_layer2.decoder.tr(9,256)                    0
layernorm.ffn.dec_layer2.deco(9,256)                    512
mha.causalatten.dec_layer3.de(9,256)                    2103552
layernorm.causalatten.dec_lay(9,256)                    512
add.causalatten.dec_layer3.de(9,256)                    0
mha.crossAttn.dec_layer3.deco(9,256)                    2103552
layernorm.crossAttn.dec_layer(9,256)                    512
add.crossAttn.dec_layer3.deco(9,256)                    0
ff1.ffn.dec_layer3.decoder.tr(9,512)                    131584
ff2.ffn.dec_layer3.decoder.tr(9,256)                    131328
dropout.ffn.dec_layer3.decode(9,256)                    0
add.ffn.dec_layer3.decoder.tr(9,256)                    0
layernorm.ffn.dec_layer3.deco(9,256)                    512
final_layer.transformer(Dense(9,3294)                   846558
==================================================================
Total params: 30790366
Train model...
Train on 19800 samples
Epoch 1/10 [.........................] 1805 sec. remaining:00:00  - 1805 sec.
 loss:5.2529 accuracy:0.3671
Epoch 2/10 [.........................] 1800 sec. remaining:00:00  - 1800 sec.
 loss:2.8989 accuracy:0.5796
Epoch 3/10 [.........................] 1806 sec. remaining:00:00  - 1806 sec.
 loss:2.2105 accuracy:0.6482
Epoch 4/10 [.........................] 1812 sec. remaining:00:00  - 1812 sec.
 loss:1.8078 accuracy:0.6910
Epoch 5/10 [.........................] 1841 sec. remaining:00:00  - 1841 sec.
 loss:1.5020 accuracy:0.7273
Epoch 6/10 [.........................] 1859 sec. remaining:00:00  - 1859 sec.
 loss:1.2711 accuracy:0.7578
Epoch 7/10 [.........................] 1884 sec. remaining:00:00  - 1884 sec.
 loss:1.0935 accuracy:0.7803
Epoch 8/10 [.........................] 1817 sec. remaining:00:00  - 1817 sec.
 loss:0.9837 accuracy:0.7957
Epoch 9/10 [.........................] 1754 sec. remaining:00:00  - 1754 sec.
 loss:0.9184 accuracy:0.8023
Epoch 10/10 [.........................] 1653 sec. remaining:00:00  - 1653 sec.
 loss:0.8757 accuracy:0.8069
trainableVariables=172
Variables=174
Total training time: 05:00:31
```

![トレーニング履歴](images/transformer/transformer-training.png)


### 予測
学習済みモデルで機械翻訳を行いましょう。

最初に入力のフランス語の文と出力のスタートマークを与えて、
スタートマークの次に来る単語を予測します。
予測できた単語をスタートマークの次に足して、今度は入力とスタートマークと予測された単語をから
その次の単語を予測します。
この繰り返しで出力を最後まで予測します。

```php
ここにトランスレーターのコードが入る
```

サンプルデータを選んで翻訳してみましょう。

```php
ここにトランスレーターの実行のコードが入る
```

```
Input:   <start> j adore les chameaux . <end>
Predict: <start> i love camels . <end>
Target:  <start> i love camels . <end>

Input:   <start> j’ai de la fièvre . <end>
Predict: <start> i have a fever . <end>
Target:  <start> i have a fever . <end>

Input:   <start> es tu perdue ? <end>
Predict: <start> are you lost ? <end>
Target:  <start> are you lost ? <end>

Input:   <start> ne me charrie pas ! <end>
Predict: <start> don t kid away . <end>
Target:  <start> don t kid me ! <end>

Input:   <start> il est malade . <end>
Predict: <start> he is ill . <end>
Target:  <start> he is ill . <end>

Input:   <start> ils partirent tôt . <end>
Predict: <start> they left early . <end>
Target:  <start> they left early . <end>

Input:   <start> où est ma voiture  ? <end>
Predict: <start> where is my car ? <end>
Target:  <start> where is my car ? <end>

Input:   <start> traduis le . <end>
Predict: <start> let it it it . <end>
Target:  <start> translate it . <end>

Input:   <start> tom a changé . <end>
Predict: <start> tom has changed . <end>
Target:  <start> tom changed . <end>

Input:   <start> sois très prudente ! <end>
Predict: <start> be very careful . <end>
Target:  <start> be very careful . <end>
```
