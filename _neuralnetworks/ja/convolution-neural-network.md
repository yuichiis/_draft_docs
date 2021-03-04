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
include __DIR__.'/../vendor/autoload.php';
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
$classnames = ['airplane', 'automobile', 'bird', 'cat', 'deer',
               'dog', 'frog', 'horse', 'ship', 'truck'];
$pltCfg = [
    'title.position'=>'down','title.margin'=>0,
];
$plt = new Rindow\Math\Plot\Plot($pltCfg,$mo);
$images = $train_img[[0,24]];
$labels = $train_label[[0,24]];
[$fig,$axes] = $plt->subplots(5,5);
foreach($images as $i => $image) {
    $axes[$i]->imshow($image,
        null,null,null,$origin='upper');
    $label = $labels[$i];
    $axes[$i]->setTitle($classnames[$label]."($label)");
    $axes[$i]->setFrame(false);
}
$plt->show();
```
![CIFAR10 Images](images/convolution-neural-network-show-cifar10.png)

画像を見るとMNISTの手書き文字と違って複雑な形をしていることがわかります。
オブジェクトの輪郭もカラー画像から読み取らなければなりません。
同じカエルでもいろいろな色のバリエーションがあります。
これらを単純でフラットな全結合ニューラルネットワークモデルを使って学習させることは難しいでしょう。

モデルに学習するさせる事ができるようにデータ型の変換をしておきます。
```php
$f_train_img = $mo->scale(1.0/255.0,$mo->la()->astype($train_img,NDArray::float32));
$f_val_img   = $mo->scale(1.0/255.0,$mo->la()->astype($val_img,NDArray::float32));
$i_train_label = $mo->la()->astype($train_label,NDArray::int32);
$i_val_label   = $mo->la()->astype($val_label,NDArray::int32);
```

これをチュートリアルの[Basic image clasification on PHP](basic-image-classification)と同じ単純なニューラルネットワークモデルで訓練させた結果が以下のグラフです。
```php
$model = $nn->models()->Sequential([
    $nn->layers()->Flatten(['input_shape'=>[32,32,3]]),
    $nn->layers()->Dense($units=128,
        ['kernel_initializer'=>'he_normal',
        'activation'=>'relu']),
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
# Flatten(Flatten)             (3072)                     0
# Dense(Dense)                 (128)                      393344
# Dense_1(Dense)               (10)                       1290
# ==================================================================
# Total params: 394634

$f_train_img = $mo->la()->astype($train_img,NDArray::float32);
$f_val_img = $mo->la()->astype($val_img,NDArray::float32);
$history = $model->fit($f_train_img,$train_label,
    ['epochs'=>10,'batch_size'=>256,'validation_data'=>[$f_val_img,$val_label]]);
# Train on 50000 samples, validation on 10000 samples
# Epoch 1/10 [.........................] 58 sec. remaining:00:00  - 61 sec.
#  loss:1.9929 accuracy:0.2946 val_loss:1.8269 val_accuracy:0.3504
# Epoch 2/10 [.........................] 48 sec. remaining:00:00  - 51 sec.
#  loss:1.8058 accuracy:0.3631 val_loss:1.7647 val_accuracy:0.3705
# Epoch 3/10 [.........................] 49 sec. remaining:00:00  - 52 sec.
#  loss:1.7587 accuracy:0.3793 val_loss:1.7351 val_accuracy:0.3803
# Epoch 4/10 [.........................] 47 sec. remaining:00:00  - 50 sec.
#  loss:1.7227 accuracy:0.3936 val_loss:1.7179 val_accuracy:0.3903
# Epoch 5/10 [.........................] 48 sec. remaining:00:00  - 51 sec.
#  loss:1.6886 accuracy:0.4057 val_loss:1.6946 val_accuracy:0.3993
# Epoch 6/10 [.........................] 49 sec. remaining:00:00  - 52 sec.
#  loss:1.6649 accuracy:0.4143 val_loss:1.6701 val_accuracy:0.4060
# Epoch 7/10 [.........................] 46 sec. remaining:00:00  - 49 sec.
#  loss:1.6420 accuracy:0.4214 val_loss:1.6543 val_accuracy:0.4131
# Epoch 8/10 [.........................] 49 sec. remaining:00:00  - 52 sec.
#  loss:1.6279 accuracy:0.4300 val_loss:1.6280 val_accuracy:0.4216
# Epoch 9/10 [.........................] 48 sec. remaining:00:00  - 52 sec.
#  loss:1.6167 accuracy:0.4339 val_loss:1.6221 val_accuracy:0.4229
# Epoch 10/10 [.........................] 47 sec. remaining:00:00  - 50 sec.
#  loss:1.6022 accuracy:0.4383 val_loss:1.6182 val_accuracy:0.4267

$plt->setConfig([]);
$plt->plot($mo->array($history['accuracy']),null,null,'accuracy');
$plt->plot($mo->array($history['val_accuracy']),null,null,'val_accuracy');
$plt->plot($mo->array($history['loss']),null,null,'loss');
$plt->plot($mo->array($history['val_loss']),null,null,'val_loss');
$plt->legend();
$plt->title('basic fnn');
$plt->show();
```
![CIFAR10 on basic model](images/convolution-neural-network-fnn-model.png)

ほとんど学習できていません。同じ方法ではうまくいかないようです。

Convolutional Neural Networks
-----------------------------
画像データは高さと幅に加えて色を表す3次元配列によって表現されています。色は通常はRGBの3つの数値を使うためこれをチャンネルと呼び3channelで色を表します。

前のモデルではこのデータをただ一列に並べただけのデータを入力としていました。

画像データの平面として扱い何らかの形で理解させる必要があります。
Convolutional Neural Networks(CNN)では2次元の画像を2次元として処理しその特徴を抽出する手段としてとても有効です。
CNNのモデルを作ってみましょう。

Conv2Dレイヤーは画像データの高さ方向と幅方向の畳み込みを行います。
ここでは3x3のカーネルを使って何度も畳み込みを行う事によって平面上の特徴をチャンネル方向(第3軸)の情報に徐々に変換しています。このレイヤーたちに特徴量の抽出の仕方を学習させます。

MaxPooling2Dレイヤーでは単純に画像の平面データの特徴を残したまま圧縮します。PoolレイヤーはConvolutionalレイヤーと違ってカーネル(重みパラメータ)を持ちません。

簡単なネットワークモデルを作ってましょう。
```php
$model = $nn->models()->Sequential([
    $nn->layers()->Conv2D(
        $filters=32,
        $kernel_size=3,
        ['input_shape'=>[32,32,3],
        'kernel_initializer'=>'he_normal',
        'activation'=>'relu']),
    $nn->layers()->MaxPooling2D(),
    $nn->layers()->Conv2D(
        $filters=64,
        $kernel_size=3,
        ['kernel_initializer'=>'he_normal',
        'activation'=>'relu']),
    $nn->layers()->MaxPooling2D(),
    $nn->layers()->Flatten(),
    $nn->layers()->Dense($units=64,
        ['kernel_initializer'=>'he_normal',
        'activation'=>'relu']),
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
# MaxPooling2D(MaxPooling2D)   (15,15,32)                 0
# Conv2D_1(Conv2D)             (13,13,64)                 18496
# MaxPooling2D_1(MaxPooling2D) (6,6,64)                   0
# Flatten(Flatten)             (2304)                     0
# Dense(Dense)                 (64)                       147520
# Dense_1(Dense)               (10)                       650
# ==================================================================
# Total params: 167562

$history = $model->fit($f_train_img,$train_label,
    ['epochs'=>10,'batch_size'=>256,'validation_data'=>[$f_val_img,$val_label]]);
# Train on 50000 samples, validation on 10000 samples
# Epoch 1/10 [.........................] 492 sec. remaining:00:00  - 522 sec.
#  loss:1.7411 accuracy:0.3743 val_loss:1.4203 val_accuracy:0.4833
# Epoch 2/10 [.........................] 463 sec. remaining:00:00  - 490 sec.
#  loss:1.3293 accuracy:0.5298 val_loss:1.2694 val_accuracy:0.5414
# Epoch 3/10 [.........................] 461 sec. remaining:00:00  - 488 sec.
#  loss:1.1919 accuracy:0.5815 val_loss:1.1533 val_accuracy:0.5975
# Epoch 4/10 [.........................] 463 sec. remaining:00:00  - 491 sec.
#  loss:1.1068 accuracy:0.6143 val_loss:1.1037 val_accuracy:0.6145
# Epoch 5/10 [.........................] 460 sec. remaining:00:00  - 489 sec.
#  loss:1.0509 accuracy:0.6378 val_loss:1.1026 val_accuracy:0.6102
# Epoch 6/10 [.........................] 458 sec. remaining:00:00  - 486 sec.
#  loss:1.0045 accuracy:0.6518 val_loss:1.0639 val_accuracy:0.6300
# Epoch 7/10 [.........................] 459 sec. remaining:00:00  - 487 sec.
#  loss:0.9666 accuracy:0.6677 val_loss:1.0462 val_accuracy:0.6385
# Epoch 8/10 [.........................] 464 sec. remaining:00:00  - 492 sec.
#  loss:0.9361 accuracy:0.6796 val_loss:1.0131 val_accuracy:0.6535
# Epoch 9/10 [.........................] 459 sec. remaining:00:00  - 486 sec.
#  loss:0.9085 accuracy:0.6859 val_loss:1.0116 val_accuracy:0.6506
# Epoch 10/10 [.........................] 460 sec. remaining:00:00  - 488 sec.
#  loss:0.8805 accuracy:0.6975 val_loss:0.9662 val_accuracy:0.6628
$plt->setConfig([]);
$plt->plot($mo->array($history['accuracy']),null,null,'accuracy');
$plt->plot($mo->array($history['val_accuracy']),null,null,'val_accuracy');
$plt->plot($mo->array($history['loss']),null,null,'loss');
$plt->plot($mo->array($history['val_loss']),null,null,'val_loss');
$plt->legend();
$plt->title('simple conv');
$plt->show();
```
![CIFAR10 on basic model](images/convolution-neural-network-simple-cnn.png)

前回の結果に比べて学習が進んでいる事がわかります。

ただし、あなたはこれで満足できますか？改良していきましょう。

層を深くする
--------------
学習が進まない原因のひとつはモデル柔軟性が低く複雑な画像に対応できない事が考えられます。

何層も重ねる事でモデルの柔軟性を上げます。一つのレイヤーのパラメータを多くするより効果的です。
畳み込みが進むにつれて画像の平面に対する面積が狭くなっていくので、徐々にチャンネル方向の情報を増やしていきます。
そして十分に平面が畳みこまれてチャンネル方向のに長い情報に変形したところで、データを一直線の情報に変換して全結合ネットワークに渡しています。最後に10のクラスとして出力をします。

しかしレイヤーが深くなるとうまく学習できない場合があります。最初のレイヤーから最後のレイヤーに届くまでに特徴量が大きくなりすぎたり小さくなりすぎたりするためです。
BatchNormalizationレイヤーでは学習するミニバッチ単位に数値を標準偏差で正規化します。
これによって情報が失われにくくなり学習効率を上げることができます。

改良を加えたモデルのコードを書いてみましょう。
```php
$model = $nn->models()->Sequential([
    $nn->layers()->Conv2D(
        $filters=64,
        $kernel_size=3,
        ['input_shape'=>$inputShape,
        'kernel_initializer'=>'he_normal',]),
    $nn->layers()->BatchNormalization(),
    $nn->layers()->Activation('relu'),
    $nn->layers()->Conv2D(
        $filters=64,
        $kernel_size=3,
        ['kernel_initializer'=>'he_normal',]),
    $nn->layers()->MaxPooling2D(),
    $nn->layers()->Conv2D(
        $filters=128,
        $kernel_size=3,
        ['kernel_initializer'=>'he_normal',]),
    $nn->layers()->BatchNormalization(),
    $nn->layers()->Activation('relu'),
    $nn->layers()->Conv2D(
        $filters=128,
        $kernel_size=3,
        ['kernel_initializer'=>'he_normal',]),
    $nn->layers()->MaxPooling2D(),
    $nn->layers()->Conv2D(
        $filters=256,
        $kernel_size=3,
        ['kernel_initializer'=>'he_normal',
        'activation'=>'relu']),
    $nn->layers()->GlobalAveragePooling2D(),
    $nn->layers()->Dense($units=512,
        ['kernel_initializer'=>'he_normal',]),
    $nn->layers()->BatchNormalization(),
    $nn->layers()->Activation('relu'),
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
# Conv2D(Conv2D)               (30,30,64)                 1792
# BatchNormalization(BatchNorma(30,30,64)                 128
# Activation(Activation)       (30,30,64)                 0
# Conv2D_1(Conv2D)             (28,28,64)                 36928
# MaxPooling2D(MaxPooling2D)   (14,14,64)                 0
# Conv2D_2(Conv2D)             (12,12,128)                73856
# BatchNormalization_1(BatchNor(12,12,128)                256
# Activation_1(Activation)     (12,12,128)                0
# Conv2D_3(Conv2D)             (10,10,128)                147584
# MaxPooling2D_1(MaxPooling2D) (5,5,128)                  0
# Conv2D_4(Conv2D)             (3,3,256)                  295168
# GlobalAveragePooling2D(Global(256)                      0
# Dense(Dense)                 (512)                      131584
# BatchNormalization_2(BatchNor(512)                      1024
# Activation_2(Activation)     (512)                      0
# Dense_1(Dense)               (10)                       5130
# ==================================================================
# Total params: 693450

```
Output Shapeの項目を見てください。
32x32の画像の平面が徐々に小さくなっていることが分かるでしょう。

オンデマンドデータ生成
---------------------
学習が進むと次の起きる問題は「過学習」です。特定のデータだけに正しく反応し、未知のデータにはうまく対応できなくなってしまうのです。
一般にはDropoutレイヤーを使って過学習に対応しますが、既にBatchNormalizationで学習効率を上げているためあまり相性がよくありません。
今回はサンプル画像のバリエーションを多くする事で過学習に対応します。

ImageDataGeneratorは入力画像を上下左右にランダムにずらしたり、ランダムに左右反転させたりします。
毎回ランダムに変わるのでEpochごとに違う入力データを与える事で疑似的に画像のバリエーションを増やす事ができます。

ではモデルにデータを与えて訓練します。
```php
echo "training model ...\n";
$train_dataset = $nn->data->ImageDataGenerator($f_train_img,[
    'tests'=>$train_label,
    'batch_size'=>64,
    'shuffle'=>true,
    'height_shift'=>2,
    'width_shift'=>2,
    'vertical_flip'=>true,
    'horizontal_flip'=>true
]);
$history = $model->fit($train_dataset,null,
    ['epochs'=>10,
        'validation_data'=>[$f_val_img,$val_label]]);
$model->save(__DIR__.'/image-classification-with-cnn.model');
# Train on 50000 samples, validation on 10000 samples
# Epoch 1/10 [.........................] 4568 sec. remain:01:23  - 4944 sec.
#  loss:1.4600 accuracy:0.4702 val_loss:1.2344 val_accuracy:0.5614
# Epoch 2/10 [.........................] 4328 sec. remain:01:18  - 4703 sec.
#  loss:1.1075 accuracy:0.6039 val_loss:1.2596 val_accuracy:0.5745
# Epoch 3/10 [.........................] 4301 sec. remain:01:18  - 4676 sec.
#  loss:0.9475 accuracy:0.6635 val_loss:1.0196 val_accuracy:0.6380
# Epoch 4/10 [.........................] 4308 sec. remain:01:18  - 4682 sec.
#  loss:0.8516 accuracy:0.6986 val_loss:0.9672 val_accuracy:0.6630
# Epoch 5/10 [.........................] 4299 sec. remain:01:18  - 4673 sec.
#  loss:0.7869 accuracy:0.7212 val_loss:1.1019 val_accuracy:0.6422
# Epoch 6/10 [.........................] 4296 sec. remain:01:18  - 4680 sec.
#  loss:0.7347 accuracy:0.7387 val_loss:0.8917 val_accuracy:0.6969
# Epoch 7/10 [.........................] 4313 sec. remain:01:18  - 4689 sec.
#  loss:0.6917 accuracy:0.7576 val_loss:0.7697 val_accuracy:0.7322
# Epoch 8/10 [.........................] 4308 sec. remain:01:18  - 4684 sec.
#  loss:0.6544 accuracy:0.7687 val_loss:0.8049 val_accuracy:0.7319
# Epoch 9/10 [.........................] 4298 sec. remain:01:18  - 4673 sec.
#  loss:0.6230 accuracy:0.7819 val_loss:1.1660 val_accuracy:0.6321
# Epoch 10/10 [.........................] 4305 sec. remain:01:18  - 4680 sec.
#  loss:0.6021 accuracy:0.7890 val_loss:0.7638 val_accuracy:0.7357
$plt->setConfig([]);
$plt->plot($mo->array($history['accuracy']),null,null,'accuracy');
$plt->plot($mo->array($history['val_accuracy']),null,null,'val_accuracy');
$plt->plot($mo->array($history['loss']),null,null,'loss');
$plt->plot($mo->array($history['val_loss']),null,null,'val_loss');
$plt->legend();
$plt->tilte('cifar10');
$plt->show();
```
![Train Progress](images/convolution-neural-network-deep-cnn.png)

このモデルではうまく学習できています。
MNISTのように正解率99%までうまくいきませんが、このモデルはCIFAR-10を比較的簡単なCNNでも学習してくれました。

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
    $axes[$i*2]->setTitle($classnames[$label]."($label)");
    $axes[$i*2+1]->bar($mo->arange(10),$predict);
}
$plt->show();
```

![CIFAR10 Predict](images/convolution-neural-network-predict.png)

答えが概ね正しく予測されていることがわかります。
人間でも迷う画像はNeural networkでも迷っていることがわかります。
