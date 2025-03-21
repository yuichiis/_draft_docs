---
layout: document
title: "Basic image clasification on PHP"
---
このチュートリアルでは画像分類問題をPHP上の機械学習で行う手順を解説します。

事前準備
-------
このチュートリアルは、初めてニューラルネットワークモデルの作成を体験する人を対象にしています。
またPHPのプログラミングが可能な人が対象です。

Rindow NeuralNetworksの外観を掴むためのものであり、細かい部分にはあまり触れません。
とにかく「こいつ動くぞ！」というものを自分のラップトップで作成できる事を体験してください。

作業を始める前にRindow NeuralNetworksが動作するようにセットアップしてください。インストール手順は
[Rindow Neural Networks installation](/neuralnetworks/install.md)を参照してください。

それでは手書き数字の画像を分類するモデルを作成してみましょう。


学習データ
---------
最初に学習するデータセットを用意します。ここではMNISTデータセットを使用します。
これは古くから例題として使われ簡単に機械学習の訓練ができます。

Rindow NeuralNetworksではデモンストレーションなどによく使われるデータセットが予め用意されています。
MNISTデータセットをPHP上に準備してみましょう。
```php
$mo = new Rindow\Math\Matrix\MatrixOperator();
$nn = new Rindow\NeuralNetworks\Builder\NeuralNetworks($mo);
[[$train_img,$train_label],[$test_img,$test_label]] =
    $nn->datasets()->mnist()->loadData();
echo 'images: '.implode(',',$train_img->shape())."\n";
echo 'labels: '.implode(',',$train_label->shape())."\n";
echo 'test images: '.implode(',',$test_img->shape())."\n";
echo 'test labels: '.implode(',',$test_label->shape())."\n";
# images: 60000,1,28,28
# labels: 60000
# test images: 10000,1,28,28
# test labels: 10000
```
データはすべてNDArray型という配列に格納します。
NDArrayはPHPネイティブな配列と違って、効率的に行列演算が行える構造になっています。
最初の行のMatrixOperatorクラスは、汎用的な配列操作を行う基本ライブラリーです。
MatrixOperatorはこのNDArrayを操作します。

2行目のNeuralNetworkクラスはRindow NeuralNetworksの様々なオブジェクトを生成するオブジェクトビルダーです。
汎用性と将来的にlightweight containerに対応するためにプログラマー各自が直接オブジェクト生成を行うことはありません。オブジェクトビルダー経由でオブジェクトを生成します。

3行目で実際のMNISTデータセットを取り出しています。
loadData()を呼ぶと自動的にデータをダウンロードしてキャッシュします。
その後PHPで扱えるようにNDArray型に変換して、$train_img,$train_labelなどの変数に格納します。

訓練用画像とラベルは6万個、検証用画像とラベルは1万個あることが分かります。
画像は28x28の単色です。

画像を表示
-----------
画像データを表示してみましょう。データは最初の25個を切り出しラベルと一緒に表示します。
Rindow Math Plotは数値データを画像として表示することができます。

```php
$pltCfg = ['title.margin'=>0,];
$plt = new Rindow\Math\Plot\Plot($pltCfg,$mo);
$images = $train_img[[0,24]];
$labels = $train_label[[0,24]];
[$fig,$axes] = $plt->subplots(5,5);
foreach($images as $i => $image) {
    $axes[$i]->setFrame(false);
    $axes[$i]->setTitle(sprintf("'%d'",$labels[$i]));
    $axes[$i]->imshow($image->reshape([28,28]),
        null,null,null,$origin='upper');
}
$plt->show();
```

![MNIST Images](images/basic-image-classification-show-mnist.png)

手書きの数字と正解の数字が対になっていることがわかります。
判別したい画像と正解のラベルを大量に与えることでニューラルネットワークモデルを訓練をする方式が教師あり機械学習の基本です。


データの準備
-----------
中身の数値を見てみましょう。
```php
$img = $plt->imshow($images[0]->reshape([28,28]),
    null,null,null,$origin='upper');
$plt->colorbar($img);
$plt->getAxes()->setFrame(false);
$plt->show();
echo 'min='.$mo->min($images[0]).',max='.$mo->max($images[0])."\n";
# min=0,max=255
```

![MNIST Images](images/basic-image-classification-show-image-value.png)

画像データは0から255までの数値で表現されてることがわかります。
ニューラルネットワークモデルで扱いやすいように、0から1までの数値に変換していきます。
さらに1x28x28の画像データからフラットな784個の1次元データに変換します。
```php
use Interop\Polite\Math\Matrix\NDArray;
$train_img = $mo->scale(1.0/255.0,$mo->astype($train_img,NDArray::float32))
    ->reshape([60000,784]);
$test_img  = $mo->scale(1.0/255.0,$mo->astype($test_img,NDArray::float32));
    ->reshape([10000,784]);
```
これでデータの準備は整いました。


モデルの作成
-----------

ニューラルネットワークモデルの基本的な構成要素はLayerです。
幾つかの役割をもったLayerを重ねることでモデルを構築します。

データの流れが一直線になっている単純なモデルはシーケンシャルモデルで構築する事ができます。
```php
$model = $nn->models()->Sequential([
    $nn->layers()->Dense($units=128,
        ['input_shape'=>[784],
            'kernel_initializer'=>'he_normal',
        'activation'=>'relu',
        ]),
    $nn->layers()->Dense($units=10,
        ['activation'=>'softmax']),
]);
```

全結合ニューロンであるDenseレイヤーで受け取り、128個のニューロンに中間層の出力予測をさせます。
もちろん何も知らないランダムな状態をパラメーターとして持っているニューロンは、答えもランダムに出しますが、後で学習し状態を調整していきます。
これによって784個のデータから128個のデータに変換されます。次の層へ出力するためにReLU関数を通過させます。
この関数をアクティベーション関数と呼びます。
ニューロンが発火して活性状態にあるのか休止状態のあるのかをなるべく分けるように出力を変換する関数です。

次に出力層の全結合ニューロンのDenseレイヤーで受け取り10個のニューロンに対応させます。
ここでも最初はランダムな答えを予測します。この128個の入力から10個の数字に対応するように学習します。
10個の答えのそれぞれが正解である確率で出力したいのでアクティベーション関数にsoftmaxを使います。
softmaxは合計が1となるような10個の確率の数値に振り分けてくれます。

モデルのコンパイル
----------------
損失関数とオプティマイザーを指定して、モデルをコンパイルします。
損失関数sparse_categorical_crossentropyは正解データが整数値ラベルの場合にしようします。
損失関数は予測結果と正解がどれだけ遠いのかを数値化します。

この誤差の数値からBackpropagationを行い、レイヤーを遡ってニューロンのパラメーターを更新して行きます。
その更新を行うのがオプティマイザーです。adamはとても優秀なオプティマイザーの一つで最近のモデルではよく使わています。
```php
$model->compile([
    'loss'=>'sparse_categorical_crossentropy',
    'optimizer'=>'adam',
]);
$model->summary();
# Layer(type)                  Output Shape               Param #
# ==================================================================
# Dense(Dense)                 (128)                      100480
# Dense_1(Dense)               (10)                       1290
# ==================================================================
# Total params: 101770
```
モデルのサマリーの表示から、各レイヤーのパラメータの個数の合計は101770個あることが分かります。
基本的にはパラメータの数が多ければ多いほど柔軟な学習ができます。
しかしパラメータの数が多くなると計算量が多くなり速度が遅くなるだけでなく、誤った学習をしやすくなる場合があるので調整が必要です。

モデルを訓練
-----------
モデルにデータを与えて訓練します。
```php
$history = $model->fit($train_img,$train_label,
    ['epochs'=>5,'batch_size'=>256,'validation_data'=>[$test_img,$test_label]]);
# Train on 60000 samples, validation on 10000 samples
# Epoch 1/5 ........................ - 12 sec.
#  loss:0.4739 accuracy:0.8717 val_loss:0.2526 val_accuracy:0.9261
# Epoch 2/5 ........................ - 12 sec.
#  loss:0.2188 accuracy:0.9382 val_loss:0.1772 val_accuracy:0.9481
# Epoch 3/5 ........................ - 12 sec.
#  loss:0.1649 accuracy:0.9532 val_loss:0.1438 val_accuracy:0.9582
# Epoch 4/5 ........................ - 11 sec.
#  loss:0.1317 accuracy:0.9623 val_loss:0.1222 val_accuracy:0.9645
# Epoch 5/5 ........................ - 12 sec.
#  loss:0.1086 accuracy:0.9696 val_loss:0.1087 val_accuracy:0.9672
```
ここではデータが6万個しかないので5回同じデータで訓練を繰り返すしています。
繰り返すたびに学習が進んでいる事を見ることができます。

バッチサイズは一度にいくつのデータを処理するかを指定しています。
バッチサイズが大きければ速度が速くなりますがメモリーを消費します。
また学習の特性も変わります。

validation_dataで指定しているデータは汎化性能を計るデータです。
学習に使うデータだけで学習の進捗状況を計ると、そのデータの中では正しい答えを予測できても未知のデータが現れた時に正しい予測を出来るかどうかわかりません。
ですから、学習に使われていないデータを与えてどれだけ正解するかのかを計っているのです。

学習の進行状況が数字の羅列だけでは分かりずらいので、グラフに表示してみましょう。

```php
$plt->plot($mo->array($history['accuracy']),null,null,'accuracy');
$plt->plot($mo->array($history['val_accuracy']),null,null,'val_accuracy');
$plt->plot($mo->array($history['loss']),null,null,'loss');
$plt->plot($mo->array($history['val_loss']),null,null,'val_loss');
$plt->legend();
$plt->xlabel('epoch');
$plt->title('mnist basic clasification');
$plt->show();
```
![MNIST Images](images/basic-image-classification-train.png)

損失の値が徐々に減っているので予測と答えの差が小さくなっているのです。

accuracyは正解率で1となれば全問正解です。
これは一番正解の確率が高い答えを予測値としているため損失関数とは違うグラフとなっています。

学習済みモデルを保存
------------------
このチュートリアルではとても簡単な学習を行っているので訓練にかかる時間はとても短いです。
しかし実際に使う高度なモデルでは訓練にとても長い時間がかかります。

学習済みのモデルを保存しておけば、パラメータを読みだすだけで学習済みモデルを再現できます。

```php
$model->save(__DIR__.'/mnist-basic-model.model',$portable=true);
```
portableの指定は環境が違い高速化に必要なPHP拡張が使えない場合でも読みだせるようにする
オプションです。精度は変わってしまいますがwebホスティングサービスなどにモデルをアップロード
して予測に使うことができます。

モデルの読み込みはファイルを指定するだけです。
```php
$model = $nn->models()->loadModel(__DIR__.'/mnist-basic-model.model');
```

予測
---
それでは学習済みモデルを使って手書き文字の予測をしてみましょう。
画像がどの数字であるかの確率をグラフで表示します。
```php
$images = $test_img[[0,7]];
$predicts = $model->predict($images);

$plt->setConfig(['frame.xTickLength'=>0]);
[$fig,$axes] = $plt->subplots(4,4);
foreach ($predicts as $i => $predict) {
    $axes[$i*2]->imshow($images[$i]->reshape([28,28]),
        null,null,null,$origin='upper');
    $axes[$i*2]->setFrame(false);
    $axes[$i*2+1]->bar($mo->arange(10),$predict);
}
$plt->show();
```

![MNIST Images](images/basic-image-classification-predict.png)

答えが正しく予測されていることがわかります。
