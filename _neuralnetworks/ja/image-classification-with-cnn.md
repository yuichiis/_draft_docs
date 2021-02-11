---
layout: document
title: "Convolutional Neural Network(CNN) on PHP"
---
このチュートリアルではCIFAR10画像を分類を使って単純なConvolutional Neural NetworkをPHP上で構築します。
CNNが画像をどのように使われるのかを体験してください。

事前準備
-------
作業を始める前にRindow NeuralNetworksが動作するようにセットアップしてください。インストール手順は
[Rindow Neural Networks installation](/neuralnetworks/install.md)を参照してください。

PHPでも画像認識を学習する為に十分な速度で動作することを体験してください。
もしあなたがWindows環境を使用している場合は、Rindow CLBlast/OpenCLを活用することをお勧めします。

既に[Basic image clasification on PHP](basic-image-classification.html)のチュートリアルを終えられた方または同等の知識持つ方を対象とします。

学習データ
---------
MNISTデータセットは画像の分類としては単純すぎるため、現在のNeural Networksの技術ではあまりにも簡単に分類できてしまいます。
これに比べてCIFAR10は少し高度なモデルを必要とします。
CIFAR10古くから使われている10のクラスに分類された小さなカラー画像のデータセットです。

Rindow NeuralNetworksのデータセットでCIFAR10をダウンロードして表示してみましょう。
```php
$mo = new Rindow\Math\Matrix\MatrixOperator();
$nn = new Rindow\NeuralNetworks\Builder\NeuralNetworks($mo);
[[$train_img,$train_label],[$test_img,$test_label]] =
    $nn->datasets()->cifar10()->loadData();
echo 'images: '.implode(',',$train_img->shape())."\n";
echo 'labels: '.implode(',',$train_label->shape())."\n";
echo 'test images: '.implode(',',$test_img->shape())."\n";
echo 'test labels: '.implode(',',$test_label->shape())."\n";
# images: 50000,32,32,3
# labels: 50000
# test images: 10000,32,32,3
# test labels: 10000
```
訓練用画像とラベルは5万個、検証用画像とラベルは1万個あることが分かります。
画像は32x32の3原色カラーです。

10のクラスを定義してから画像を見てみましょう。

```php
$class_names = ['airplane', 'automobile', 'bird', 'cat', 'deer',
               'dog', 'frog', 'horse', 'ship', 'truck'];
$pltCfg = [
    'title.position'=>'down','title.margin'=>0,]);
];
$plt = new Rindow\Math\Plot\Plot($pltCfg,$mo);
$images = $train_img[[0,24]];
$labels = $train_label[[0,24]];
[$fig,$axes] = $plt->subplots(5,5);
foreach($images as $i => $image) {
    $axes[$i]->imshow($image,
        null,null,null,$origin='upper');
    $label = $labels[$i];
    $axes[$i]->setTitle($class_names[$label]."($label)");
    $axes[$i]->setFrame(false);
}
$plt->show();
```
![CIFAR10 Images](images/image-classification-with-cnn-show-images.png)


画像を見るとMNISTの手書き文字と違って複雑な形をしていることがわかります。
オブジェクトの輪郭もカラー画像から読み取らなければなりません。
同じカエルでもいろいろな色のバリエーションがあります。
これらを単純でフラットな全結合ニューラルネットワークモデルを使って学習させることは
難しいでしょう。

チュートリアルの[Basic image clasification on PHP](basic-image-classification)と同じ単純なニューラルネットワークモデルで訓練させた結果が以下のグラフです。

![CIFAR10 on basic model](images/image-classification-with-cnn-train-basic.png)

ほとんど学習できていません。同じ方法ではうまくいかないようです。

Convolutional Neural Networks
-----------------------------
画像データを２次元平面として扱い何らかの形で理解させる必要があります。
Convolutional Neural Networks(CNN)では2次元の画像を2次元として処理しその特徴を抽出する手段としてとても有効です。
CNNのモデルを作ってみましょう。

Conv2Dレイヤーは2次元の畳み込みを行います。
ここでは3x3のカーネルを使って何度も畳み込みを行う事によって平面上の特徴をチャンネル方向(第3軸)の情報に徐々に変換しています。このレイヤーたちに特徴量の抽出の仕方を学習させます。

MaxPooling2Dレイヤーでは単純に画像の平面データの特徴を残したまま圧縮します。Convolutionalレイヤーと違いPoolレイヤーではカーネル(重みパラメータ)を持ちません。

Dropoutレイヤーでは「過学習」を防ぎます。
レイヤーが深く過度に学習をしやすくなっているneural networksでは、学習に使ったデータだけに敏感に反応し正しい答えを出すようになります。一方、学習に使っていないデータでは正しい答えを出しにくくなります。
これを過学習といいます。
未知の画像にも反応できる一般的な特徴を学習させるために、Dropoutレイヤーを使ってニューロンの状態(カーネル)の更新を遅らせて幅広いデータに反応するようにします。

レイヤーを重ねて平面方向の面積を十分に小さくできたところで、データをDenseレイヤーへ渡し全結合のニューロンへと引継ぎます。最後に10のクラスとして出力ををします。

モデルのコードを見てみましょう。
```php
$model = $nn->models()->Sequential([
    $nn->layers()->Conv2D(
        $filters=32,
        $kernel_size=3,
        ['input_shape'=>[32,32,3],
        'kernel_initializer'=>'he_normal',
        'activation'=>'relu']),
    $nn->layers()->Conv2D(
        $filters=32,
        $kernel_size=3,
        ['kernel_initializer'=>'he_normal',
        'activation'=>'relu']),
    $nn->layers()->MaxPooling2D(),
    $nn->layers()->Dropout(0.25),
    $nn->layers()->Conv2D(
        $filters=64,
        $kernel_size=3,
        ['kernel_initializer'=>'he_normal',
        'activation'=>'relu']),
    $nn->layers()->Conv2D(
        $filters=64,
        $kernel_size=3,
        ['kernel_initializer'=>'he_normal',
        'activation'=>'relu']),
    $nn->layers()->MaxPooling2D(),
    $nn->layers()->Dropout(0.25),
    $nn->layers()->Flatten(),
    $nn->layers()->Dense($units=512,
        ['kernel_initializer'=>'he_normal',
        'activation'=>'relu']),
    $nn->layers()->Dropout(0.25),
    $nn->layers()->Dense($units=10,
        ['activation'=>'softmax']),
]);
$model->compile([
    'loss'=>'sparse_categorical_crossentropy',
    'optimizer'=>'adam',
]);
$model->summary();
# Layer(type)                  Output Shape               Param #
# ==================================================================
# Conv2D(Conv2D)               (30,30,32)                 896
# Conv2D_1(Conv2D)             (28,28,32)                 9248
# MaxPooling2D(MaxPooling2D)   (14,14,32)                 0
# Dropout(Dropout)             (14,14,32)                 0
# Conv2D_2(Conv2D)             (12,12,64)                 18496
# Conv2D_3(Conv2D)             (10,10,64)                 36928
# MaxPooling2D_1(MaxPooling2D) (5,5,64)                   0
# Dropout_1(Dropout)           (5,5,64)                   0
# Flatten(Flatten)             (1600)                     0
# Dense(Dense)                 (512)                      819712
# Dropout_2(Dropout)           (512)                      0
# Dense_1(Dense)               (10)                       5130
# ==================================================================
# Total params: 890410
```
Output Shapeの項目を見てください。
32x32の画像の平面が徐々に小さくなっていることが分かるでしょう。

データの前処理
-------------
CIFAR10画像データは0から255までのRGBデータなので、モデルで処理できるように加工します。

```php
use Interop\Polite\Math\Matrix\NDArray;
$train_imgf = $mo->scale(1.0/255.0,$mo->astype($train_img,NDArray::float32));
$test_imgf  = $mo->scale(1.0/255.0,$mo->astype($test_img,NDArray::float32));
```


モデルを訓練
-----------
モデルにデータを与えて訓練します。
ある程度の時間がかかります。訓練が終わったら直ぐにモデルをセーブしておきましょう。
時間がかかるといってもRindow Neural NetworksはOpenBLASやOpenCLをサポートしていますので、それらをセットアップすると他のPHP機械学習フレームワークと比べるととても速く学習が終わります。
もしあなたが他のPHPの機械学習ライブラリで同じモデルの学習をさせようとしたら、訓練の終了を諦めるでしょう。
```php
$history = $model->fit($train_imgf,$train_label,
    ['epochs'=>10,'batch_size'=>64,'validation_data'=>[$test_imgf,$test_label]]);
$model->save(__DIR__.'/image-classification-with-cnn.model');
# Train on 50000 samples, validation on 10000 samples
# Epoch 1/10 [.........................] 1699 sec. remain:00:30    - 1825 sec.
#  loss:1.6074 accuracy:0.4168 val_loss:1.2452 val_accuracy:0.5534
# Epoch 2/10 [.........................] 1628 sec. remain:00:29    - 1753 sec.
#  loss:1.1971 accuracy:0.5721 val_loss:1.0638 val_accuracy:0.6193
# Epoch 3/10 [.........................] 1623 sec. remain:00:29    - 1748 sec.
#  loss:1.0212 accuracy:0.6393 val_loss:0.9254 val_accuracy:0.6729
# Epoch 4/10 [.........................] 1655 sec. remain:00:30    - 1785 sec.
#  loss:0.8913 accuracy:0.6868 val_loss:0.8300 val_accuracy:0.7045
# Epoch 5/10 [.........................] 1609 sec. remain:00:29    - 1733 sec.
#  loss:0.7994 accuracy:0.7162 val_loss:0.7920 val_accuracy:0.7226
# Epoch 6/10 [.........................] 1623 sec. remain:00:29    - 1748 sec.
#  loss:0.7255 accuracy:0.7471 val_loss:0.7303 val_accuracy:0.7493
# Epoch 7/10 [.........................] 1624 sec. remain:00:29    - 1749 sec.
#  loss:0.6702 accuracy:0.7657 val_loss:0.7194 val_accuracy:0.7523
# Epoch 8/10 [.........................] 1587 sec. remain:00:28    - 1713 sec.
#  loss:0.6213 accuracy:0.7806 val_loss:0.6806 val_accuracy:0.7683
# Epoch 9/10 [.........................] 1622 sec. remain:00:29    - 1747 sec.
#  loss:0.5789 accuracy:0.7966 val_loss:0.6904 val_accuracy:0.7640
# Epoch 10/10 [.........................] 1623 sec. remain:00:29    - 1748 sec.
#  loss:0.5424 accuracy:0.8083 val_loss:0.7171 val_accuracy:0.7623
```

訓練の進行状況をグラフに表示してみましょう。

```php
$plt->setConfig([]);
$plt->plot($mo->array($history['accuracy']),null,null,'accuracy');
$plt->plot($mo->array($history['val_accuracy']),null,null,'val_accuracy');
$plt->plot($mo->array($history['loss']),null,null,'loss');
$plt->plot($mo->array($history['val_loss']),null,null,'val_loss');
$plt->legend();
$plt->xlabel('epoch');
$plt->title('cifar10 cnn clasification');
$plt->show();
```
![Train Progress](images/image-classification-with-cnn-train.png)

このモデルではうまく学習できています。
正解率99%のようにうまくいきませんが、比較的簡単なCNNでも頑張てくれています。

予測
---
それでは学習済みモデルを使って手書き文字の予測をしてみましょう。
```php
$images = $test_img[[0,7]];
$labels = $test_label[[0,7]];
$predicts = $model->predict($images);

$plt->setConfig([
    'frame.xTickLength'=>0,'title.position'=>'down','title.margin'=>0,]);
[$fig,$axes] = $plt->subplots(4,4);
foreach ($predicts as $i => $predict) {
    $axes[$i*2]->imshow($images[$i]->reshape($inputShape),
        null,null,null,$origin='upper');
    $axes[$i*2]->setFrame(false);
    $label = $labels[$i];
    $axes[$i*2]->setTitle($class_names[$label]."($label)");
    $axes[$i*2+1]->bar($mo->arange(10),$predict);
}
$plt->show();
```

![MNIST Images](images/image-classification-with-cnn-predict.png)

答えが正しく予測されていることがわかります。
人間でも迷う猫の画像はNeural netowrkでも迷っていることがわかります。
色も向きもちがうカエルも上手に予測できています。
