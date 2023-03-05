<?php
namespace Rindow\OpenBLAS\FFI;

use FFI;
use Interop\Polite\Math\Matrix\Buffer as BufferInterface;

class OpenBLASFactory
{
    protected FFI $ffi;

    public function __construct(
        string $headerFile=null
        )
    {
        $headerFile = $headerFile ?? __DIR__ . "/openblas_win.h";
        $ffi = FFI::load($headerFile);
        $this->ffi = $ffi;
    }

    public function Buffer(int $size, int $dtype) : Buffer
    {
        return new Buffer($size, $dtype);
    }

    public function Blas() : Blas
    {
        return new Blas($this->ffi);
    }

    public function Lapack() : Lapack
    {
        return new Lapack($this->ffi);
    }

    public function Math() : Math
    {
        return new Math($this->ffi);
    }

}
