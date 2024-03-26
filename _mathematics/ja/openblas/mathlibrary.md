概要
--------
「Math」ライブラリは、機械学習に有用な頻繁に使用される行列演算のライブラリです。
BLAS と組み合わせて使用すると、行列演算をバッファオブジェクト内ですべての演算を完了できます。
行列演算を高速に処理するには、PHP の数値変数とバッファー間のデータ交換の数を最小限に抑えることが非常に重要です。


実装されたMethodたち
---------------------
メモリ空間は Buffer オブジェクト経由で受信され、Math ライブラリに渡されます。

現在、次の機能がサポートされています。

- sum
- imax
- imin
- increment
- reciprocal
- maximum
- minimum
- greater
- greaterEqual
- less
- lessEqual
- multiply
- add
- duplicate
- square
- sqrt
- rsqrt
- pow
- exp
- log
- tanh
- sin
- con
- tan
- zeros
- updateAddOnehot
- softmax
- equal
- notEqual
- not
- astype
- matrixcopy
- imagecopy
- fill
- nan2num
- isnan
- searchsorted
- cumsum
- transpose
- bandpart
- gather
- reduceGather
- slice
- repeat
- reduceSum
- reduceMax
- reduceArgMax
- randomUniform
- randomNormal
- randomSequence
- im2col1d
- im2col2d
- im2col3d

Usage on PHP
------------
Here is the sample code.

```php
use Interop\Polite\Math\Matrix\NDArray;
$bufferFactory = new Rindow\Math\Buffer\FFI\BufferFactory()
$matlibFactory = new Rindow\Matlib\FFI\MatlibFactory()
$x = $bufferFactory->Buffer(3,NDArray::float32);
$math = $matlibFactory->Math();
$x[0] = 1.0;
$x[1] = 1.5;
$x[2] = 2.0;
$sum = $math->sum(count($x),$x,$offset=0,$incX=1);
### sum => 4.5
```
