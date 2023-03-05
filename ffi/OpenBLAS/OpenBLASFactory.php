<?php
namespace Rindow\OpenBLAS\FFI;

use FFI;
use Interop\Polite\Math\Matrix\Buffer as BufferInterface;

class OpenBLASFactory
{
    private static ?FFI $ffi = null;

    public function __construct(
        string $headerFile=null
        )
    {
        if(self::$ffi!==null) {
            return;
        }
        $headerFile = $headerFile ?? __DIR__ . "/openblas_win.h";
        $ffi = FFI::load($headerFile);
        self::$ffi = $ffi;
    }

    public function Buffer(int $size, int $dtype) : Buffer
    {
        return new Buffer($size, $dtype);
    }

    public function Blas() : Blas
    {
        return new Blas(self::$ffi);
    }

    public function Lapack() : Lapack
    {
        return new Lapack(self::$ffi);
    }

    public function Math() : Math
    {
        return new Math(self::$ffi);
    }

}
