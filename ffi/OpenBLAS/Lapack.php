<?php
namespace Rindow\OpenBLAS\FFI;

use Interop\Polite\Math\Matrix\NDArray;
use InvalidArgumentException;
use OutOfRangeException;
use LogicException;

use FFI;

use Interop\Polite\Math\Matrix\Buffer as BufferInterface;

class Lapack
{
    use Utils;

    const LAPACK_WORK_MEMORY_ERROR      = -1010;
    const LAPACK_TRANSPOSE_MEMORY_ERROR = -1010;

    protected $ffi;

    public function __construct(FFI $ffi)
    {
        $this->ffi = $ffi;
    }

    public function gesvd(
        int $matrix_layout,
        int $jobu,
        int $jobvt,
        int $m,
        int $n,
        Buffer $A,  int $offsetA,  int $ldA,
        Buffer $S,  int $offsetS,
        Buffer $U,  int $offsetU,  int $ldU,
        Buffer $VT, int $offsetVT, int $ldVT,
        Buffer $SuperB,  int $offsetSuperB
    ) : void
    {
        $ffi = $this->ffi;
        $this->assert_shape_parameter("m", $m);
        $this->assert_shape_parameter("n", $n);

        if( $offsetS < 0 ) {
            throw new InvalidArgumentException("offsetS must be greater than zero or equal");
        }
        if( $offsetU < 0 ) {
            throw new InvalidArgumentException("offsetU must be greater than zero or equal", 0);
        }
        if( $ldU <= 0 ) {
            throw new InvalidArgumentException("ldU must be greater than zero", 0);
        }
        if( $offsetVT < 0 ) {
            throw new InvalidArgumentException("offsetVT must be greater than zero or equal", 0);
        }
        if( $ldVT <= 0 ) {
            throw new InvalidArgumentException("ldVT must be greater than zero", 0);
        }
        if( $offsetSuperB < 0 ) {
            throw new InvalidArgumentException("offsetVT must be greater than zero or equal", 0);
        }
        // Check Buffer A
        $this->assert_matrix_buffer_spec("BufferA", $A,$m,$n,$offsetA,$ldA);
    
        // Check Buffer S
        if( $offsetS+min($m,$n) > count($S)) {
            throw new InvalidArgumentException("BufferS size is too small", 0);
        }
    
        // Check Buffer U
        if( $offsetU+$m*$ldU > count($U)) {
            throw new InvalidArgumentException("BufferU size is too small", 0);
        }
    
        // Check Buffer VT
        if( $offsetVT+$ldVT*$n > count($VT)) {
            throw new InvalidArgumentException("BufferVT size is too small", 0);
        }
    
        // Check Buffer SuperB
        if( $offsetSuperB+min($m,$n)-1 > count($SuperB)) {
            throw new InvalidArgumentException("bufferSuperB size is too small", 0);
        }
    
        $dtype = $A->dtype();
        // Check Buffer A and B and C
        if($dtype!=$S->dtype() ||
            $dtype!=$U->dtype() ||
            $dtype!=$VT->dtype() ||
            $dtype!=$SuperB->dtype()
        ) {
            throw new InvalidArgumentException("Unmatch data type", 0);
        }
    
        $jobu_p = FFI::new('char');
        $jobu_p->cdata = chr($jobu);
        $jobvt_p = FFI::new('char');
        $jobvt_p->cdata = chr($jobvt);
        switch ($dtype) {
            case NDArray::float32:
                $info = $ffi->LAPACKE_sgesvd(
                    $matrix_layout,
                    $jobu_p,
                    $jobvt_p,
                    $m,$n,
                    $A->addr($offsetA), $ldA,
                    $S->addr($offsetS),
                    $U->addr($offsetU), $ldU,
                    $VT->addr($offsetVT), $ldVT,
                    $SuperB->addr($offsetSuperB)
                );
                break;
            case NDArray::float64:
                $info = $ffi->LAPACKE_dgesvd(
                    $matrix_layout,
                    $jobu_p,
                    $jobvt_p,
                    $m,$n,
                    $A->addr($offsetA), $ldA,
                    $S->addr($offsetS),
                    $U->addr($offsetU), $ldU,
                    $VT->addr($offsetVT), $ldVT,
                    $SuperB->addr($offsetSuperB)
                );
                break;
            default:
                throw new RuntimeException("Unsupported data type.", 0);
        }
        if( $info == self::LAPACK_WORK_MEMORY_ERROR ) {
            throw new RuntimeException( "Not enough memory to allocate work array.", $info);
        } else if( $info == self::LAPACK_TRANSPOSE_MEMORY_ERROR ) {
            throw new RuntimeException( "Not enough memory to transpose matrix.", $info);
        } else if( $info < 0 ) {
            throw new RuntimeException( "Wrong parameter. error=$info", $info);
        }
    }
}