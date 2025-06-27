## 概要

"Math"ライブラリは、BLASに含まれていない様々な行列演算の関数を提供する低いレイヤーライブラリです。
現在は機械学習で頻繁に使用される関数が主に含まれています。

柔軟性や移植性を考慮して`Buffer`インターフェースを使った低いレイヤーなインターフェースとなっているため、ユーザーの使いやすい高度なライブラリのバックエンドとして動作することを想定しています。
Rindow-Math-Matrixでもバックエンドとして動作します。

## 実装方法

現在は環境応じて３つのライブラリが用意されています。

* 純粋なPHPだけで記述され動作環境を選ばずに利用できる`PhpMath`クラス
* C言語インターフェースのRindow-Matibを呼び出し高速な演算をする`rindow-mathlib-ffi`パッケージ
* OpenCLを使ってGPUで高速な演算を行う`OpenCLMath`クラス。

> GPUの利用方法についての詳細は、[こちら](/mathematics/acceleration/mathematics/opencl.html) を参照してください。

これらのライブラリは`LinearAlegebla`ライブラリのバックエンドとして環境に応じて切り替えて使うことが出来ます。
また、Mathライブラリと同じインターフェースの独自のライブラリを作成してバックエンドとして登録することも出来ます。


## 実装されているメソッド

現在、以下の機能がサポートされています。

- sum (合計)
- imax (最大値のインデックス)
- imin (最小値のインデックス)
- increment (インクリメント)
- reciprocal (逆数)
- maximum (最大値)
- minimum (最小値)
- greater (より大きい)
- greaterEqual (以上)
- less (より小さい)
- lessEqual (以下)
- multiply (乗算)
- add (加算)
- duplicate (複製)
- square (二乗)
- sqrt (平方根)
- rsqrt (逆平方根)
- pow (べき乗)
- exp (指数関数)
- log (自然対数)
- tanh (双曲線正接)
- sin (正弦)
- cos (余弦)
- tan (正接)
- zeros (ゼロで初期化された配列)
- updateAddOnehot (One-hotベクトルを加算して更新)
- softmax (ソフトマックス関数)
- equal (等しい)
- notEqual (等しくない)
- not (否定)
- astype (型変換)
- matrixcopy (行列のコピー)
- imagecopy (画像のコピー)
- fill (特定の値で埋める)
- nan2num (NaNを数値に置換)
- isnan (NaNであるかどうかの判定)
- searchsorted (ソートされた配列への要素の挿入位置を検索)
- cumsum (累積和)
- cumsumb (累積和)
- transpose (転置)
- bandpart (帯行列の一部を取得)
- gather (指定されたインデックスに基づいて要素を抽出)
- gatherb (指定されたインデックスに基づいて要素を抽出)
- reduceGather (指定されたインデックスに基づいて要素を抽出して削減)
- slice (スライス)
- repeat (繰り返し)
- reduceSum (要素の合計)
- reduceMax (要素の最大値)
- reduceArgMax (最大値のインデックス)
- randomUniform (一様分布に従う乱数)
- randomNormal (正規分布に従う乱数)
- randomSequence (乱数列)
- im2col1d (1次元のim2col)
- im2col2d (2次元のim2col)
- im2col3d (3次元のim2col)
- masking (マスキング処理)
- einsum (縮約関数)
- einsum4p1 (4+1縮約関数)


PHPでの使用方法
------------
サンプルコードを以下に示します。

```php
use Interop\Polite\Math\Matrix\NDArray;
$bufferFactory = new Rindow\Math\Buffer\FFI\BufferFactory();
$matlibFactory = new Rindow\Matlib\FFI\MatlibFactory();
$x = $bufferFactory->Buffer(3,NDArray::float32);
$math = $matlibFactory->Math();
$x[0] = 1.0;
$x[1] = 1.5;
$x[2] = 2.0;
$sum = $math->sum(count($x),$x,$offset=0,$incX=1);
### sum => 4.5
```
