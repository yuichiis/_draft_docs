<?php
namespace Rindow\OpenCL\FFI;

use Interop\Polite\Math\Matrix\Buffer;
use Interop\Polite\Math\Matrix\NDArray;
use Interop\Polite\Math\Matrix\OpenCL;
use InvalidArgumentException;
use RuntimeException;
use OutOfRangeException;
use LogicException;
use FFI;
use Countable;

class CommandQueue
{
    protected FFI $ffi;
    protected object $command_queue;

    public function __construct(FFI $ffi,
        Context $context,
        object $device_id=null,
        object $properties=null,
        )
    {
        $this->ffi = $ffi;
        if($device_id===null) {
            $device = $context->_getDeviceIds();
            if($device==NULL) {
                throw new InvalidArgumentException("Context is not initialized", CL_INVALID_CONTEXT);
            }
            $device = $device[0];
        } else {
            $device = $device_id;
        }
    
        $errcode_ret = $ffi->new('cl_int[1]');
        $command_queue = $ffi->clCreateCommandQueue(
            $context->_getId(),
            $device,
            $properties,
            $errcode_ret);
        if($errcode_ret[0]!=OpenCL::CL_SUCCESS) {
            throw new RuntimeException("clCreateCommandQueue Error errcode=".$errcode_ret[0]);
        }
        $this->command_queue = $command_queue;
    }

    public function __destruct()
    {
        if($this->command_queue) {
            $errcode_ret = $this->ffi->clReleaseCommandQueue($this->command_queue);
            if($errcode_ret!=0) {
                throw new RuntimeException("clReleaseCommandQueue Error errcode=".$errcode_ret);
            }
        }
    }

    public function _getId() : object
    {
        return $this->command_queue;
    }

    public function flush() : void
    {
        $ffi = $this->ffi;
    
        $errcode_ret = $ffi->clFlush($this->command_queue);
        if($errcode_ret!=0) {
            throw new RuntimeException("clFlush Error errcode=".$errcode_ret);
        }
    }

    public function finish() : void
    {
        $ffi = $this->ffi;

        $errcode_ret = $ffi->clFinish($this->command_queue);
        if($errcode_ret!=0) {
            throw new RuntimeException("clFinish Error errcode=".$errcode_ret);
        }
    }
}
