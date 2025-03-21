---
layout: document
title: "Neural machine translation with attention on PHP"
---
このチュートリアルではPHP上のRecurrent Neural Network(RNN)とAttentionを使って、フランス語から英語に変換するモデルを構築します。

まず自然言語を取り扱う時によく使われるTokenizerを使って文章をフランス語のSequenceと英語のSequenceに変換します。
あるSequenceから別のSequenceに変換するための学習モデルを、Sequence to sequence learningと呼びます。

この機械学習モデルの中でRecurrent Neural Network(RNN)とAttentionを使います。

このモデルの中でAttentionは入力のどの部分がモデルの注意を引くかを示します。人間と似たようなモデルを構築する事で変換の精度が上がります。

![Encoder and Decoder](images/neural-machine-translation-attention.png)


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

変換されたシーケンスを最大長でパディングし、すれば入力シーケンスの完成です。
フランス語のデータセットは19万の文のペアがあるため、適当なところまで切り出して順番をシャッフルします。



これらの処理を行うコードを以下に示します。

```php
require __DIR__.'/../vendor/autoload.php';

use Rindow\NeuralNetworks\Support\GenericUtils;
use Interop\Polite\Math\Matrix\NDArray;
use Rindow\NeuralNetworks\Layer\AbstractRNNLayer;
use Rindow\NeuralNetworks\Model\AbstractModel;
use Rindow\Math\Matrix\MatrixOperator;
use Rindow\Math\Plot\Plot;
use Rindow\NeuralNetworks\Backend\RindowBlas\Backend;
use Rindow\NeuralNetworks\Builder\NeuralNetworks;
use Rindow\NeuralNetworks\Data\Sequence\Tokenizer;
use Rindow\NeuralNetworks\Data\Sequence\Preprocessor;

class EngFraDataset
{
    protected $baseUrl = 'http://www.manythings.org/anki/';
    protected $downloadFile = 'fra-eng.zip';

    public function __construct($mo,$inputTokenizer=null,$targetTokenizer=null)
    {
        $this->mo = $mo;
        $this->datasetDir = $this->getDatasetDir();
        if(!file_exists($this->datasetDir)) {
            @mkdir($this->datasetDir,0777,true);
        }
        $this->saveFile = $this->datasetDir . "/fra-eng.pkl";
        $this->preprocessor = new Preprocessor($mo);
    }

    protected function getDatasetDir()
    {
        return sys_get_temp_dir().'/rindow/nn/datasets/fra-eng';
    }

    protected function download($filename)
    {
        $filePath = $this->datasetDir . "/" . $filename;

        if(!file_exists($filePath)){
            $this->console("Downloading " . $filename . " ... ");
            copy($this->baseUrl.$filename, $filePath);
            $this->console("Done\n");
        }

        $memberfile = 'fra.txt';
        $path = $this->datasetDir.'/'.$memberfile;
        if(file_exists($path)){
            return $path;
        }
        $this->console("Extract to:".$this->datasetDir.'/..'."\n");
        $files = [$memberfile];
        $zip = new ZipArchive();
        $zip->open($filePath);
        $zip->extractTo($this->datasetDir);
        $zip->close();
        $this->console("Done\n");

        return $path;
    }

    public function preprocessSentence($w)
    {
        $w = '<start> '.$w.' <end>';
        return $w;
    }

    public function createDataset($path, $numExamples)
    {
        $contents = file_get_contents($path);
        if($contents==false) {
            throw new InvalidArgumentException('file not found: '.$path);
        }
        $lines = explode("\n",trim($contents));
        unset($contents);
        $trim = function($w) { return trim($w); };
        $enSentences = [];
        $spSentences = [];
        foreach ($lines as $line) {
            if($numExamples!==null) {
                $numExamples--;
                if($numExamples<0)
                    break;
            }
            $blocks = explode("\t",$line);
            $blocks = array_map($trim,$blocks);
            $en = $this->preprocessSentence($blocks[0]);
            $sp = $this->preprocessSentence($blocks[1]);
            $enSentences[] = $en;
            $spSentences[] = $sp;
        }
        return [$enSentences,$spSentences];
    }

    public function tokenize($lang,$numWords=null,$tokenizer=null)
    {
        if($tokenizer==null) {
            $tokenizer = new Tokenizer($this->mo,[
                'num_words'=>$numWords,
                'filters'=>"\"\'#$%&()*+,-./:;=@[\\]^_`{|}~\t\n",
                'specials'=>"?.!,¿",
            ]);
        }
        $tokenizer->fitOnTexts($lang);
        $sequences = $tokenizer->textsToSequences($lang);
        $tensor = $this->preprocessor->padSequences($sequences,['padding'=>'post']);
        return [$tensor, $tokenizer];
    }

    protected function console($message)
    {
        fwrite(STDERR,$message);
    }

    public function loadData(
        string $path=null, int $numExamples=null, int $numWords=null)
    {
        if($path==null) {
            $path = $this->download($this->downloadFile);
        }
        # creating cleaned input, output pairs
        [$targ_lang, $inp_lang] = $this->createDataset($path, $numExamples);

        [$input_tensor, $inp_lang_tokenizer] = $this->tokenize($inp_lang,$numWords);
        [$target_tensor, $targ_lang_tokenizer] = $this->tokenize($targ_lang,$numWords);
        $numInput = $input_tensor->shape()[0];
        $choice = $this->mo->random()->choice($numInput,$numInput,$replace=false);
        $input_tensor = $this->shuffle($input_tensor,$choice);
        $target_tensor = $this->shuffle($target_tensor,$choice);

        return [$input_tensor, $target_tensor, $inp_lang_tokenizer, $targ_lang_tokenizer];
    }

    public function shuffle(NDArray $tensor, NDArray $choice) : NDArray
    {
        $result = $this->mo->zerosLike($tensor);
        $size = $tensor->shape()[0];
        for($i=0;$i<$size;$i++) {
            $this->mo->la()->copy($tensor[$choice[$i]],$result[$i]);
        }
        return $result;
    }

    public function convert($lang, NDArray $tensor) : void
    {
        $size = $tensor->shape()[0];
        for($i=0;$t<$size;$t++) {
            $t = $tensor[$i];
            if($t!=0)
                echo sprintf("%d ----> %s\n", $t, $lang->index_word[$t]);
        }
    }
}
```


データセットを作成してみましょう。

```php
$numExamples=20000;
$numWords=null;
$dataset = new EngFraDataset($mo);
[$inputTensor, $targetTensor, $inpLang, $targLang]
    = $dataset->loadData(null,$numExamples,$numWords);
echo "inputTensor[0]=".$mo->toString($inputTensor[0])."\n";
echo "targetTensor[0]=".$mo->toString($targetTensor[0])."\n";
echo "input=".$inpLang->sequencesToTexts($inputTensor[[0,1]])[0]."\n";
echo "target=".$targLang->sequencesToTexts($targetTensor[[0,1]])[0]."\n";

# inputTensor[0]=[1,11,19,174,218,168,3,2,0,0,0,0,0,0,0,0,0]
# targetTensor[0]=[1,15,268,140,148,3,2,0,0]
# input=<start> il a pris son livre . <end>
# target=<start> he took his book . <end>

```


エンコーダー／デコーダーモデル
----------------------------
"Sequence to sequence learning"でよく使われるモデルに、
エンコーダー・デコーダーモデルがあります。

入力データからエンコーダーで意味のベクトルを抽出し、
そのベクトルからデコーダーを通すとターゲットデーターを生成する様に学習します。

ここではエンコーダーとデコーダーにGRU Layerを使用します。
GRUは Recurrent Neural Network(RNN)の一つで最近よく使われています。
RNNを利用することで次々に単語を予測します。

また Attention Layerを使用します。
Attentionでは入力の単語に対応する出力の単語に注目させる効果があります。

![Encoder and Decoder](images/neural-machine-translation-model.svg)

エンコーダー
------------
入力シーケンスをEmbeddingレイヤーに通し単語の埋め込みベクトルを問い合わせします。

それらをGRUに通したシーケンスの出力をAttentionの入力としてデコーダーに渡します。
GRUのステータスの出力を入力シーケンスをベクトル化した結果として、
デコーダーのステータス入力に渡します。

```php
class Encoder extends AbstractModel
{
    public function __construct(
        $backend,
        $builder,
        int $vocabSize,
        int $wordVectSize,
        int $units,
        int $inputLength
        )
    {
        $this->backend = $backend;
        $this->vocabSize = $vocabSize;
        $this->wordVectSize = $wordVectSize;
        $this->units = $units;
        $this->embedding = $builder->layers()->Embedding(
            $vocabSize,$wordVectSize,
            ['input_length'=>$inputLength]
        );
        $this->rnn = $builder->layers()->GRU(
            $units,
            ['return_state'=>true,'return_sequences'=>true,
             'recurrent_initializer'=>'glorot_uniform']
        );
    }

    protected function call(
        object $inputs,
        bool $training,
        array $initial_state=null,
        array $options=null
        ) : array
    {
        $K = $this->backend;
        $wordVect = $this->embedding->forward($inputs,$training);
        [$outputs,$states] = $this->rnn->forward(
            $wordVect,$training,$initial_state);
        return [$outputs, $states];
    }
}
```

デコーダー
----------
デコーダーは少々複雑です。
あるステータス入力を与えられたときに、対応するシーケンスを生成しなければなりません。
<start>を与えるとその次に来る単語を生成し、生成した単語を与えるとその次の単語を生成するようにDecoderを学習させます。
図のように出力されるべき単語が入力に代わりに、初めから正解の単語のシーケンスを与えて学習させることで効率を上げています。
入力と出力は１語ずれている事に注意してください。

さらにAttention を使用します。
入力シーケンス上の特定の単語は、特定の出力シーケンス上の単語に反応するように学習させます。
出力に特定の単語が出現したときに大きく反応するようにします。
入力の単語と出力の単語の関連性深さはAttention WeightとしてAttentionの内部で計算されます。
これを取り出し可視化することができます。

![Encoder and Decoder](images/neural-machine-translation-decoder.svg)

```php
class Decoder extends AbstractModel
{
    protected $backend;
    protected $vocabSize;
    protected $wordVectSize;
    protected $units;
    protected $targetLength;
    protected $embedding;
    protected $rnn;
    protected $attention;
    protected $concat;
    protected $dense;
    protected $attentionScores;

    public function __construct(
        $backend,
        $builder,
        int $vocabSize,
        int $wordVectSize,
        int $units,
        int $inputLength,
        int $targetLength
        )
    {
        $this->backend = $backend;
        $this->vocabSize = $vocabSize;
        $this->wordVectSize = $wordVectSize;
        $this->units = $units;
        $this->inputLength = $inputLength;
        $this->targetLength = $targetLength;
        $this->embedding = $builder->layers()->Embedding(
            $vocabSize, $wordVectSize,
            ['input_length'=>$targetLength]
        );
        $this->rnn = $builder->layers()->GRU($units,
            ['return_state'=>true,'return_sequences'=>true,
             'recurrent_initializer'=>'glorot_uniform']
        );
        $this->attention = $builder->layers()->Attention();
        $this->concat = $builder->layers()->Concatenate();
        $this->dense = $builder->layers()->Dense($vocabSize);
    }

    protected function call(
        object $inputs,
        bool $training,
        array $initial_state=null,
        array $options=null
        ) : array
    {
        $K = $this->backend;
        $encOutputs=$options['enc_outputs'];

        $x = $this->embedding->forward($inputs,$training);
        [$rnnSequence,$states] = $this->rnn->forward(
            $x,$training,$initial_state);

        $contextVector = $this->attention->forward(
            [$rnnSequence,$encOutputs],$training,$options);
        if(is_array($contextVector)) {
            [$contextVector,$attentionScores] = $contextVector;
            $this->attentionScores = $attentionScores;
        }
        $outputs = $this->concat->forward([$contextVector, $rnnSequence],$training);

        $outputs = $this->dense->forward($outputs,$training);
        return [$outputs,$states];
    }

    public function getAttentionScores()
    {
        return $this->attentionScores;
    }
}
```

Loss functionとSeq2Seqモデル
----------
これまで作ってきたDecoderとEncoderを組み合わせて目的のモデルを作成しましょう。

Loss functionはSparse Categorical Crossentropyを使用します。
ただし、出力シーケンスを比較する時に１ワードずれている事を思い出してください。
カスタムモデルの特別なメソッドを使って比較するシーケンスをずらしておきましょう。

さらに、訓練を終えたモデルに翻訳を実行させるメソッドを加えます。
訓練時には正解の出力シーケンス全体を与えていた代わりに、
<start>から一単語づつ推論するようにすればよいだけです。
さらにAttention Weightも可視化します。

```php
class Seq2seq extends AbstractModel
{
    public function __construct(
        $mo,
        $backend,
        $builder,
        $inputLength=null,
        $inputVocabSize=null,
        $outputLength=null,
        $targetVocabSize=null,
        $wordVectSize=8,
        $units=256,
        $startVocId=0,
        $endVocId=0,
        $plt=null
        )
    {
        parent::__construct($backend,$builder);
        $this->encoder = new Encoder(
            $backend,
            $builder,
            $inputVocabSize,
            $wordVectSize,
            $units,
            $inputLength
        );
        $this->decoder = new Decoder(
            $backend,
            $builder,
            $targetVocabSize,
            $wordVectSize,
            $units,
            $inputLength,
            $outputLength
        );
        $this->out = $builder->layers()->Activation('softmax');
        $this->mo = $mo;
        $this->backend = $backend;
        $this->startVocId = $startVocId;
        $this->endVocId = $endVocId;
        $this->inputLength = $inputLength;
        $this->outputLength = $outputLength;
        $this->units = $units;
        $this->plt = $plt;
    }

    protected function call($inputs, $training, $trues)
    {
        $K = $this->backend;
        [$encOutputs,$states] = $this->encoder->forward($inputs,$training);
        $options = ['enc_outputs'=>$encOutputs];
        [$outputs,$dmyStatus] = $this->decoder->forward($trues,$training,$states,$options);
        $outputs = $this->out->forward($outputs,$training);
        return $outputs;
    }

    public function shiftLeftSentence(
        NDArray $sentence
        ) : NDArray
    {
        $K = $this->backend;
        $shape = $sentence->shape();
        $batchs = $shape[0];
        $zeroPad = $K->zeros([$batchs,1],$sentence->dtype());
        $seq = $K->slice($sentence,[0,1],[-1,-1]);
        $result = $K->concat([$seq,$zeroPad],$axis=1);
        return $result;
    }

    protected function trueValuesFilter(NDArray $trues) : NDArray
    {
        return $this->shiftLeftSentence($trues);
    }

    public function predict(NDArray $inputs, array $options=null) : NDArray
    {
        $K = $this->backend;
        $attentionPlot = $options['attention_plot'];
        $inputs = $K->array($inputs);

        if($inputs->ndim()!=2) {
            throw new InvalidArgumentException('inputs shape must be 2D.');
        }
        $batchs = $inputs->shape()[0];
        if($batchs!=1) {
            throw new InvalidArgumentException('num of batch must be one.');
        }
        $status = [$K->zeros([$batchs, $this->units])];
        [$encOutputs, $status] = $this->encoder->forward($inputs, $training=false, $status);

        $decInputs = $K->array([[$this->startVocId]],$inputs->dtype());

        $result = [];
        $this->setShapeInspection(false);
        for($t=0;$t<$this->outputLength;$t++) {
            [$predictions, $status] = $this->decoder->forward(
                $decInputs, $training=false, $status,
                ['enc_outputs'=>$encOutputs,'return_attention_scores'=>true]);

            # storing the attention weights to plot later on
            $scores = $this->decoder->getAttentionScores();
            $this->mo->la()->copy(
                $K->ndarray($scores->reshape([$this->inputLength])),
                $attentionPlot[$t]);

            $predictedId = $K->scalar($K->argmax($predictions[0][0]));

            $result[] = $predictedId;

            if($this->endVocId == $predictedId) {
                $t++;
                break;
            }

            # the predicted ID is fed back into the model
            $decInputs = $K->array([[$predictedId]],$inputs->dtype());
        }

        $this->setShapeInspection(true);
        $result = $K->array([$result],NDArray::int32);
        return $K->ndarray($result);
    }

    public function plotAttention(
        $attention, $sentence, $predictedSentence)
    {
        $plt = $this->plt;
        $config = [
            'frame.xTickPosition'=>'up',
            'frame.xTickLabelAngle'=>90,
            'figure.topMargin'=>100,
        ];
        $plt->figure(null,null,$config);
        $sentenceLen = count($sentence);
        $predictLen = count($predictedSentence);
        $image = $this->mo->zeros([$predictLen,$sentenceLen],$attention->dtype());
        for($y=0;$y<$predictLen;$y++) {
            for($x=0;$x<$sentenceLen;$x++) {
                $image[$y][$x] = $attention[$y][$x];
            }
        }
        $plt->imshow($image, $cmap='viridis',null,null,$origin='upper');

        $plt->xticks($this->mo->arange(count($sentence)),$sentence);
        $predictedSentence = array_reverse($predictedSentence);
        $plt->yticks($this->mo->arange(count($predictedSentence)),$predictedSentence);
    }
}
```


訓練
--------
モデルのクラスが完成したのでデータを与えて訓練します。

テスト可能な規模をマシンに合わせてパラメータを選びます。
主な条件は以下の通りです。

```php
$numExamples=20000;#30000
$numWords=null;
$epochs = 10;
$batchSize = 64;
$wordVectSize=256;
$units=1024;
```

まずシーケンスデータを作成しましょう

```php
$mo = new MatrixOperator();
$nn = new NeuralNetworks($mo);
$pltConfig = [];
$plt = new Plot($pltConfig,$mo);

$dataset = new EngFraDataset($mo);

echo "Generating data...\n";
[$inputTensor, $targetTensor, $inpLang, $targLang]
    = $dataset->loadData(null,$numExamples,$numWords);
$valSize = intval(floor(count($inputTensor)/10));
$trainSize = count($inputTensor)-$valSize;
$inputTensorTrain  = $inputTensor[[0,$trainSize-1]];
$targetTensorTrain = $targetTensor[[0,$trainSize-1]];
$inputTensorVal  = $inputTensor[[$trainSize,$valSize+$trainSize-1]];
$targetTensorVal = $targetTensor[[$trainSize,$valSize+$trainSize-1]];

$inputLength  = $inputTensor->shape()[1];
$outputLength = $targetTensor->shape()[1];
$inputVocabSize = $inpLang->numWords();
$targetVocabSize = $targLang->numWords();
$corpusSize = count($inputTensor);

echo "num_examples: $numExamples\n";
echo "num_words: $numWords\n";
echo "epoch: $epochs\n";
echo "batchSize: $batchSize\n";
echo "embedding_dim: $wordVectSize\n";
echo "units: $units\n";
echo "Total questions: $corpusSize\n";
echo "Input  word dictionary: $inputVocabSize(".$inpLang->numWords(true).")\n";
echo "Target word dictionary: $targetVocabSize(".$targLang->numWords(true).")\n";
echo "Input length: $inputLength\n";
echo "Output length: $outputLength\n";

# Generating data...
# num_examples: 20000
# num_words:
# epoch: 10
# batchSize: 64
# embedding_dim: 256
# units: 1024
# Total questions: 20000
# Input  word dictionary: 6828(6828)
# Target word dictionary: 3389(3389)
# Input length: 17
# Output length: 9
```

モデルをインスタンス化してコンパイルします。
```php
$seq2seq = new Seq2seq(
    $mo,
    $nn->backend(),
    $nn,
    $inputLength,
    $inputVocabSize,
    $outputLength,
    $targetVocabSize,
    $wordVectSize,
    $units,
    $targLang->wordToIndex('<start>'),
    $targLang->wordToIndex('<end>'),
    $plt
);

echo "Compile model...\n";
$seq2seq->compile([
    'loss'=>'sparse_categorical_crossentropy',
    'optimizer'=>'adam',
    'metrics'=>['accuracy','loss'],
]);
$seq2seq->summary();

# Compile model...
# Layer(type)                  Output Shape               Param #
# ==================================================================
# Embedding(Embedding)         (17,256)                   1747968
# GRU(GRU)                     (17,1024)                  3938304
# Embedding_1(Embedding)       (9,256)                    867584
# GRU_1(GRU)                   (9,1024)                   3938304
# Attention(Attention)         (9,1024)                   0
# Concatenate(Concatenate)     (9,2048)                   0
# Dense(Dense)                 (9,3389)                   6944061
# Activation(Activation)       (9,3389)                   0
# ==================================================================
# Total params: 17436221
```


Seq2Seqモデルを訓練します。

```php
$modelFilePath = __DIR__."/neural-machine-translation-with-attention.model";

if(file_exists($modelFilePath)) {
    echo "Loading model...\n";
    $seq2seq->loadWeightsFromFile($modelFilePath);
} else {
    echo "Train model...\n";
    $history = $seq2seq->fit(
        $inputTensorTrain,
        $targetTensorTrain,
        [
            'batch_size'=>$batchSize,
            'epochs'=>$epochs,
            'validation_data'=>[$inputTensorVal,$targetTensorVal],
            #callbacks=[checkpoint],
        ]);
    $seq2seq->saveWeightsToFile($modelFilePath);

    $plt->figure();
    $plt->plot($mo->array($history['accuracy']),null,null,'accuracy');
    $plt->plot($mo->array($history['val_accuracy']),null,null,'val_accuracy');
    $plt->plot($mo->array($history['loss']),null,null,'loss');
    $plt->plot($mo->array($history['val_loss']),null,null,'val_loss');
    $plt->legend();
    $plt->title('seq2seq-attention-translation');
}
# Train model...
# Train on 18000 samples, validation on 2000 samples
# Epoch 1/10 [.........................] 3319 sec. remaining:00:00  - 3448 sec.
#  loss:2.3151 accuracy:0.6364 val_loss:1.6268 val_accuracy:0.7265
# Epoch 2/10 [.........................] 3298 sec. remaining:00:00  - 3425 sec.
#  loss:1.4021 accuracy:0.7504 val_loss:1.2861 val_accuracy:0.7754
# Epoch 3/10 [.........................] 3291 sec. remaining:00:00  - 3420 sec.
#  loss:1.0953 accuracy:0.7883 val_loss:1.1134 val_accuracy:0.7985
# Epoch 4/10 [.........................] 3141 sec. remaining:00:00  - 3267 sec.
#  loss:0.8774 accuracy:0.8157 val_loss:0.9888 val_accuracy:0.8165
# Epoch 5/10 [.........................] 3300 sec. remaining:00:00  - 3428 sec.
#  loss:0.6936 accuracy:0.8417 val_loss:0.8959 val_accuracy:0.8287
# Epoch 6/10 [.........................] 3300 sec. remaining:00:00  - 3427 sec.
#  loss:0.5343 accuracy:0.8693 val_loss:0.8264 val_accuracy:0.8472
# Epoch 7/10 [.........................] 3293 sec. remaining:00:00  - 3420 sec.
#  loss:0.3985 accuracy:0.8960 val_loss:0.7860 val_accuracy:0.8595
# Epoch 8/10 [.........................] 3298 sec. remaining:00:00  - 3425 sec.
#  loss:0.2893 accuracy:0.9202 val_loss:0.7500 val_accuracy:0.8672
# Epoch 9/10 [.........................] 3297 sec. remaining:00:00  - 3424 sec.
#  loss:0.2175 accuracy:0.9386 val_loss:0.7444 val_accuracy:0.8767
# Epoch 10/10 [.........................] 3296 sec. remaining:00:00  - 3423 sec.
#  loss:0.1702 accuracy:0.9519 val_loss:0.7359 val_accuracy:0.8811
```

![Encoder and Decoder](images/neural-machine-translation-training.png)


Predict
------

学習したモデルで機械翻訳をしてみましょう。

また、翻訳する時のattention-scoresを可視化して、入力の単語が特定の出力の単語に反応しているかどうかも見てみましょう。

```php
$choice = $mo->random()->choice($corpusSize,10,false);
foreach($choice as $idx)
{
    $question = $inputTensor[$idx]->reshape([1,$inputLength]);
    $attentionPlot = $mo->zeros([$outputLength, $inputLength]);
    $predict = $seq2seq->predict(
        $question,['attention_plot'=>$attentionPlot]);
    $answer = $targetTensor[$idx]->reshape([1,$outputLength]);;
    $sentence = $inpLang->sequencesToTexts($question)[0];
    $predictedSentence = $targLang->sequencesToTexts($predict)[0];
    $targetSentence = $targLang->sequencesToTexts($answer)[0];
    echo "Input:   $sentence\n";
    echo "Predict: $predictedSentence\n";
    echo "Target:  $targetSentence\n";
    echo "\n";
    $q = [];
    foreach($question[0] as $n) {
        if($n==0)
            break;
        $q[] = $inpLang->indexToWord($n);
    }
    $p = [];
    foreach($predict[0] as $n) {
        if($n==0)
            break;
        $p[] = $targLang->indexToWord($n);
    }
    $seq2seq->plotAttention($attentionPlot,  $q, $p);
}
$plt->show();

# Input:   <start> j ai besoin de soutien . <end>
# Predict: i need support . <end>
# Target:  <start> i need support . <end>
#
# Input:   <start> est ce sérieux  ? <end>
# Predict: no kidding ? <end>
# Target:  <start> is it serious ? <end>
#
# Input:   <start> magnifique  ! <end>
# Predict: wonderful ! <end>
# Target:  <start> terrific ! <end>
#
# Input:   <start> je m aime . <end>
# Predict: i like myself . <end>
# Target:  <start> i love myself . <end>
#
# Input:   <start> vous n êtes pas une sainte . <end>
# Predict: you re no saint . <end>
# Target:  <start> you re no saint . <end>
#
# Input:   <start> mille mercis . <end>
# Predict: many thanks . <end>
# Target:  <start> many thanks . <end>
#
# Input:   <start> il est poète . <end>
# Predict: he is a poet . <end>
# Target:  <start> he is a poet . <end>
#
# Input:   <start> fermez la porte ! <end>
# Predict: close the door . <end>
# Target:  <start> close the door . <end>
#
# Input:   <start> que peut on y faire ? <end>
# Predict: what do we do ? <end>
# Target:  <start> what can you do ? <end>
#
# Input:   <start> est ce vous ? <end>
# Predict: is it you ? <end>
# Target:  <start> is that you ? <end>
```

![Encoder and Decoder](images/neural-machine-translation-attention-scores.png)

実験程度の簡単なモデルにしては、上手に翻訳できている場合が多い事が分かります。

attention-scoresの画像は、上手く可視化できている場合と、わからない場合があるようです。
