---
layout: document
title: "自動微分"
upper_section: index
previous_section: custommodel
---

自動微分と勾配
-------------
カスタムモデルでは記述できない場合があります。
その場合、プログラマーは自動微分と勾配によって、ニューラルネットワークのパラメータの更新を直接記述することもできます。

自動微分は計算の過程を記録して、結果からさかのぼり勾配を求めます。勾配を使ってネットワークのパラメーター更新をすることができます。


変数
----
一般的に値と関数を使って計算しますが、自動微分をサポートする特別な変数と関数を使用します。


まずPHPでNDArrayの配列を作成します。これは値です。定数として自動微分では定数として扱われます。
```php
$mo = new Rindow\Math\Matrix\MatrixOperator();
$nn = new Rindow\NeuralNetworks\Builder\NeuralNetworks($mo);

$value = $mo->array([2,3]);
echo $mo->toString($value)."\n";
// [2,3]
```

これを変数に入れてみましょう。'gradient'ビルダーを使って変数を作ります。
```php
$g = $nn->gradient();
$a = $g->Variable($value);
echo $mo->toString($a)."\n";
// [2,3]
```

`$value`というPHP変数は自動微分では値なので自動微分の世界では一般的には、変数生成時にコピーされる事に注意してください。

```php
$value = $mo->array([2,3]);
$a = $g->Variable($value);
echo "a=".$mo->toString($a)."\n";
$value[0] = 0;
$value[1] = 0;
echo "value=".$mo->toString($value)."\n";
echo "a=".$mo->toString($a)."\n";
// a=[2,3]
// value=[0,0]
// a=[2,3]
```

変数に直接PHPのarrayを与えて配列の入った変数を生成することもできます。
```php
$b = $g->Variable([4,5]);
echo "b=".$mo->toString($b)."\n";
// b=[4,5]
```

関数
----
自動微分をサポートする関数も同様に'gradient'ビルダーを使って生成します。

```php
$a = $g->Variable(2.0);
$b = $g->Variable(3.0);
$c = $g->mul($a,$b);
echo "c=".$mo->toString($c)."\n";
// c=6
```
結果も変数として生成されます。


勾配計算
-------
勾配を計算するためには誤差逆伝播法を使います。そのために計算の過程を記録して計算結果から逆順にたどる必要があります。
`GradientTape`を使うとその中の計算は記録されて計算グラフが構築されます。
この例では`$tape`に記録されます。
```php
$a = $g->Variable(2.0);
$b = $g->Variable(3.0);

$c = $nn->with($tape=$g->GradientTape(),function() use ($g,$a,$b) {
    $c = $g->mul($a,$b);
    return $c;
});
echo "c=".$mo->toString($c)."\n";
// c=6
```

記録した`$tape`を使って勾配を計算します。

```php
[$da,$db] = $tape->gradient($c,[$a,$b]);
echo "da=".$mo->toString($da)."\n";
echo "db=".$mo->toString($db)."\n";
// da=3
// db=2
```


自動微分の最も基本的な使い方は以下のように記述されます。

```php
$mo = new Rindow\Math\Matrix\MatrixOperator();
$nn = new Rindow\NeuralNetworks\Builder\NeuralNetworks($mo);
$g = $nn->gradient();

$a = $g->Variable(2.0);
$b = $g->Variable(3.0);

$c = $nn->with($tape=$g->GradientTape(),function() use ($g,$a,$b) {
    $c = $g->mul($a,$b);
    return $c;
});

$grads = $tape->gradient($c,[$a,$b]);

echo "c=".$mo->toString($c)."\n";
echo "da=".$mo->toString($grads[0])."\n";
echo "db=".$mo->toString($grads[1])."\n";

// c=6
// da=3
// db=2
```

自動微分の計算の中では、関数やレイヤーやモデルや損失関数も使えます。
モデルやレイヤーの重み変数はtrainaleVariablesを使って取得できます。
```php
$a = $g->Variable($mo->array([[1,2,3],[2,3,4]]));
$x = $g->Variable($mo->array([[4,5,6],[5,6,7]]));
$target = $g->Variable($mo->array([0,1],NDArray::int32));

$dense = $nn->layers()->Dense(10);
$lossfunc = $nn->losses()->SparseCategoricalCrossentropy(from_logits:true);

$loss = $nn->with($tape=$g->GradientTape(),function() use ($g,$dense,$lossfunc,$x,$a,$target) {
    $x = $g->mul($x,$a);
    $x = $dense->forward($x);
    $loss = $lossfunc->forward($target,$x);
    return $loss;
});
$weights = $dense->trainableVariables();
$grads = $tape->gradient($loss,$weights);
```

この勾配データでパラメーターを更新します。
```php
$optimizer = $nn->optimizers()->SGD();
$optimizer->update($weights,$grads);
```


モデルのトレーニング
------------------
では実際にモデルを作ってトレーニングしてみましょう。

```php
include __DIR__.'/vendor/autoload.php';

use Rindow\NeuralNetworks\Model\AbstractModel;
use Rindow\NeuralNetworks\Layer\Layer;
$mo = new Rindow\Math\Matrix\MatrixOperator();
$nn = new Rindow\NeuralNetworks\Builder\NeuralNetworks($mo);
$K = $nn->backend();
$g = $nn->gradient();
$plt = new Rindow\Math\Plot\Plot(null,$mo);

class TestModel extends AbstractModel
{
    protected Layer $dense1;
    protected Layer $dense2;
    
    public function __construct(
        $backend,
        $builder
        )
    {
        parent::__construct($builder);
        $this->dense1 = $builder->layers->Dense($units=128,
                input_shape:[2], activation:'sigmoid'
            );
        $this->dense2 = $builder->layers->Dense($units=2);
    }

    protected function call($inputs,$training)
    {
        $x = $this->dense1->forward($inputs,$training);
        $outputs = $this->dense2->forward($x,$training);
        return $outputs;
    }
}

$model = new TestModel($K,$nn);
$lossfunc = $nn->losses->SparseCategoricalCrossentropy(from_logits:true);
$optimizer = $nn->optimizers->Adam();
$train_inputs = $mo->array([[1, 3], [1, 4], [2, 4], [3, 1], [4, 1], [4, 2]]);
$train_tests = $mo->array([0, 0, 0, 1, 1, 1],NDArray::int32);
$history = [];
$dataset = $nn->data->NDArrayDataset($train_inputs,
    tests:$train_tests,
    batch_size:64,
    shuffle:false,
);

for($epoch=0;$epoch<100;$epoch++) {
    $totalLoss = 0;
    foreach($dataset as $batchIndex => [$inputs,$trues]) {
        $x = $g->Variable($inputs);
        $t = $g->Variable($trues);
        [$loss,$predicts] = $nn->with($tape=$g->GradientTape(),
            function() use ($epoch,$K,$model,$lossfunc,$x,$t,$trues) {
                $predicts = $model($x,true,$t);
                return [$lossfunc($trues,$predicts),$predicts];
            }
        );
        $params = $model->trainableVariables();
        $gradients = $tape->gradient($loss, $params);

        $optimizer->update($params,$gradients);
        $totalLoss += $K->scalar($loss->value());
    }
    $history[] = $totalLoss;
}
$plt->plot($mo->array($history),null,null,'loss');
$plt->legend();
$plt->title('dynamic mode gradient');
$plt->show();
```


計算グラフのコンパイル
--------------------
自動微分機能の内部では計算グラフが使われます。
ただし、計算グラフは毎回作成され、使い切ると破棄されます。
計算グラフ作成機能を直接呼び出して作成し、何度も再利用できれば、無駄を省いて処理を高速化できる可能性があります。

```php
$mo = new Rindow\Math\Matrix\MatrixOperator();
$nn = new Rindow\NeuralNetworks\Builder\NeuralNetworks($mo);
$g = $nn->gradient();

$func = $g->Function(function($a,$b,$c) use ($g) {
    $x = $g->mul($a,$b);
    $y = $g->add($x,$c);
    return $y;
});

$a = $g->Variable(2.0);
$b = $g->Variable(3.0);
$c = $g->Variable(4.0);

// compile function graph
$z = $nn->with($tape=$g->GradientTape(),function() use ($g,$func,$a,$b,$c) {
    $y = $func($a,$b,$c);
    return $g->square($y);
});
$grads = $tape->gradient($z,[$a,$b]);

// execute compiled function
$z = $nn->with($tape=$g->GradientTape(),function() use ($g,$func,$a,$b,$c) {
    $y = $func($a,$b,$c);
    return $g->square($y);
});
$grads = $tape->gradient($z,[$a,$b]);

echo "z=".$mo->toString($c)."\n";
echo "da=".$mo->toString($grads[0])."\n";
echo "db=".$mo->toString($grads[1])."\n";
```
