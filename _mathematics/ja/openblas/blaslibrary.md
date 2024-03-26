
Rindow\\OpenBLAS\\FFI\\Blas クラスは、OpenBLAS を php で利用できるようにします。

BLASとは
------------
「BLAS」は、Basic Linear Algebra Subprograms ライブラリです。
これは、基本的なベクトルおよび行列演算を実行するための標準的な構成要素を提供するルーチンです。
BLAS は効率的で移植可能であり、広く利用できるため、高品質の線形代数ソフトウェアの開発によく使用されます。

OpenBLASは、BLASを実装したC言語インターフェースを備えた代表的なライブラリです。
詳細は[OpenBLAS Webサイト](https://www.openblas.net/)をご覧ください。


実装されたMethodたち
---------------------
BLAS ライブラリは非常に多くの関数を提供しますが、この Rindow OpenBLAS FFI は未実装の関数が少し残されています。
Version 2.0から複素数をサポートするようになりました。

メモリ空間は Buffer オブジェクト経由で受信され、OpenBLAS ライブラリに渡されます。
OpenBLAS の C 言語インターフェイスとの違いは、バッファ オブジェクトとオフセットを使用してメモリ空間の開始アドレスを表すことです。 これは、多次元配列を扱うときにメモリのコピーの数を最小限に抑えるためです。

最も重要なことは、OpenBLAS ライブラリは 32 ビットと 64 ビットの浮動小数点のみをサポートしていることです。
整数は計算できません。

現在、次の機能がサポートされています。

- scal
- axpy
- dot
- dotu
- dotc
- asum
- iamax
- iamin
- copy
- nrm2
- rotg
- rot
- swap
- gemv
- gemm
- symm
- syrk
- syr2k
- trmm
- trsm
- omatcopy

Usage on PHP
------------
Here is the sample code.

```php
use Interop\Polite\Math\Matrix\NDArray;
$bufferFactory = new Rindow\Math\Buffer\FFI\BufferFactory()
$openblasFactory = new Rindow\OpenBLAS\FFI\OpenBLASFactory()
$x = $bufferFactory->Buffer(3,NDArray::float32);
$blas = $openblasFactory->Blas();
$x[0] = 1.0;
$x[1] = 1.5;
$x[2] = 2.0;
$blas->scal(count($x),$alpha=2.0,$x,$offset=0,$incX=1);
for($i=0;$i<count($x);$i++) {
    echo $x[$i],',';
}
### 2,3,4,
```
