<?php
namespace Rindow\Math\Matrix;

use Interop\Polite\Math\Matrix\Buffer;
use Interop\Polite\Math\Matrix\NDArray;
use InvalidArgumentException;
use OutOfRangeException;
use LogicException;
use FFI;

class FFIOpenBlas
{
    // OpenBLAS is compiled for sequential use
    const OPENBLAS_SEQUENTIAL = 0;
    // OpenBLAS is compiled using normal threading model
    const OPENBLAS_THREAD = 1;
    // OpenBLAS is compiled using OpenMP threading model
    const OPENBLAS_OPENMP = 2;

    protected object $blas;

    public function __construct()
    {
        $this->blas = FFI::load(__DIR__ . "/blas_win.h");
    }

    public function getNumThreads() : int
    {
        return $this->blas->openblas_get_num_threads();
    }

    public function getNumProcs() : int
    {
        return $this->blas->openblas_get_num_procs();
    }

    public function getConfig() : string
    {
        $string = $this->blas->openblas_get_config();
        return FFI::string($string);
    }

    public function getCorename() : string
    {
        $string = $this->blas->openblas_get_corename();
        return FFI::string($string);
    }

    public function getParallel() : int
    {
        return $this->blas->openblas_get_parallel();
    }


    protected function assert_shape_parameter(
        string $name, int $n) : void
    {
        if($n<1) {
            throw new InvalidArgumentException("Argument $name must be greater than 0.");
        }
    }
    
    protected function assert_vector_buffer_spec(
        string $name, FFIBuffer $buffer, int $n, int $offset, int $inc) : void
    {
        if($offset<0) {
            throw new InvalidArgumentException("Argument offset$name must be greater than equals 0.");
        }
        if($inc<1) {
            throw new InvalidArgumentException("Argument inc$name must be greater than 0.");
        }
        if($offset+($n-1)*$inc >= count($buffer)) {
            throw new InvalidArgumentException("Vector specification too large for buffer$name.");
        }
    }

    /**
     *  X := alpha * X
     */
    public function scal(
        int $n,
        float $alpha,
        FFIBuffer $X, int $offsetX, int $incX) : void
    {
        $this->assert_shape_parameter("n", $n);
        $this->assert_vector_buffer_spec("X", $X, $n, $offsetX, $incX);
        switch($X->dtype()) {
            case NDArray::float32:{
                $this->blas->cblas_sscal($n,$alpha,$X->addr($offsetX),$incX);
                break;
            }
            case NDArray::float64:{
                $this->blas->cblas_dscal($n,$alpha,$X->addr($offsetX),$incX);
                break;
            }
            default: {
                throw new InvalidArgumentException('Unsuppored data type');
            }
        }
    }

    /**
     *  Y := alpha * X + Y
     */
    public function axpy(
        int $n,
        float $alpha,
        FFIBuffer $X, int $offsetX, int $incX,
        FFIBuffer $Y, int $offsetY, int $incY ) : void
    {
        // Check Buffer X
        $this->assert_vector_buffer_spec("X", $X, $n, $offsetX, $incX);
        $this->assert_vector_buffer_spec("Y", $Y, $n, $offsetY, $incY);

        // Check Buffer X and Y
        if($X->dtype()!=$Y->dtype()) {
            throw new InvalidArgumentException("Unmatch data type for X and Y");
        }

        switch($X->dtype()) {
            case NDArray::float32:{
                $this->blas->cblas_saxpy($n,$alpha,$X->addr($offsetX),$incX,$Y->addr($offsetY),$incY);
                break;
            }
            case NDArray::float64:{
                $this->blas->cblas_daxpy($n,$alpha,$X->addr($offsetX),$incX,$Y->addr($offsetY),$incY);
                break;
            }
            default: {
                throw new InvalidArgumentException('Unsuppored data type');
            }
        }
    }

    public function dot(
        int $n,
        Buffer $X, int $offsetX, int $incX,
        Buffer $Y, int $offsetY, int $incY ) : float
    {
        if($this->useBlas($X)) {
            return $this->blas->dot($n,$X,$offsetX,$incX,$Y,$offsetY,$incY);
        }

        if($offsetX+($n-1)*$incX>=count($X))
            throw new RuntimeException('Vector X specification too large for buffer.');
        if($offsetY+($n-1)*$incY>=count($Y))
            throw new RuntimeException('Vector Y specification too large for buffer.');
        $idxX = $offsetX;
        $idxY = $offsetY;
        $acc = 0.0;
        for ($i=0; $i<$n; $i++,$idxX+=$incX,$idxY+=$incY) {
            $acc += $X[$idxX] * $Y[$idxY];
        }
        return $acc;
    }

    public function asum(
        int $n,
        Buffer $X, int $offsetX, int $incX ) : float
    {
        if($this->useBlas($X)) {
            return $this->blas->asum($n,$X,$offsetX,$incX);
        }

        if($offsetX+($n-1)*$incX>=count($X))
            throw new RuntimeException('Vector X specification too large for buffer.');
        $idxX = $offsetX;
        $acc = 0.0;
        for ($i=0; $i<$n; $i++,$idxX+=$incX) {
            $acc += abs($X[$idxX]);
        }
        return $acc;
    }

    public function iamax(
        int $n,
        Buffer $X, int $offsetX, int $incX ) : int
    {
        if($this->useBlas($X)) {
            return $this->blas->iamax($n,$X,$offsetX,$incX);
        }

        if($offsetX+($n-1)*$incX>=count($X))
            throw new RuntimeException('Vector X specification too large for buffer.');
        $idxX = $offsetX+$incX;
        $acc = abs($X[$offsetX]);
        $idx = 0;
        for($i=1; $i<$n; $i++,$idxX+=$incX) {
            if($acc < abs($X[$idxX])) {
                $acc = abs($X[$idxX]);
                $idx = $i;
            }
        }
        return $idx;
    }

    public function iamin(
        int $n,
        Buffer $X, int $offsetX, int $incX ) : int
    {
        if($this->blas!=null && method_exists($this->blas,'iamin')&&$this->useBlas($X)) {
            return $this->blas->iamin($n,$X,$offsetX,$incX);
        }

        if($offsetX+($n-1)*$incX>=count($X))
            throw new RuntimeException('Vector X specification too large for buffer.');
        $idxX = $offsetX+$incX;
        $acc = abs($X[$offsetX]);
        $idx = 0;
        for($i=1; $i<$n; $i++,$idxX+=$incX) {
            if($acc > abs($X[$idxX])) {
                $acc = abs($X[$idxX]);
                $idx = $i;
            }
        }
        return $idx;
    }

    public function copy(
        int $n,
        Buffer $X, int $offsetX, int $incX,
        Buffer $Y, int $offsetY, int $incY ) : void
    {
        if($this->useBlas($X)) {
            $this->blas->copy($n,$X,$offsetX,$incX,$Y,$offsetY,$incY);
            return;
        }

        if($offsetX+($n-1)*$incX>=count($X))
            throw new RuntimeException('Vector X specification too large for buffer.');
        if($offsetY+($n-1)*$incY>=count($Y))
            throw new RuntimeException('Vector Y specification too large for buffer.');

        $idxX = $offsetX;
        $idxY = $offsetY;
        for($i=0; $i<$n; $i++,$idxX+=$incX,$idxY+=$incY) {
            $Y[$idxY] = $X[$idxX];
        }
    }

    public function nrm2(
        int $n,
        Buffer $X, int $offsetX, int $incX
        ) : float
    {
        if($this->useBlas($X)) {
            return $this->blas->nrm2($n,$X,$offsetX,$incX);
        }
        if($offsetX+($n-1)*$incX>=count($X))
            throw new RuntimeException('Vector X specification too large for buffer.');
        $idxX = $offsetX;
        // Y := sqrt(sum(Xn ** 2))
        $sum = 0.0;
        for ($i=0; $i<$n; $i++,$idxX+=$incX) {
            $sum += $X[$idxX] ** 2;
        }
        $Y = sqrt($sum);
        return $Y;
    }

    public function rotg(
        Buffer $A, int $offsetA,
        Buffer $B, int $offsetB,
        Buffer $C, int $offsetC,
        Buffer $S, int $offsetS
        ) : void
    {
        if($this->useBlas($A)) {
            $this->blas->rotg($A,$offsetA,$B,$offsetB,$C,$offsetC,$S,$offsetS);
            return;
        }
        $a = $A[$offsetA];
        $b = $B[$offsetB];
        // r
        if(abs($a)>abs($b)) {
            $r = $this->sign(sqrt($a**2 + $b**2),$a);
        } else {
            $r = $this->sign(sqrt($a**2 + $b**2),$b);
        }
        // c
        if($r!=0) {
            $c = $a/$r;
        } else {
            $c = 1;
        }
        // s
        if($r!=0) {
            $s = $a/$r;
        } else {
            $s = 0;
        }
        // z
        if(abs($a)>abs($b)) {
            $z = $s;
        } else {
            if($r!=0) {
                if($c!=0) {
                    $z = 1/$c;
                } else {
                    $z = 1;
                }
            } else {
                $z = 0;
            }
        }
        $A[$offsetA] = $r;
        $B[$offsetB] = $z;
        $C[$offsetC] = $c;
        $S[$offsetS] = $s;
    }

    protected function sign(float $x,float $y) : float
    {
        if($y<0) {
            $x = -$x;
        }
        return $x;
    }

    public function rot(
        int $n,
        Buffer $X, int $offsetX, int $incX,
        Buffer $Y, int $offsetY, int $incY,
        Buffer $C, int $offsetC,
        Buffer $S, int $offsetS
        ) : void
    {
        if($this->useBlas($X)) {
            $this->blas->rot($n,$X,$offsetX,$incX,$Y,$offsetY,$incY,$C,$offsetC,$S,$offsetS);
            return;
        }
        $cc = $C[$offsetC];
        $ss = $S[$offsetS];
        $idX = $offsetX;
        $idY = $offsetY;
        for($i=0;$i<$n;$i++,$idX+=$incX,$idY+=$incY) {
            $xx = $X[$idX];
            $yy = $Y[$idY];
            $X[$idX] =  $cc * $xx + $ss * $yy;
            $Y[$idY] = -$ss * $xx + $cc * $yy;
        }
    }

    public function swap(
        int $n,
        Buffer $X, int $offsetX, int $incX,
        Buffer $Y, int $offsetY, int $incY ) : void
    {
        if($this->useBlas($X)) {
            $this->blas->swap($n,$X,$offsetX,$incX,$Y,$offsetY,$incY);
            return;
        }

        if($offsetX+($n-1)*$incX>=count($X))
            throw new RuntimeException('Vector X specification too large for buffer.');
        if($offsetY+($n-1)*$incY>=count($Y))
            throw new RuntimeException('Vector Y specification too large for buffer.');

        $idxX = $offsetX;
        $idxY = $offsetY;
        for($i=0; $i<$n; $i++,$idxX+=$incX,$idxY+=$incY) {
            $tmp = $Y[$idxY];
            $Y[$idxY] = $X[$idxX];
            $X[$idxX] = $tmp;
        }
    }

    public function gemv(
        int $order,
        int $trans,
        int $m,
        int $n,
        float $alpha,
        Buffer $A, int $offsetA, int $ldA,
        Buffer $X, int $offsetX, int $incX,
        float $beta,
        Buffer $Y, int $offsetY, int $incY ) : void
    {
        if($this->useBlas($X)) {
            $this->blas->gemv($order,$trans,$m,$n,$alpha,
                $A,$offsetA,$ldA,$X,$offsetX,$incX,$beta,$Y,$offsetY,$incY);
            return;
        }

        if($order==BLAS::ColMajor) {
            [$m,$n] = [$n,$m];
        } elseif($order!=BLAS::RowMajor) {
            throw new InvalidArgumentException('Invalid Order type');
        }
        $rows = ($trans==BLAS::NoTrans) ? $m : $n;
        $cols = ($trans==BLAS::NoTrans) ? $n : $m;

        if($offsetA+($m-1)*$ldA+($n-1)*$incX>=count($A))
            throw new RuntimeException('Matrix specification too large for bufferA.');
        if($offsetX+($cols-1)*$incX>=count($X))
            throw new RuntimeException('Vector specification too large for bufferX.');
        if($offsetY+($rows-1)*$incY>=count($Y))
            throw new RuntimeException('Vector specification too large for bufferY.');

        $ldA_i = ($trans==BLAS::NoTrans) ? $ldA : 1;
        $ldA_j = ($trans==BLAS::NoTrans) ? 1 : $ldA;

        $idA_i = $offsetA;
        $idY = $offsetY;
        for ($i=0; $i<$rows; $i++,$idA_i+=$ldA_i,$idY+=$incY) {
            $idA = $idA_i;
            $idX = $offsetX;
            $acc = 0.0;
            for ($j=0; $j<$cols; $j++,$idA+=$ldA_j,$idX+=$incX) {
                 $acc += $alpha * $A[$idA] * $X[$idX];
            }
            if($beta==0.0) {
                $Y[$idY] = $acc;
            } else {
                $Y[$idY] = $acc + $beta * $Y[$idY];
            }
        }
    }

    public function gemm(
        int $order,
        int $transA,
        int $transB,
        int $m,
        int $n,
        int $k,
        float $alpha,
        Buffer $A, int $offsetA, int $ldA,
        Buffer $B, int $offsetB, int $ldB,
        float $beta,
        Buffer $C, int $offsetC, int $ldC ) : void
    {
        if($this->useBlas($A)) {
            $this->blas->gemm($order,$transA,$transB,$m,$n,$k,$alpha,
                $A,$offsetA,$ldA,$B,$offsetB,$ldB,$beta,$C,$offsetC,$ldC);
            return;
        }

        if($order==BLAS::ColMajor) {
            [$m,$n] = [$n,$m];
        } elseif($order!=BLAS::RowMajor) {
            throw new InvalidArgumentException('Invalid Order type');
        }
        $rowsA = ($transA==BLAS::NoTrans) ? $m : $k;
        $colsA = ($transA==BLAS::NoTrans) ? $k : $m;
        $rowsB = ($transB==BLAS::NoTrans) ? $k : $n;
        $colsB = ($transB==BLAS::NoTrans) ? $n : $k;
        if($offsetA+($rowsA-1)*$ldA+($colsA-1)>=count($A))
            throw new RuntimeException('Matrix specification too large for bufferA.');
        if($offsetB+($rowsB-1)*$ldB+($colsB-1)>=count($B))
            throw new RuntimeException('Matrix specification too large for bufferB.');
        if($offsetC+($m-1)*$ldC+($n-1)>=count($C))
            throw new RuntimeException('Matrix specification too large for bufferC.');

        $ldA_m = ($transA==BLAS::NoTrans) ? $ldA : 1;
        $ldA_k = ($transA==BLAS::NoTrans) ? 1 : $ldA;
        $ldB_k = ($transB==BLAS::NoTrans) ? $ldB : 1;
        $ldB_n = ($transB==BLAS::NoTrans) ? 1 : $ldB;

        $idA_m = $offsetA;
        $idC_m = $offsetC;
        for ($im=0; $im<$m; $im++,$idA_m+=$ldA_m,$idC_m+=$ldC) {
            $idB_n = $offsetB;
            $idC = $idC_m;
            for ($in=0; $in<$n; $in++,$idB_n+=$ldB_n,$idC++) {
                $idA = $idA_m;
                $idB = $idB_n;
                $acc = 0.0;
                for ($ik=0; $ik<$k; $ik++,$idA+=$ldA_k,$idB+=$ldB_k) {
                    $acc += $A[$idA] * $B[$idB];
                }
                if($beta==0.0) {
                    $C[$idC] = $alpha * $acc;
                } else {
                    $C[$idC] = $alpha * $acc + $beta * $C[$idC];
                }
            }
        }
    }

    public function symm(
        int $order,
        int $side,
        int $uplo,
        int $m,
        int $n,
        float $alpha,
        Buffer $A, int $offsetA, int $ldA,
        Buffer $B, int $offsetB, int $ldB,
        float $beta,
        Buffer $C, int $offsetC, int $ldC ) : void
    {
        if($this->useBlas($A)) {
            $this->blas->symm($order,$side,$uplo,$m,$n,$alpha,
                $A,$offsetA,$ldA,$B,$offsetB,$ldB,$beta,$C,$offsetC,$ldC);
            return;
        }

        if($order==BLAS::ColMajor) {
            [$m,$n] = [$n,$m];
        } elseif($order!=BLAS::RowMajor) {
            throw new InvalidArgumentException('Invalid Order type');
        }
        $sizeA = ($side==BLAS::Left) ? $m : $n;
        if($offsetA+($sizeA-1)*$ldA+($sizeA-1)>=count($A))
            throw new RuntimeException('Matrix specification too large for bufferA.');
        if($offsetB+($m-1)*$ldB+($n-1)>=count($B))
            throw new RuntimeException('Matrix specification too large for bufferB.');
        if($offsetC+($m-1)*$ldC+($n-1)>=count($C))
            throw new RuntimeException('Matrix specification too large for bufferC.');

        $ldA_m = ($uplo==BLAS::Upper) ? $ldA : 1;
        $ldA_k = ($uplo==BLAS::Upper) ? 1 : $ldA;
        $ldB_k = ($side==BLAS::Left) ? $ldB : 1;
        $ldB_n = ($side==BLAS::Left) ? 1 : $ldB;
        $ldC_m = ($side==BLAS::Left) ? $ldC : 1;
        $ldC_n = ($side==BLAS::Left) ? 1 : $ldC;
        if($side==BLAS::Right) {
            [$n,$m] = [$m,$n];
        }

        $idA_m = $offsetA;
        $idC_m = $offsetC;
        for ($im=0; $im<$m; $im++,$idC_m+=$ldC_m) {
            $idB_n = $offsetB;
            $idC = $idC_m;
            for ($in=0; $in<$n; $in++,$idB_n+=$ldB_n,$idC+=$ldC_n) {
                $idB = $idB_n;
                $acc = 0.0;
                for ($ik=0; $ik<$sizeA; $ik++,$idB+=$ldB_k) {
                    if($ik<$im) {
                        $idA = $offsetA+$ik*$ldA_m+$im*$ldA_k;
                    } else {
                        $idA = $offsetA+$im*$ldA_m+$ik*$ldA_k;
                    }
                    $acc += $A[$idA] * $B[$idB];
                }
                if($beta==0.0) {
                    $C[$idC] = $alpha * $acc;
                } else {
                    $C[$idC] = $alpha * $acc + $beta * $C[$idC];
                }
            }
        }
    }

    public function syrk(
        int $order,
        int $uplo,
        int $trans,
        int $n,
        int $k,
        float $alpha,
        Buffer $A, int $offsetA, int $ldA,
        float $beta,
        Buffer $C, int $offsetC, int $ldC ) : void
    {
        if($this->useBlas($A)) {
            $this->blas->syrk($order,$uplo,$trans,$n,$k,$alpha,
                $A,$offsetA,$ldA,$beta,$C,$offsetC,$ldC);
            return;
        }
        if($order==BLAS::ColMajor) {
            [$n,$k] = [$k,$n];
        } elseif($order!=BLAS::RowMajor) {
            throw new InvalidArgumentException('Invalid Order type');
        }
        if($n<1)
            throw new RuntimeException('Argument n must be greater than 0.');
        if($k<1)
            throw new RuntimeException('Argument k must be greater than 0.');
        $rows = ($trans==BLAS::NoTrans) ? $n : $k;
        $cols = ($trans==BLAS::NoTrans) ? $k : $n;
        if($offsetA+($rows-1)*$ldA+($cols-1)>=count($A))
            throw new RuntimeException('Matrix specification too large for bufferA.');
        if($offsetC+($n-1)*$ldC+($n-1)>=count($C))
            throw new RuntimeException('Matrix specification too large for bufferC.');

        $ldA_m  = ($trans==BLAS::NoTrans) ? $ldA : 1;
        $ldA_k  = ($trans==BLAS::NoTrans) ? 1 : $ldA;
        $ldAT_k = ($trans!=BLAS::NoTrans) ? $ldA : 1;
        $ldAT_n = ($trans!=BLAS::NoTrans) ? 1 : $ldA;

        $idA_m = $offsetA;
        $idC_m = $offsetC;
        for ($im=0; $im<$n; $im++,$idA_m+=$ldA_m,$idC_m+=$ldC) {
            $idAT_n = $offsetA;
            $idC = $idC_m;
            if($uplo==Blas::Upper) {
                $start_n = $im;
                $end_n = $n;
            } else {
                $start_n = 0;
                $end_n = $im+1;
            }
            for ($in=$start_n; $in<$end_n; $in++,$idAT_n+=$ldAT_n,$idC++) {
                $acc = 0.0;
                for ($ik=0; $ik<$k; $ik++) {
                    $idA  = $offsetA+$im*$ldA_m+$ik*$ldA_k;
                    $idAT = $offsetA+$ik*$ldAT_k+$in*$ldAT_n;
                    $acc += $A[$idA] * $A[$idAT];
                }
                $idC = $im*$ldC+$in;
                if($beta==0.0) {
                    $C[$idC] = $alpha * $acc;
                } else {
                    $C[$idC] = $alpha * $acc + $beta * $C[$idC];
                }
            }
        }
    }

    public function syr2k(
        int $order,
        int $uplo,
        int $trans,
        int $n,
        int $k,
        float $alpha,
        Buffer $A, int $offsetA, int $ldA,
        Buffer $B, int $offsetB, int $ldB,
        float $beta,
        Buffer $C, int $offsetC, int $ldC ) : void
    {
        if($this->useBlas($A)) {
            $this->blas->syr2k($order,$uplo,$trans,$n,$k,$alpha,
                $A,$offsetA,$ldA,$B,$offsetB,$ldB,$beta,$C,$offsetC,$ldC);
            return;
        }
        if($order==BLAS::ColMajor) {
            [$n,$k] = [$k,$n];
        } elseif($order!=BLAS::RowMajor) {
            throw new InvalidArgumentException('Invalid Order type');
        }
        $rows = ($trans==BLAS::NoTrans) ? $n : $k;
        $cols = ($trans==BLAS::NoTrans) ? $k : $n;
        if($offsetA+($rows-1)*$ldA+($cols-1)>=count($A))
            throw new RuntimeException('Matrix specification too large for bufferA.');
        if($offsetB+($rows-1)*$ldB+($cols-1)>=count($B))
            throw new RuntimeException('Matrix specification too large for bufferB.');
        if($offsetC+($n-1)*$ldC+($n-1)>=count($C))
            throw new RuntimeException('Matrix specification too large for bufferC.');

        $ldA_m  = ($trans==BLAS::NoTrans) ? $ldA : 1;
        $ldA_k  = ($trans==BLAS::NoTrans) ? 1 : $ldA;
        $ldAT_k = ($trans!=BLAS::NoTrans) ? $ldA : 1;
        $ldAT_n = ($trans!=BLAS::NoTrans) ? 1 : $ldA;
        $ldB_m  = ($trans==BLAS::NoTrans) ? $ldB : 1;
        $ldB_k  = ($trans==BLAS::NoTrans) ? 1 : $ldB;
        $ldBT_k = ($trans!=BLAS::NoTrans) ? $ldB : 1;
        $ldBT_n = ($trans!=BLAS::NoTrans) ? 1 : $ldB;

        $idA_m = $offsetA;
        $idC_m = $offsetC;
        for ($im=0; $im<$n; $im++,$idA_m+=$ldA_m,$idC_m+=$ldC) {
            $idAT_n = $offsetA;
            $idC = $idC_m;
            if($uplo==Blas::Upper) {
                $start_n = $im;
                $end_n = $n;
            } else {
                $start_n = 0;
                $end_n = $im+1;
            }
            for ($in=$start_n; $in<$end_n; $in++,$idAT_n+=$ldAT_n,$idC++) {
                $acc = 0.0;
                for ($ik=0; $ik<$k; $ik++) {
                    $idA  = $offsetA+$im*$ldA_m+ $ik*$ldA_k;
                    $idB  = $offsetB+$im*$ldB_m+ $ik*$ldB_k;
                    $idAT = $offsetA+$ik*$ldAT_k+$in*$ldAT_n;
                    $idBT = $offsetB+$ik*$ldBT_k+$in*$ldBT_n;
                    $acc += $A[$idA]  * $B[$idBT];
                    $acc += $A[$idAT] * $B[$idB];
                }
                $idC = $im*$ldC+$in;
                if($beta==0.0) {
                    $C[$idC] = $alpha * $acc;
                } else {
                    $C[$idC] = $alpha * $acc + $beta * $C[$idC];
                }
            }
        }
    }

    public function trmm(
        int $order,
        int $side,
        int $uplo,
        int $trans,
        int $diag,
        int $m,
        int $n,
        float $alpha,
        Buffer $A, int $offsetA, int $ldA,
        Buffer $B, int $offsetB, int $ldB) : void
    {
        if($this->useBlas($A)) {
            $this->blas->trmm($order,$side,$uplo,$trans,$diag,$m,$n,$alpha,
                $A,$offsetA,$ldA,$B,$offsetB,$ldB);
            return;
        }
        throw new RuntimeException("Unsupported function yet without rindow_openblas");
    }

    public function trsm(
        int $order,
        int $side,
        int $uplo,
        int $trans,
        int $diag,
        int $m,
        int $n,
        float $alpha,
        Buffer $A, int $offsetA, int $ldA,
        Buffer $B, int $offsetB, int $ldB) : void
    {
        if($this->useBlas($A)) {
            $this->blas->trsm($order,$side,$uplo,$trans,$diag,$m,$n,$alpha,
                $A,$offsetA,$ldA,$B,$offsetB,$ldB);
            return;
        }
        throw new RuntimeException("Unsupported function yet without rindow_openblas");
    }
}
