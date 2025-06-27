## BLASとは
「BLAS」は Basic Linear Algebra Subprograms (基本線形代数サブプログラム) ライブラリです。
これは、基本的なベクトルおよび行列演算を実行するための標準的な構成要素を提供するルーチンです。
BLASは、効率的で移植性が高く、広く利用可能であるため、高品質な線形代数ソフトウェアの開発によく使用されます。

OpenBLASは、BLASを実装するC言語インターフェースを持つ代表的なライブラリです。
詳細については、[OpenBLASのウェブサイト](https://www.openblas.net/) を参照してください。

しかしBLASは比較的低レイヤーのプログラミングインターフェースであるため、アプリケーションから使うことが難しいため、高いレイヤーのアプリケーションに親切なライブラリのバックエンドとして利用されています。
Rindow Math Matrixも高速な演算を実現するために、LinearAlgebraクラスのバックエンドとして呼び出す形で利用しています。


## 実装方法
RindowのBlas クラスは、BLAS を PHPで利用できるようにします。
BLASインターフェースに準拠したバックエンドライブラリには以下のようなものがあります。

* 純粋なPHPだけで記述され動作環境を選ばずに利用できる`PhpBLAS`クラス
* OpenBLASを呼び出し高速な演算をする`rindow-openblas-ffi`パッケージ
* CLBlastを呼び出しGPUで高速な演算を行う`rindow-clblast-ffi`パッケージ

> `rindow-clblast-ffi` についての詳細は、[こちら](/mathematics/acceleration/mathematics/opencl.html) を参照してください。

これらはユーザーの環境によってLinearAlgebraクラスから呼び出すことができます。
また、BLASインターフェースに準拠したバックエンドライブラリを独自に作成してLinearAlgebraクラスで利用可能です。

BLASライブラリは非常に多数の関数を提供しますが、この `rindow-openblas-ffi` では、非常によく使用される関数のみを提供しています。

メモリ領域は `Buffer` オブジェクトを介して受け取られ、OpenBLASライブラリに渡されます。
OpenBLASのC言語インターフェースとの違いは、メモリ領域の開始アドレスを表すためにバッファオブジェクトとオフセットを使用する点です。これは、多次元配列を扱う際にメモリ領域のコピー数を最小限に抑えるためです。
`Buffer`の詳しい説明は[こちら](/mathematics/openblas/arraybuffer.md)を参照してください。

最も重要な注意点として、OpenBLASライブラリは32ビットおよび64ビットの浮動小数点数のみをサポートします。
整数は計算できません。

現在、以下の関数がサポートされています:

## 実装されているメソッド
BLASライブラリは多数の関数を提供しますが、この Rindow OpenBLAS FFI には未実装の関数もいくつかあります。バージョン2.0からは、複素数がサポートされるようになりました。

メモリ空間は `Buffer` オブジェクトを介して受け取られ、OpenBLASライブラリに渡されます。
C言語インターフェースとの違いは、メモリ空間の開始アドレスを表すためにバッファオブジェクトとオフセットを使用する点です。これは、多次元配列を扱う際にメモリコピーの数を最小限に抑えるためです。

最も重要な注意点として、BLAS対応のライブラリは32ビットおよび64ビットの浮動小数点数のみをサポートします。
整数の計算は他のライブラリを使用しなければなりません。

現在、以下の関数がサポートされています:
それぞれの関数の詳細な仕様は[netlib.org/blas](https://netlib.org/blas)を参照してください。

-   scal
-   axpy
-   dot
-   dotu
-   dotc
-   asum
-   iamax
-   iamin
-   copy
-   nrm2
-   rotg
-   rot
-   rotm
-   rotmg
-   swap
-   gemv
-   gemm
-   symm
-   syrk
-   syr2k
-   trmm
-   trsm
-   omatcopy


## 関数仕様の差異
オリジナルBLASとの関数仕様の差は２点あります。

* オフセット位置
* データタイプ

### オフセット位置
配列のアドレスの代わりにBufferインターフェースのオブジェクトとオフセット位置を関数に渡すところです。
なぜならば、GPUメモリーのように直接物理的なアドレスを指定出来ない場合があるからです。アロケートされたGPUメモリのハンドルとオフセット位置を渡す事で、メモリアドレスを渡すのと同じように動作出来ます。

**OpenBLASの場合***
```C
void cblas_sscal(
    OPENBLAS_CONST blasint N,
    OPENBLAS_CONST float alpha,
    float *X,
    OPENBLAS_CONST blasint incX
);
```
**Rindow-OpenBLAS-FFIの場合**
```php
public function scal(
    int $n,
    object|float $alpha,
    Buffer $x,      // Bufferオブジェクト
    int $offset,    // オフセット位置
    int $incX,
) : void;

```

### データタイプ
OpenBLASなどではデータタイプの違いを関数名で表現しています。例えば`cblas_sscal`や`cblas_dscal`などです。
しかしRindow-MathではデータタイプをBufferオブジェクトの中に含めています。データタイプによる関数名の違いは一部の複素数関数を除き同じ名前に集約されます。(複素数では処理方法が何種類かあるため名前を分ける必要があります。)


**OpenBLASの場合***
```C
/** 単精度浮動小数 **/
void cblas_sscal(
    OPENBLAS_CONST blasint N,
    OPENBLAS_CONST float alpha,
    float *X,
    OPENBLAS_CONST blasint incX
);
/** 倍精度浮動小数 **/
void cblas_dscal(
    OPENBLAS_CONST blasint N,
    OPENBLAS_CONST double alpha,
    double *X,
    OPENBLAS_CONST blasint incX
);
/** 単精度複素数 **/
void cblas_cscal(
    OPENBLAS_CONST blasint N,
    OPENBLAS_CONST void *alpha,
    void *X,
    OPENBLAS_CONST blasint incX
);
/** 倍精度複素数 **/
void cblas_zscal(
    OPENBLAS_CONST blasint N,
    OPENBLAS_CONST void *alpha,
    void *X,
    OPENBLAS_CONST blasint incX
);
```

**Rindow-OpenBLAS-FFIの場合**
```php
/** 単精度/倍精度の浮動小数と複素数共通 **/
public function scal(
    int $n,
    object|float $alpha,
    Buffer $x,      // Bufferオブジェクトにデータタイプ情報が含まれる。
    int $offset,
    int $incX,
) : void;

```


PHPでの使用法
------------
以下はサンプルコードです。

```php
use Interop\Polite\Math\Matrix\NDArray;
$bufferFactory = new Rindow\Math\Buffer\FFI\BufferFactory();
$openblasFactory = new Rindow\OpenBLAS\FFI\OpenBLASFactory();
$x = $bufferFactory->Buffer(3, NDArray::float32);
$blas = $openblasFactory->Blas();
$x[0] = 1.0;
$x[1] = 1.5;
$x[2] = 2.0;
$alpha = 2.0;
$offset = 0;
$incX = 1;
$blas->scal(count($x), $alpha, $x, $offset, $incX);
for($i=0; $i<count($x); $i++) {
    echo $x[$i], ',';
}
### 2,3,4,
```
