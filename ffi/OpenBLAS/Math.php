<?php
namespace Rindow\OpenBLAS\FFI;

use Interop\Polite\Math\Matrix\NDArray;
use InvalidArgumentException;
use OutOfRangeException;
use LogicException;

use FFI;

use Interop\Polite\Math\Matrix\Buffer as BufferInterface;

class Math
{
    use Utils;

    protected $ffi;

    public function __construct(FFI $ffi)
    {
        $this->ffi = $ffi;
    }

}
