<?php
namespace Rindow\CLBlast2;

use Interop\Polite\Math\Matrix\Buffer;
use Interop\Polite\Math\Matrix\NDArray;
use InvalidArgumentException;
use OutOfRangeException;
use LogicException;
use FFI;
use Rindow\OpenCL2\Buffer as BufferInterface;
use Rindow\OpenCL2\CommandQueue;
use Rindow\OpenCL2\EventList;


class Blas
{
    const CLBlastSuccess = 0;
    protected object $blas;

    public function __construct()
    {
        $this->blas = FFI::load(__DIR__ . "/clblast_win.h");
    }

    /**
     *  X := alpha * X
     */
    public function scal(
        int $n,
        float $alpha,
        BufferInterface $X, int $offsetX, int $incX,
        CommandQueue $queue,// Rindow\OpenCL\CommandQueue
        EventList $event=null,   // Rindow\OpenCL\EventList
        ) : void
    {
        $ffi = $this->blas;
        $buffer_p = $ffi->cast("cl_mem",$X->_getId());
        $queue_p = $ffi->cast("cl_command_queue*",FFI::addr($queue->_getId()));
        $event_p = null;
        if($event) {
            $event_obj = $event->_ffi()->new("cl_event[1]");
            $event_p = $ffi->cast("cl_event[1]",$event_obj);
        }
        switch($X->dtype()) {
            case NDArray::float32:{
                $status = $this->blas->CLBlastSscal(
                    $n,$alpha,
                    $buffer_p,$offsetX,$incX,
                    $queue_p,$event_p);
                break;
            }
            case NDArray::float64:{
                $status = $this->blas->CLBlastDscal(
                    $n,$alpha,
                    $buffer_p,$offsetX,$incX,
                    $queue_p,$event_p);
                break;
            }
            default: {
                throw new InvalidArgumentException('Unsuppored data type');
            }
        }
        if($status!=self::CLBlastSuccess) {
            throw new RuntimeException("CLBlast?scal error=$status", $status);
        }
    
        if($event) {
            $event->_move($event_obj);
        }
    }

    /**
     *  Y := alpha * X + Y
     */
    public function axpy(
        int $n,
        float $alpha,
        BufferInterface $X, int $offsetX, int $incX,
        BufferInterface $Y, int $offsetY, int $incY,
        CommandQueue $queue,// Rindow\OpenCL\CommandQueue
        EventList $event=null,   // Rindow\OpenCL\EventList
        ) : void
    {
        $ffi = $this->blas;
        // Check Buffer X and Y
        if($X->dtype()!=$Y->dtype()) {
            throw new InvalidArgumentException("Unmatch data type for X and Y");
        }
        $bufferX_p = $ffi->cast("cl_mem",$X->_getId());
        $bufferY_p = $ffi->cast("cl_mem",$Y->_getId());
        $queue_p = $ffi->cast("cl_command_queue*",FFI::addr($queue->_getId()));
        $event_p = null;
        if($event) {
            $event_obj = $event->_ffi()->new("cl_event[1]");
            $event_p = $ffi->cast("cl_event[1]",$event_obj);
        }

        switch($X->dtype()) {
            case NDArray::float32:{
                $status = $this->blas->CLBlastSaxpy($n,$alpha,
                    $bufferX_p,$offsetX,$incX,
                    $bufferY_p,$offsetY,$incY,
                    $queue_p,$event_p
                );
                break;
            }
            case NDArray::float64:{
                $status = $this->blas->CLBlastDaxpy($n,$alpha,
                    $bufferX_p,$offsetX,$incX,
                    $bufferY_p,$offsetY,$incY,
                    $queue_p,$event_p
                );
                break;
            }
            default: {
                throw new InvalidArgumentException('Unsuppored data type');
            }
        }
        if($status!=self::CLBlastSuccess) {
            throw new RuntimeException("CLBlast?scal error=$status", $status);
        }
        if($event) {
            $event->_move($event_obj);
        }
    }
}