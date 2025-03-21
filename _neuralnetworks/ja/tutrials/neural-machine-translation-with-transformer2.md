---
layout: document
title: "PHPでのTransformerモデルを用いたニューラル機械翻訳"
upper_section: tutorials/tutorials
previous_section: tutorials/neural-machine-translation-with-attention
---
このチュートリアルでは、PHPでTransformerモデルを使用して、フランス語から英語への翻訳モデルを構築します。

## Transformerモデルとは？

Transformerは、アテンションメカニズムを利用した強力なニューラルネットワークモデルです。
自然言語処理をはじめ、さまざまなタスクに応用可能で、高速な学習・推論が可能です。
従来のRNNとは異なり、アテンションのみを使用するため、並列計算の効率が向上します。

![アテンションの画像](images/neural-machine-translation-attention.png)

## 事前準備

開始する前に、Rindow Neural Networksをセットアップしてください。
インストール手順は[こちら](/neuralnetworks/install.md)を参照してください。

PHPでもTransformerが十分に高速に動作することを確認できます。
Windows環境では、Rindow CLBlast / OpenCLの使用を推奨します。

このチュートリアルは、[PHPでの基本的な画像分類](basic-image-classification.html)を完了した方、または同等の知識を持つ方を対象としています。

## データセット

翻訳モデルの学習には、[ManyThings.org](http://www.manythings.org/anki/)で提供されている英仏翻訳データを使用します。
データは、英語とフランス語のペアで構成されており、以下のような例があります。

```
Let me do that.       Laissez moi faire ça.
```

このデータをモデルで扱える形式に変換するため、以下の処理を行います。

1. 文を英語とフランス語に分割
2. 文の先頭と末尾にマーカーを追加
   ```
   English:   <start> Let me do that. <end>
   French:    <start> Laissez moi faire ça. <end>
   ```
3. トークナイザーでシーケンスに変換
   - 特殊文字の削除
   - 単語の分割
   - 単語辞書の作成
   - 単語を数値IDに変換
4. 最大長にパディングし、データをシャッフル

```php
// データセット処理のコードが入る
```

## Transformerモデルの構造

Transformerは、エンコーダーとデコーダーからなるエンコーダー・デコーダーモデルです。

- **エンコーダー**: フランス語の文章を処理し、意味を抽出
- **デコーダー**: エンコーダーの出力をもとに英語の文章を生成

エンコーダーとデコーダーは、それぞれ6つのブロックから構成されます。

### ブロックの構成

各ブロックは以下の要素で構成されます。

- **Multi-Head Attention**: どの情報に注目すべきかを判断
- **Feed Forward Network**: 非線形変換を適用
- **Residual Connection & Layer Normalization**: 学習の安定化・高速化

![Transformerモデル](images/neural-machine-translation-transformer.png)

### ポジショナルエンコーディング

単語の順序情報をモデルに学習させるため、正弦波ベースのポジショナルエンコーディングを使用します。

```php
// ポジショナルエンコーディングのコードが入る
```

### マルチヘッドアテンション

Multi-Head Attentionは、異なる視点で情報を処理するアテンション機構です。

- **Scaled Dot-Product Attention**: クエリとキーの内積を計算し、類似度に基づいてバリューを重み付け
- **複数のヘッドで異なる情報を抽出し結合**

```php
// マルチヘッドアテンションのコードが入る
```

### フィードフォワードネットワーク

各トークンに対して適用される2層の全結合ネットワークです。

```php
// フィードフォワードネットワークのコードが入る
```

## エンコーダーとデコーダー

### エンコーダー

```php
// エンコーダーのコードが入る
```

### デコーダー

デコーダーでは、Causal Self-Attention（Masked Multi-Head Attention）を使用し、未来の単語を参照しないようにします。

```php
// デコーダーのコードが入る
```

## Transformerモデルの作成

```php
// Transformerモデルのコードが入る
```

## 損失関数と評価指標

マスクを適用しながら損失関数を計算し、正確な評価ができるようにします。

```php
// 損失関数と指標関数のコードが入る
```

## モデルの学習

学習率のスケジューラーを使用してトレーニングを行います。

```php
// 学習コードが入る
```

## 翻訳の実行

学習済みモデルを用いて、フランス語の文を英語に翻訳します。

```php
// 翻訳コードが入る
```

### 実際に翻訳してみる

```php
// 翻訳の実行コードが入る
```

このチュートリアルを通じて、PHPでTransformerを活用したニューラル機械翻訳の実装方法を学びました。

