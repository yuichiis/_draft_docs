NDArray インターフェース
-----------------
### 概要
Rindow Math Matrixは、N次元配列型であるNDArrayを提供します。これは同じ型の「アイテム」のコレクションを表します。アイテムは、例えばN個の浮動小数点値を使用してインデックス付けすることができます。

NDArrayに含まれるすべてのアイテムは同じ型の値を持ちます。すべてのアイテムは標準PHPインターフェースである「ArrayAccess」によって指定されます。1つの値のデータ型は、NDArrayで定義された整数型、浮動小数点型、またはブール型です。

N次元配列は1次元配列バッファにマッピングされ、連続した領域として格納されます。

![NDArray](images/ndarray.png)

最も重要なのは、NDArrayインターフェースがRindowフレームワークの一部ではないことです。**インターフェースは独立して定義されており**、他のフレームワークでも自由に実装することができます。

```php
use Interop\Polite\Math\Matrix\NDArray;
```

詳細は[interop-phpobjects/polite-math](https://github.com/interop-phpobjects/polite-math)を参照してください。

### メソッド

#### offsetGet
アイテムはArrayAccessインターフェースの「offsetGet」によって取得されます。

2次元以上のNDArrayでは、「offsetGet」メソッドを使用してNDArray型を返します。これにより、N次元配列が実装されます。
この時、バッファはコピーされず、2つのNDArrayで共有されます。

```php
# $aはNDArray上のfloat32の2次元配列
$b = $a[1];
# $bはNDArray上のfloat32の1次元配列
if($b instaceof NDArray) {
    echo "bはNDArrayです\n";
}
if($b[2]==$a[1][2]) {
    echo "同じアイテムです\n"
}
# $cは
if(spl_object_id($a->buffer())==spl_object_id($b->buffer())) {
    echo "バッファが共有されています！！\n";
}
```

添字に範囲を指定することもできます。範囲はPHP配列で指定します。

指定された範囲をNDArrayとして返します。この時もバッファは共有されます。

```php
# $aはNDArray上のfloat32の2次元配列
$b = $a[[1,4]];
# $bは1から3を参照するfloat32のNDArrayの2次元配列
```

> バージョン1では[1,3]でしたが、バージョン2からは[1,4]と記述するようになりました。
> これは他のシステムとの整合性を取るためであり、多くの場合、記述を簡略化するためです。

#### offsetSet
ArrayAccessインターフェースのoffsetSetを使用してアイテムを設定します。

2次元以上のNDArrayに対して「offsetSet」メソッドを使用する場合、配列をコピーします。
コピーする配列は同じ形状でなければなりません。

```php
# $aはNDArray上のfloat32の2次元配列 shape=[3,2]
# $bはNDArray上のfloat32の1次元配列 shape=[2]
$a[1] = $b;
```

#### offsetExists
NDArray配列の範囲内には常に値が存在するため、「offsetExists」は範囲チェックの結果を返します。

#### offsetUnset
アイテムの領域を削除することはできません。

#### count
NDArrayの第一次元の個数を返します。
```php
# $aはNDArray上のfloat32の2次元配列 shape=[3,2]
echo $a->count() . "\n";
# 3
echo count($a) . "\n";
# 3
```

#### dtype
NDArrayのデータタイプを返します。
```php
# $aはNDArray上のfloat32の2次元配列 shape=[3,2]
echo $a->dtype() . "\n";
# 12 // NDArray::float32
```

#### shape
NDArrayで定義されたN次元配列の形状を取得します。

```php
$shape = $a->shape();
var_dump($shape);
# array(2) {
#   [0]=>
#   int(3)
#   [1]=>
#   int(2)
# }
```

#### ndim
配列の次元数を取得します。

```php
# $aはNDArray上のfloat32の2次元配列 shape=[3,2]
$ndim = $a->ndim();
echo $ndim;
# 2
```

#### buffer
バッファオブジェクトを取得します。

```php
$buffer = $a->buffer();
```

#### offset
NDArrayがバッファオブジェクトを参照するオフセットを取得します。

```php
$offset = $a->offset();
```

#### size
配列内のアイテムの総数を取得します。バッファのサイズではありません。

```php
# $aはNDArray上のfloat32の2次元配列 shape=[3,2]
$size = $a->size();
echo $size."\n";
# 6
```

#### reshape
配列の形状を変更したNDArrayを取得します。元の配列と同じサイズでなければなりません。バッファは共有されます。コピーではないためreshape後の配列の内容を更新すると元の配列も更新されます。

```php
# $aはNDArray上のfloat32の2次元配列 shape=[3,2]
$flatA = $a->reshape([6]);
```

#### toArray
NDArrayをPHP配列型に変換します。

```php
$array = $a->toArray();
```

### 定数
NDArrayはそのデータ型を表す定数を持っています。

利便性のためにさまざまなデータ型が定義されていますが、すべてを実装する必要はありません。

- bool
- int8
- int16
- int32
- int64
- uint8
- uint16
- uint32
- uint64
- float8
- float16
- float32
- float64
- complex16
- complex32
- complex64
- complex128

バッファオブジェクト
-------------
### 概要
バッファオブジェクトはNDArrayの実際のデータを格納する領域です。1次元配列を実装します。
PHPの標準ArrayAccessインターフェースとCountableインターフェースを実装する必要があります。
様々な実装が使用されることを想定しているため、基本的なBufferインターフェースが定義されています。

1次元配列はどのような方法でも実装できますが、連続したメモリ領域は一般的にCPUが高速な操作を行うのに適しています。C言語レベルでメモリ領域を参照するのが容易であり、高速計算ライブラリとのデータ交換も容易です。

これらの理由から、NDArrayはPHP配列ではなく、1次元配列バッファオブジェクトを使用します。
またこのインターフェースもRindowフレームワークの一部ではなく、**インターフェースは独立して定義されており**、他のフレームワークでも自由に実装することができます。

```php
use Interop\Polite\Math\Matrix\Buffer;
```

### メソッド

#### offsetGet
インデックスは整数でなければなりません。
アイテムの値を取得します。

#### offsetSet
インデックスは整数でなければなりません。
アイテムの値を設定します。

#### offsetExists
インデックスは整数でなければなりません。
インデックスが範囲内かどうかを返します。

#### offsetUnset
インデックスは整数でなければなりません。
アイテムをゼロに設定します。

#### count
アイテムの数を取得します。予約されたメモリサイズではありません。

リニアバッファーオブジェクト
---------------
基本のBufferインターフェースでは内部のバイナリー表現は規定していませんが、LinerBufferでは内部表現でフラットなメモリー領域であることを保証します。これはC言語インターフェースによって外部ライブラリにデータを渡せる事を意味しています。

メソッドは基本のBufferインターフェースを継承します。

```php
use Interop\Polite\Math\Matrix\LinearBuffer;
```


デバイスバッファーオブジェクト
----------------
リニアバッファーが直接メモリー空間にアクセスできることを保証するのに対して、デバイスバッファーはデーター領域が別のハードウェア上にある場合を表します。これはGPUメモリーのようにCPUから直接アクセスできない領域にデータがある場合を意味します。
例えばデバイスバッファーインターフェースを持っている場合は、リニアバッファにコピーしてから要素を取り出すなどの処理を行うことが出来ます。

メソッドは基本のBufferインターフェースを継承します。

```php
use Interop\Polite\Math\Matrix\DeviceBuffer;
```

