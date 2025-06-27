## 概念

PHPの配列型（Array type）は、高速な行列演算には適していません。
高速な行列演算を実現するためには、数値を格納する連続したメモリ領域を利用するC言語プログラムと、それらのプログラムを扱うPHPプログラムとの間で、効率的にデータを交換できる共通のフォーマットが必要です。これは、例えばCPUのSIMD命令を使用する場合や、GPUにデータを転送する場合などに重要となります。

Bufferクラスは、このような連続したメモリ領域をPHP内で配列のように扱えるようにする、低レイヤーのサービスモジュールです。

PHPからは、このメモリ領域は一次元配列としてアクセスできます。内部的には、データは単なる数値が連続したシーケンスとして格納されています。

この一次元配列をどのようにN次元配列として解釈し、使用するかは、それを利用するプログラムの役割です。例えば、Rindow Math Matrixでは、NDArrayPhpクラスがBufferオブジェクトの一部を切り出し、NDArrayインターフェースを通じてN次元配列として扱います。
一方、Bufferインターフェース自体は、物理的なメモリ領域に対するインターフェースを単純な一次元配列として扱うことで、仕様を簡潔に保つことができます。

Bufferインターフェースは、主にC言語インターフェースを利用するための仕組みですが、純粋なPHP環境だけで使用する場合でも、共通のインターフェースで配列にアクセスできるように、内部でPHPの配列を使用してBufferインターフェースでアクセス可能にする実装も用意されています。これは、外部のC言語ライブラリが利用できないWebホスティングサービスなどで役立ちます。

また、GPUを利用する場合には、GPUのAPIに対応したBufferインターフェースが必要になります。標準のRindow-Mathでは、GPUのAPIとしてOpenCLを採用しています。

現在の環境に合わせて、以下の3つのBufferモジュールが提供されています。

  * **Math-Buffer**: `rindow-math-buffer-ffi` パッケージで提供。外部のC言語ライブラリとの連携に対応。
  * **PhpBuffer**: `rindow-math-matrix` パッケージに標準搭載。純粋なPHPのみで動作可能。
  * **OpenCL-Buffer**: `rindow-opencl-ffi` パッケージで提供。OpenCLに対応したGPUメモリ用Bufferインターフェース。

将来的には、他のC言語ライブラリに対応したBufferインターフェースを開発することで、様々な環境でRindow-Mathを利用できるようになる予定です。

`rindow-opencl-ffi` についての詳細は、[こちら](/mathematics/acceleration/mathematics/opencl.html) を参照してください。

## PHPインターフェース

Bufferオブジェクトは、データ型とサイズを指定して作成します。
ArrayAccessインターフェースとCountableインターフェースを実装しているため、PHPの配列と同様に扱うことができます。

汎用的なBufferインターフェースは、便宜上、以下のメソッドを持ちます。

```php
use Interop\Polite\Math\Matrix\Buffer as BufferInterface;

class Buffer implements BufferInterface {
    public function __construct(int $size, int $dtype);
    public function dtype() : int; // データ型を取得
    public function value_size() : int; // 1要素あたりのバイト数を取得
    public function count() : int; // 要素数を取得
    public function offsetExists(mixed $offset) : bool; // 指定したオフセットが存在するかどうかを確認
    public function offsetGet(mixed $offset): mixed; // 指定したオフセットの値を読み取る
    public function offsetSet(mixed $offset, mixed $value): void; // 指定したオフセットに値を書き込む
    public function offsetUnset(mixed $offset): void; // 指定したオフセットの値を未設定にする (通常はサポートされません)
    public function dump() : string; // バッファの内容をバイナリ文字列として取得
    public function load(string $string) : void; // バイナリ文字列からバッファの内容を復元
}
```

Bufferインターフェースの定義は以下の通りです。

```php
namespace Interop\Polite\Math\Matrix;

use Countable;
use ArrayAccess;

interface Buffer extends Countable,ArrayAccess
{
}
```

C言語インターフェースを有効にするための `rindow-math-buffer-ffi` パッケージでは、Bufferインターフェースを継承し、`addr` メソッドを持つ `LinearBuffer` インターフェースが追加されています。

LinearBufferインターフェースは、C言語における連続したメモリ空間を持つバッファを表現します。

```php
namespace Rindow\Math\Buffer\FFI;
use Interop\Polite\Math\Matrix\LinearBuffer;
use FFI;

class Buffer implements LinearBuffer {
    public function __construct(int $size, int $dtype);
    public function dtype() : int;
    public function value_size() : int;
    public function count() : int;
    public function addr(int $offset) : FFI\CData; // 指定したオフセットのメモリアドレスをCData型で取得
    public function offsetExists(mixed $offset) : bool;
    public function offsetGet(mixed $offset): mixed;
    public function offsetSet(mixed $offset, mixed $value): void;
    public function offsetUnset(mixed $offset): void;
    public function dump() : string;
    public function load(string $string) : void;
}
```

インターフェースを標準化するため、オブジェクトの生成には必ずファクトリクラスを使用してください。

```php
namespace Rindow\Math\Buffer\FFI;

class BufferFactory
{
    public function isAvailable() : bool; // FFI機能が利用可能かどうかを確認
    public function Buffer(int $size, int $dtype) : Buffer; // Bufferオブジェクトを生成
}
```

## PHPでの使用法

以下にBufferクラスの基本的な使用例を示します。

```php
use Interop\Polite\Math\Matrix\NDArray;
use Rindow\Math\Buffer\FFI\BufferFactory; // BufferFactoryのuseを追加

$factory = new BufferFactory();
// サイズ10、データ型float32のバッファを作成
$buffer = $factory->Buffer(10, NDArray::float32);
// 配列のようにアクセス
$buffer[0] = 1.0;
$buffer[1] = 1.5;
$x = $buffer[0] + $buffer[1];
// 要素数を取得
$count = count($buffer); // または $buffer->count()
```

バッファ内のデータをバイナリ形式でダンプし、別のバッファにロードする例です。

```php
use Interop\Polite\Math\Matrix\NDArray;
use Rindow\Math\Buffer\FFI\BufferFactory; // BufferFactoryのuseを追加

$factory = new BufferFactory();
$x = $factory->Buffer(10, NDArray::float32);
$y = $factory->Buffer(10, NDArray::float32);
$x[0] = 1.0;
$x[1] = 1.5;
// $xの内容をバイナリ文字列として取得
$data = $x->dump();
// $yに$xの内容をロード
$y->load($data);
```

C言語ライブラリにバッファーのアドレスを渡す例です。

```php
use Interop\Polite\Math\Matrix\NDArray;
use Rindow\Math\Buffer\FFI\BufferFactory; // BufferFactoryのuseを追加
use FFI; // FFIのuseを追加

$factory = new BufferFactory();
$ffi = FFI::cdef(/*fooの定義*/); // C言語の定義を記述 
$x = $factory->Buffer(10, NDArray::float32);
$y = $factory->Buffer(10, NDArray::float32);

$x[0] = 1.0;
$x[1] = 1.5;

switch($x->dtype()) {
    case NDArray::float32: {
        $ffi->foo_float($x->addr(0),$y->addr(0));
        break;
    }
    case NDArray::float64: {
        $ffi->foo_double($x->addr(0),$y->addr(0));
        break;
    }
    default: {
        throw new \RuntimeException("Unsupported data type.");
    }
}
```
