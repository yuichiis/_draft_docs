## 概要

Rindow Math Matrixでは線形代数に関する関数を特別に切り出し`LinearAlgebra`ライブラリとしてまとめて提供しています。

このライブラリでは処理の高速化に重点を置いています。
それによって柔軟性や使い勝手の良さを犠牲にしているため、注意してください。

主に以下の関数群が含まれます。
- Basic Linear Algebra Subprograms (BLAS)の一部
- 配列の生成と初期化
- 配列に適応した基本的な数学関数
- 集合の操作
- 乱数生成

## 注意点
高速化に重点を置いているため、以下の点に注意してください。

- 多くの関数が1次元配列や2次元配列を対象にしています。多次元配列を処理する場合にはフラットな配列に変換してから使用する必要があります。
- 通常の数学ライブラリと違って破壊的関数が多いです。入力値は破壊され演算結果が同じ空間に上書きされます。
- 配列のアロケートと初期化は分離しています。出力専用の領域として配列を生成したい場合には、初期化の時間が無駄になるからです。
- 機械学習に使用する複雑な非線形関数や活性化関数は含まれていません。しかしこれらの関数を使って作ることが出来ます。
- 現在のところ複素数を扱うことが出来るのはBLASの関数に限ります。

## 基本的な使い方
MatrixOperatorからライブラリのオブジェクトを生成して使います。
配列の生成から演算までの例は以下のようになります。

この例では配列の生成を`alloc()`で行った後に`ones()`で初期化したり、`array()`で直接要素の数値を与えて配列の生成をしたりしています。

また、`axpy()`では`$b`を入力値として与えていますが、入力値は上書きされて、出力が`$b`に返されています。

`axpy()`はBLAS関数の一つで、高速な外部ライブラリにリンクしている場合はとても高速な演算が可能です。

```php
use Rindow\Math\Matrix\MatrixOperator;
$mo = new MatrixOperator();
$la = $mo->la(); // LinearAlgebraを生成

$a = $la->ones($la->alloc([2,2],dtype:NDArray::float32));
$b = $la->array([[1,2],[3,4]],dtype:NDArray::float32);
$la->axpy($a,$b,alpha:2.0); // b = 2a + b
echo $mo->toString($b)."\n";
# [[3,4],[5,6]]
```
`axpy()`は`alpha`を省略して単純な足し算にも使え、さらに引き算にも使えます。
```php
$a = $la->array([[1,2],[3,4]],dtype:NDArray::float32);
$b = $la->array([[5,6],[7,8]],dtype:NDArray::float32);
$la->axpy($a,$b,alpha:-1.0); // b = b - a
echo $mo->toString($b)."\n";
# [[4,4],[4,4]]
```
`axpy()`の出力は`$b`に返されますが、関数は`$b`オブジェクトを戻り値として返すため以下のように書くこともできます。
これは2番目の引数に与えた配列領域が出力として使われるためです。入力用と出力用の配列領域を個別に生成する必要がありません。
```php
$c = $la->axpy(
    $la->array([[1,2],[3,4]],dtype:NDArray::float32),
    $la->array([[5,6],[7,8]],dtype:NDArray::float32),
    alpha:-1.0
);
echo $mo->toString($c)."\n";
# [[4,4],[4,4]]
```

このように`LinearAlegebla`ライブラリでは直感的な使いやすさを犠牲にして高速な演算を実現しています。

様々な関数の詳細は[こちら](/mathematics/api/linearalgebra.html)を参照してください。


## サービスレベル
`LinearAlegebla`ライブラリは外部ライブラリにリンクして高速な演算を行うことが一般的な使い方ですが、P純粋なPHPだけで動作することも出来ます。

- **Basic**: 純粋なPHPで動作するしますが低速です。
- **Advanced**: 外部ライブラリにリンクして演算を高速化します。
- **Accelarated**: 外部の高速化ハードウェアライブラリが利用可能。

ステータスコマンドで確認できるサービスレベルがBasicの場合は外部ライブラリが利用できません。
また、サービスレベルが"Accelarated"の場合はGPUなどのハードウェアによる高速化ライブラリが利用できます。

現在はGPUに対応した高速化ライブラリを使う場合は`LinearAlegebla`と互換性のある専用のライブラリを使用します。
したがって、`$mo->la()`で生成したライブラリオブジェクトとは違うGPU専用のライブラリオブジェクトを生成する必要があります。
これはステータスコマンドで確認できるモードが"Accelerated"の時も、明示的にGPU専用のライブラリオブジェクトを生成する必要がある事を意味します。

```php
$lacu = $mo->laAccelerated('clblast',['deviceType'=>OpenCL::CL_DEVICE_TYPE_GPU]);
```

## ハードウェアによる高速化
Rindow Math Matrixではさまざまなプラグインを組み込むことが出来るようになっています。
初めから組み込まれているプラグインはOpenCLを使ったハードウェアアクセラレーション用の`LinearAlgebraCL`です。

これは標準の`LinearAlgrebra`に準拠したインターフェースになっていますが、様々なところで使用方法が異なります。

一般にGPUを使う場合はデータをCPUのメモリー領域からGPUのメモリー領域に転送します。
この転送時間が処理全体のボトルネックになります。したがってなるべく転送が必要な処理させないようにあらかじめインターフェースが制限されていたり、得られる値が転送の必要がない形式に変更されていたりします。

すなわち、コードの完全な互換性はありません。

CPUとGPUのどちらでも動くコードを書くためには工夫が必要となります。

## LinearAlgebraCLの基本的な使い方
配列の生成から演算までの例は以下のようになります。
CPUとGPUのメモリー領域の違いを常に意識して使用してください。

```php
use Rindow\Math\Matrix\MatrixOperator;
$mo = new MatrixOperator();
$la = $mo->la(); // LinearAlgebraを生成
$lacu = $mo->laAccelerated('clblast',['deviceType'=>OpenCL::CL_DEVICE_TYPE_GPU]);
$lacu->blocking(true); // ブロッキングモードを有効化

// CPU上で配列を生成
$a = $la->ones($la->alloc([2,2],dtype:NDArray::float32));
$b = $la->array([[1,2],[3,4]],dtype:NDArray::float32);
// GPUに配列を転送
$a = $lacu->array($a);
$b = $lacu->array($b);
// GPU上で演算
$lacu->axpy($a,$b,alpha:2.0); // b = 2a + b
// CPUに結果を転送
$b = $lacu->toNDArray($b);
echo $mo->toString($b)."\n";
# [[3,4],[5,6]]
```
非同期処理に対応している関数と対応していない関数があるため、それらを意識したくない場合は`blocking(true)`を使って非同期処理を使用しないように設定してください。デフォルトでは非同期処理されるので処理終了待ちが必要です。

## LinearAlgebraCLの戻り値
`LinearAlgebraCL`の関数の戻り値がscaler値である場合、デフォルトではPHPのfloatやintではなくGPUメモリ上のNDArray型のscaler値が返されます。
これはもし戻り値がPHPのscaler値であった場合は、関数が終わるごとにGPUからCPUに転送してさらにPHPの数値に変換する、そしてまた次の関数を呼ぶためにGPUへ転送という工程になるためとても多くの時間がかかってしまいます。GPUメモリのまま返されれば次のGPU上の演算でそのまま使えます。
もし標準の`LinearAlgebra`と同じくPHPの数値で返したいのであれば`scalarNumeric(true)`を使って明示的に設定してください。

```php
$lacu = $mo->laAccelerated('clblast',['deviceType'=>OpenCL::CL_DEVICE_TYPE_GPU]);
$a = $lacu->array([[1,2],[3,4]],dtype:NDArray::float32);
$asum = $lacu->sum($a);
echo get_class($asum) ."\n";
echo $mo->toString($asum)."\n";
# Rindow\Math\Matrix\NDArrayCL
# 10

$lacu->scalarNumeric(true);
$asum = $lacu->sum($a);
echo gettype($asum)."\n";
echo $asum."\n";
# float
# 10
```

## NDArrayCLの配列アクセス
`LinearAlgebraCL`で取り扱うNDArray型の配列は、`NDArrayCL`オブジェクトです。
現在のバージョンのこの配列型では値の取り出しおよび書き込みに制限があります。
`offsetGet`は`offsetSet`によって取り扱う値がPHPのscaler値になってしま場合は例が投げられます。
例えば1次元配列の1つの要素を取り出そうとすると例外が発生します。
```php
$a = $lacu->array([1,2,3,4]);
$value = $a[0];
# 例外 OutOfRangeException("This object is scalar.")
```
アクセスする値が配列の場合は、NDArrayCLオブジェクトが生成され返されます。
例えば2次元配列で1つの行を取り出そうとすると以下のようになります。
```php
$a = $lacu->array([[1,2],[3,4]]);
$row = $a[0];
echo $mo->toString($row)."\n";
# [1,2]
```
したがって、一次元配列から要素を１つ取り出したい場合は以下のようになります。
```php
$a = $lacu->array([1,2,3,4]);
$value = $a[[0,1]];
echo $mo->toString($value)."\n";
# [1]
```

ただし、PHPのscaler値の取り扱いについて将来のバージョンで全般的に変更される可能性があります。


## 非同期モード
`LinearAlgebraCL`では非同期モードがデフォルトですが、現在はCLBlastの仕様により演算のパイプライン化ができません。前段の演算が終了したことを次の演算に知らせる仕組みがCLBlastにはありません。
そのため、CLBlast以外のほとんどの関数では現実的な非同期モードで使うことができますが、
CLBlastを呼び出す関数では、関数の実行は非同期で出来ますが、前段の関数の終了のイベント待ちがPHP側で必須となるため事実上非同期実行の意味がありません。

CLBlast以外の非同期実行の例は以下のようになります。
```php
$lacu = $mo->laAccelerated('clblast',['deviceType'=>OpenCL::CL_DEVICE_TYPE_GPU]);
$lacu->blocking(false); // 非同期モードを有効化(デフォルト状態)

$a = $lacu->array([[1,2],[3,4]],dtype:NDArray::float32);
$b = $lacu->array([[5,6],[7,8]],dtype:NDArray::float32);

// square用のイベントリストを生成
$squareEvents = $lacu->newEvents();
// squareをキューイングしてイベントを取得
$lacu->square($a,events:$squareEvents);
// add用のイベントリストを生成
$addEvents = $lacu->newEvents();
// squareの終了を待ちを指定を添えてaddをキューイングしてイベントを取得
$lacu->add($a,$b,events:$addEvents,waitEvents:$squareEvents);
// addの終了を待ち
$addEvents->wait();
echo $mo->toString($b)."\n";
# [[6,10],[16,24]]
```

CLBlastの関数の非同期実行の例は以下のようになります。
waitEventsが使用できません。
```php
$lacu = $mo->laAccelerated('clblast',['deviceType'=>OpenCL::CL_DEVICE_TYPE_GPU]);
$lacu->blocking(false); // 非同期モードを有効化(デフォルト状態)

$a = $lacu->array([[1,2],[3,4]],dtype:NDArray::float32);
$b = $lacu->array([[5,6],[7,8]],dtype:NDArray::float32);

// square用のイベントリストを生成
$squareEvents = $lacu->newEvents();
// squareをキューイングしてイベントを取得
$lacu->square($a,events:$squareEvents);
// squareの終了を待ち
$squareEvents->wait();
// addをキューイングしてイベントを取得
$lacu->axpy($a,$b,events:$addEvents); // waitEventsが使用できない
// addの終了を待ち
$addEvents->wait();
echo $mo->toString($b)."\n";
# [[6,10],[16,24]]
```
