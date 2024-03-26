コンセプト
--------
PHP の Array 型は行列演算には適していません。
共通のフォーマットが必要です。 高速な行列演算を実現するC言語プログラムと行列演算を扱うPHPプログラムの間でデータをやり取りします。

一般に、高速行列演算では、数値を格納する連続したメモリ領域が使用されます。 たとえば、CPU の SIMD 命令を使用したり、GPU に転送するデータ領域を使用したりする場合です。

BufferクラスはPHPにおいて連続したメモリ領域を配列として扱うことができます。

メモリ領域は、PHP から 1 次元配列としてアクセスできます。 データは単なる単一の数値列です。

これを N 次元配列としてどのように使用するかは、それを使用するプログラムによって決まります。 これにより、単純な仕様として定義できます。


PHPインターフェース
-------------
データ型とサイズを指定してバッファを作成します。
ArrayAccessインターフェースとCountインターフェースを持っているので、配列のように使うことができます。

ユニバーサルなBuffer には便宜上、次のインターフェイスがあります。
```php
use Interop\Polite\Math\Matrix\Buffer as BufferInterface;

class Buffer implements BufferInterface {
    public function __construct(int $size, int $dtype);
    public function dtype() : int;
    public function value_size() : int;
    public function count() : int;
    public function offsetExists(mixed $offset) : bool;
    public function offsetGet(mixed $offset): mixed;
    public function offsetSet(mixed $offset, mixed $value): void;
    public function offsetUnset(mixed $offset): void;
    public function dump() : string;
    public function load(string $string) : void;
}
```

Bufferインターフェースの定義は以下の通りです。
```php
namespace Interop\Polite\Math\Matrix;

use Countable;
use ArrayAccess;

interface BufferInterface extends Countable,ArrayAccess
{
}
```

C言語インターフェースを可能にするために、FFI経由のrindow-math-buffer-ffiではBufferを継承したLinearBufferインターフェースとaddrメソッドが追加されます。

LinearBufferはC言語などの連続したメモリー空間のバッファーであることを表しています。

```php
namespace Rindow\Math\Buffer\FFI;
use Interop\Polite\Math\Matrix\LinearBuffer;
use FFI;

class Buffer implements LinearBuffer {
    public function __construct(int $size, int $dtype);
    public function dtype() : int;
    public function value_size() : int;
    public function count() : int;
    public function addr(int $offset) : FFI\CData
    public function offsetExists(mixed $offset) : bool;
    public function offsetGet(mixed $offset): mixed;
    public function offsetSet(mixed $offset, mixed $value): void;
    public function offsetUnset(mixed $offset): void;
    public function dump() : string;
    public function load(string $string) : void;
}
```

インターフェースの標準化のためオブジェクト生成は必ずファクトリーを使ってください。

```php
namespace Rindow\Math\Buffer\FFI;

class BufferFactory
{
    public function isAvailable() : bool;
    public function Buffer(int $size, int $dtype) : Buffer;
}
```


Usage on PHP
------------
Here is the sample code.

```php
use Interop\Polite\Math\Matrix\NDArray;
$factory = new Rindow\Math\Buffer\FFI\BufferFactory()
$buffer = $factory->Buffer(10,NDArray::float32);
$buffer[0] = 1.0;
$buffer[1] = 1.5;
$x = $buffer[0]+$buffer[1];
$count = count($buffer);
```

You can quickly dump the data in the buffer.
```php
$x = $factory->Buffer(10,NDArray::float32);
$y = $factory->Buffer(10,NDArray::float32);
$x[0] = 1.0;
$x[1] = 1.5;
$data = $x->dump();
$y->load($data);
```

