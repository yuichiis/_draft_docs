<?php
namespace Rindow\Math\Matrix;

use Interop\Polite\Math\Matrix\Buffer;
use Interop\Polite\Math\Matrix\NDArray;
use InvalidArgumentException;
use OutOfRangeException;
use LogicException;
use FFI;

class FFIBuffer implements Buffer
{
    protected static $typeString = [
        NDArray::bool    => 'unsigned char',
        NDArray::int8    => 'char',
        //NDArray::int16   => 'N/A',
        NDArray::int32   => 'short',
        NDArray::int64   => 'long',
        NDArray::uint8   => 'unsigned char',
        //NDArray::uint16  => 'N/A',
        NDArray::uint32  => 'unsigned short',
        NDArray::uint64  => 'unsigned long',
        //NDArray::float8  => 'N/A',
        //NDArray::float16 => 'N/A',
        NDArray::float32 => 'float',
        NDArray::float64 => 'double',
    ];
    protected static $valueSize = [
        NDArray::bool    => 1,
        NDArray::int8    => 1,
        //NDArray::int16   => 'N/A',
        NDArray::int32   => 4,
        NDArray::int64   => 8,
        NDArray::uint8   => 1,
        //NDArray::uint16  => 'N/A',
        NDArray::uint32  => 4,
        NDArray::uint64  => 8,
        //NDArray::float8  => 'N/A',
        //NDArray::float16 => 'N/A',
        NDArray::float32 => 4,
        NDArray::float64 => 8,
    ];

    protected int $size;
    protected int $dtype;
    protected object $data;

    public function __construct(int $size, int $dtype)
    {
        if(!isset(self::$typeString[$dtype])) {
            throw new InvalidArgumentException("Invalid data type");
        }
        $this->size = $size;
        $this->dtype = $dtype;
        $declaration = self::$typeString[$dtype];
        $this->data = FFI::new("{$declaration}[{$size}]");
    }

    public function dtype() : int
    {
        return $this->dtype;
    }

    public function value_size() : int
    {
        return $this->valueSize[$this->dtype];
    }

    public function addr(int $offset) : FFI\CData
    {
        return FFI::addr($this->data[$offset]);
    }

    public function count() : int
    {
        return $this->size;
    }

    public function offsetExists(mixed $offset) : bool
    {
        return ($offset>=0)&&($offset<$this->size);
    }

    public function offsetGet(mixed $offset): mixed
    {
        if($offset<0||$offset>=$this->size) {
            throw new OutOfRangeException("Out Of Range");
        }
        return $this->data[$offset];
    }

    public function offsetSet(mixed $offset, mixed $value): void
    {
        if($offset<0||$offset>=$this->size) {
            throw new OutOfRangeException("Out Of Range");
        }
        $this->data[$offset] = $value;
    }

    public function offsetUnset(mixed $offset): void
    {
        throw new LogicException("Illigal Operation");
    }

    public function dump() : string
    {
        $byte = self::$valueSize[$this->dtype] * $this->size;
        $buf = FFI::new("char[$byte]");
        FFI::memcpy($buf,$this->data,$byte);
        return FFI::string($buf,$byte);
    }

    public function load(string $string) : void
    {
        $byte = self::$valueSize[$this->dtype] * $this->size;
        $strlen = strlen($string);
        if($strlen!=$byte) {
            throw new InvalidArgumentException("Unmatch data size. buffer size is $byte. $strlen byte given.");
        }
        FFI::memcpy($this->data,$string,$byte);
    }
}
