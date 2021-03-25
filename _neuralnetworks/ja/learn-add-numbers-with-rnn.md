---
layout: document
title: "Learning to add numbers with seq2seq on PHP"
---
このチュートリアルでは２つの数字の足し算を学習するモデルを、PHP上のRecurrent Neural Network(RNN)を使って構築します。


事前準備
-------
作業を始める前にRindow NeuralNetworksが動作するようにセットアップしてください。インストール手順は
[Rindow Neural Networks installation](/neuralnetworks/install.md)を参照してください。

PHPでもRNNに十分な速度で動作することを体験してください。
もしあなたがWindows環境を使用している場合は、Rindow CLBlast/OpenCLを活用することをお勧めします。

既に[Basic image clasification on PHP](basic-image-classification.html)のチュートリアルを終えられた方または同等の知識持つ方を対象とします。

Sequence to sequence learning
-----------------------------
ある数値列を別の数値列に変換するための学習モデルを、Sequence to sequence learningと呼びます。

ここでは足し算の出題を文字列で入力し、その答えを文字列で出力させます。

例えば
- **Input**: 294+86
- **Output**: 380

入力が３桁と３桁の足し算であれば100万通りの入力となります。すべてを丸暗記すればよいのですがそれでは面白くありません。

数字には桁の情報があり、足し算によって桁上がりがあります。
これらのルールを教えることなく、問題と答えを与えるだけで足し算を理解させようという試みです。

学習データ
---------
学習モデルが取り扱うことができるように各文字を数値で表現する対応表を作ります。

```php
$vocab = ['0','1','2','3','4','5','6','7','8','9','+',' ']
```

これで'0'から'(space)'まで12種類の数値が割り当てられました。
入力は最大7文字、出力は最大４文字です。先ほどの例をシーケンスで表すと以下のようになります。

```php
require __DIR__.'/../vendor/autoload.php';
use Rindow\Math\Matrix\MatrixOperator;
$mo = new MatrixOperator();
$vocab = ['0','1','2','3','4','5','6','7','8','9','+',' '];
$dict  = array_flip($vocab);
$input_seq = $mo->array(array_map(fn($c)=>$dict[$c], str_split('294+86 ')));
$output_seq = $mo->array(array_map(fn($c)=>$dict[$c], str_split('380 ')));
# $input  => [2,9,4,10,8,6,11]
# $output => [3,8,0,11]
```

このような足し算とその回答のシーケンスをランダム作成したデータセットを用意します。
```php
use Interop\Polite\Math\Matrix\NDArray;

class NumAdditionDataset
{
    public function __construct($mo,int $corpus_max,int $digits)
    {
        $this->mo = $mo;
        $this->corpus_max = $corpus_max;
        $this->digits = $digits;
        #$this->reverse = $reverse;
        $this->vocab_input  = ['0','1','2','3','4','5','6','7','8','9','+',' '];
        $this->vocab_target = ['0','1','2','3','4','5','6','7','8','9','+',' '];
        $this->dict_input  = array_flip($this->vocab_input);
        $this->dict_target = array_flip($this->vocab_target);
        $this->input_length = $digits*2+1;
        $this->output_length = $digits+1;
    }

    public function dicts()
    {
        return [
            $this->vocab_input,
            $this->vocab_target,
            $this->dict_input,
            $this->dict_target,
        ];
    }

    public function generate()
    {
        $max_num = pow(10,$this->digits);
        $max_sample = $max_num ** 2;
        $numbers = $this->mo->random()->choice(
            $max_sample,$max_sample,$replace=false);
        $questions = [];
        $dups = [];
        $size = 0;
        for($i=0;$i<$max_sample;$i++) {
            $num = $numbers[$i];
            $x1 = (int)floor($num / $max_num);
            $x2 = (int)($num % $max_num);
            if($x1>$x2) {
                [$x1,$x2] = [$x2,$x1];
            }
            $question = $x1.'+'.$x2;
            if(array_key_exists($question,$questions)) {
                #echo $question.',';
                $dups[$question] += 1;
                continue;
            }
            $dups[$question] = 1;
            $questions[$question] = strval($x1+$x2);
            $size++;
            if($size >= $this->corpus_max)
                break;
        }
        unset($numbers);
        $sequence = $this->mo->zeros([$size,$this->input_length],NDArray::int32);
        $target = $this->mo->zeros([$size,$this->output_length],NDArray::int32);
        $i = 0;
        foreach($questions as $question=>$answer) {
            $question = str_pad($question, $this->input_length);
            $answer = str_pad($answer, $this->output_length);
            $this->str2seq(
                $question,
                $this->dict_input,
                $sequence[$i]);
            $this->str2seq(
                $answer,
                $this->dict_target,
                $target[$i]);
            $i++;
        }
        return [$sequence,$target];
    }

    public function str2seq(
        string $str,
        array $dic,
        NDArray $buf)
    {
        $sseq = str_split(strtoupper($str));
        $len = count($sseq);
        $sp = $dic[' '];
        $bufsz=$buf->size();
        for($i=0;$i<$bufsz;$i++){
            if($i<$len)
                $buf[$i]=$dic[$sseq[$i]];
            else
                $buf[$i]=$sp;
        }
    }

    public function seq2str(
        NDArray $buf,
        array $dic
        )
    {
        $str = '';
        $bufsz=$buf->size();
        for($i=0;$i<$bufsz;$i++){
            $str .= $dic[$buf[$i]];
        }
        return $str;
    }

    public function loadData($path=null)
    {
        if($path==null){
            $path='numaddition-dataset.pkl';
        }
        if(file_exists($path)){
            $pkl = file_get_contents($path);
            $dataset = unserialize($pkl);
        }else{
            $dataset = $this->generate();
            $pkl = serialize($dataset);
            file_put_contents($path,$pkl);
        }
        return $dataset;
    }
}
```
少し長いコードですが、これでデータセットが出来上がります。実行してみましょう。
３桁の足し算を2万個作ります。
```php
$TRAINING_SIZE = 20000;
$DIGITS = 3;
$dataset = new NumAdditionDataset($mo,$TRAINING_SIZE,$DIGITS);
echo "Generating data...\n";
[$questions,$answers] = $dataset->loadData();
$corpus_size = count($questions);
echo "Total questions: ". $corpus_size."\n";
echo "questions[0]:".$mo->toString($questions[0])."\n";
echo "answers[0]  :".$mo->toString($answers[0])."\n";
[$input_voc,$target_voc,$input_dic,$target_dic]=$dataset->dicts();
echo "questions[0]:".$dataset->seq2str($questions[0],$input_voc)."\n";
echo "answers[0]  :".$dataset->seq2str($answers[0],$target_voc)."\n";

# Generating data...
# Total questions: 20000
# questions[0]:[7,8,9,10,8,4,2]
# answers[0]  :[1,6,3,1]
# questions[0]:789+842
# answers[0]  :1631
```


学習モデル
---------
それぞれの入力文字とその並び方の特徴を表す情報に変換し、その特徴をデータを出力文字に変換するモデルを考えます。

まず入力シーケンスをベクトル演算できるようにします。
簡単な方法は入力データをすべてOne hot形式に変換する事です。しかしそれでは入力データ量が単純にデータセット全体の文字数の12倍(0から9と+と空白で12種類)になってしまいます。

このチュートリアルでは別の方法としてはEmbeddingレイヤーを使い動的に学習します。
一般的にEmbeddingレイヤーは各シーケンス番号(ここでは0から9と+と空白で12種類)ごとの特徴量をベクトルとして学習します。
Embeddingレイヤーによって12文字の入力は12個ベクトルに変換されます。

次にこのベクトルシーケンスを学習する為にRecurrent Neural Networksを使います。
これは順番に意味があるデータを学習するためです。ここではGRUレイヤーを使います。
GRUレイヤーによって入力文字列は文字の順番を考慮した特徴をベクトルに変換されます。
これをエンコーダーと呼びます。

この特徴のベクトルと、正解の文字列を与えて学習する為に再びRecurrent Neural Networksを使います。
１つの特徴のベクトルを出力文字数分のベクトルに変換します。
これをデコーダーと呼びます。
デコーダーへの入力方法は様々な方法がありますが、ここではRepeatVectorを使って１つの特徴ベクトルを出力文字数分だけコピーして入力します。これによって学習の精度が高くなります

出力文字数分のベクトルシーケンスが出来ましたので、出力層として全結合ネットワークを付け加えます。

![MNIST Images](images/learn-add-numbers-with-rnn-model.svg)

それでは、モデルを作りましょう。
```php
use Rindow\NeuralNetworks\Builder\NeuralNetworks;
$nn = new NeuralNetworks($mo);
$REVERSE = True;
$WORD_VECTOR = 16;
$UNITS = 128;
$input_length  = $DIGITS*2 + 1;
$output_length = $DIGITS + 1;

$model = $nn->models()->Sequential([
    $nn->layers()->Embedding(count($input_dic), $WORD_VECTOR,
        ['input_length'=>$input_length]
    ),
    # Encoder
    $nn->layers()->GRU($UNITS,['go_backwards'=>$REVERSE]),
    # Expand to answer length and peeking hidden states
    $nn->layers()->RepeatVector($output_length),
    # Decoder
    $nn->layers()->GRU($UNITS, [
        'return_sequences'=>true,
        'go_backwards'=>$REVERSE,
    ]),
    # Output
    $nn->layers()->Dense(
        count($target_dic),
        ['activation'=>'softmax']
    ),
]);
$model->compile([
    'loss'=>'sparse_categorical_crossentropy',
    'optimizer'=>'adam',
]);
$model->summary();
# Layer(type)                  Output Shape               Param #
# ==================================================================
# Embedding(Embedding)         (7,16)                     192
# GRU(GRU)                     (128)                      56064
# RepeatVector(RepeatVector)   (4,128)                    0
# GRU_1(GRU)                   (4,128)                    99072
# Dense(Dense)                 (4,12)                     1548
# ==================================================================
# Total params: 156876
```
GRUレイヤーのgo_backwardsオプションは、文字列を逆順に学習すると精度が上がるという研究結果に従っています。
WORD_VECTORとUNITSは任意で調整するハイパーパラメータです。


トレーニング
-----------
データセットをトレーニング用と検証用に分割します。

```php
$split_at = $corpus_size - (int)floor($corpus_size / 10);
$x_train = $questions[[0,$split_at-1]];
$x_val   = $questions[[$split_at,$corpus_size-1]];
$y_train = $answers[[0,$split_at-1]];
$y_val   = $answers[[$split_at,$corpus_size-1]];

echo "train,test: ".count($x_train).",".count($x_val)."\n";
# train,test: 18000,2000
```
このデータを学習してみます。

```php
$EPOCHS = 10;
$BATCH_SIZE = 8;
$history = $model->fit(
    $x_train,
    $y_train,
    [
        'epochs'=>$EPOCHS,
        'batch_size'=>$BATCH_SIZE,
        'validation_data'=>[$x_val, $y_val],
    ]
);
# Train on 18000 samples, validation on 2000 samples
# Epoch 1/10 [.........................] 152 sec. remaining:00:00  - 159 sec.
#  loss:1.6262 accuracy:0.4033 val_loss:1.3407 val_accuracy:0.4905
# Epoch 2/10 [.........................] 154 sec. remaining:00:00  - 160 sec.
#  loss:1.2199 accuracy:0.5385 val_loss:1.0389 val_accuracy:0.6158
# Epoch 3/10 [.........................] 153 sec. remaining:00:00  - 160 sec.
#  loss:0.9095 accuracy:0.6595 val_loss:0.8177 val_accuracy:0.6913
# Epoch 4/10 [.........................] 157 sec. remaining:00:00  - 163 sec.
#  loss:0.7664 accuracy:0.7125 val_loss:0.7546 val_accuracy:0.7141
# Epoch 5/10 [.........................] 151 sec. remaining:00:00  - 157 sec.
#  loss:0.5213 accuracy:0.8107 val_loss:0.2996 val_accuracy:0.9014
# Epoch 6/10 [.........................] 148 sec. remaining:00:00  - 154 sec.
#  loss:0.2366 accuracy:0.9295 val_loss:0.1964 val_accuracy:0.9389
# Epoch 7/10 [.........................] 154 sec. remaining:00:00  - 161 sec.
#  loss:0.1297 accuracy:0.9630 val_loss:0.0895 val_accuracy:0.9751
# Epoch 8/10 [.........................] 155 sec. remaining:00:00  - 162 sec.
#  loss:0.0968 accuracy:0.9715 val_loss:0.1075 val_accuracy:0.9621
# Epoch 9/10 [.........................] 153 sec. remaining:00:00  - 159 sec.
#  loss:0.0823 accuracy:0.9752 val_loss:0.0566 val_accuracy:0.9811
# Epoch 10/10 [.........................] 153 sec. remaining:00:00  - 160 sec.
#  loss:0.0608 accuracy:0.9809 val_loss:0.0842 val_accuracy:0.9719
```
学習の進行状況をグラフに表示してみましょう。

```php
use Rindow\Math\Plot\Plot;
$plt = new Plot(null,$mo);

$plt->plot($mo->array($history['accuracy']),null,null,'accuracy');
$plt->plot($mo->array($history['val_accuracy']),null,null,'val_accuracy');
$plt->plot($mo->array($history['loss']),null,null,'loss');
$plt->plot($mo->array($history['val_loss']),null,null,'val_loss');
$plt->legend();
$plt->title('seq2seq-simple-numaddition');
$plt->show();
```
![MNIST Images](images/learn-add-numbers-with-rnn-training.png)

予測
---
問題を与えて正解を予測します。

```php
for($i=0;$i<10;$i++) {
    $idx = $mo->random()->randomInt($corpus_size);
    $question = $questions[$idx];
    $input = $question->reshape([1,$input_length]);

    $predict = $model->predict($input);
    $predict_seq = $mo->argMax($predict[0]->reshape([$output_length,count($target_dic)]),$axis=1);
    $predict_str = $dataset->seq2str($predict_seq,$target_voc);
    $question_str = $dataset->seq2str($question,$input_voc);
    $answer_str = $dataset->seq2str($answers[$idx],$target_voc);
    $correct = ($predict_str==$answer_str) ? '*' : ' ';
    echo "$question_str=$predict_str : $correct $answer_str\n";
}
# 583+885=1468 : * 1468
# 517+959=1476 : * 1476
# 437+571=1008 : * 1008
# 195+322=517  : * 517
# 258+623=881  : * 881
# 739+857=1596 : * 1596
# 580+724=1304 : * 1304
# 151+284=434  :   435
# 418+789=1207 : * 1207
# 52+889 =941  : * 941
```
