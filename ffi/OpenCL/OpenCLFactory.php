<?php
namespace Rindow\OpenCL\FFI;

use FFI;
use Interop\Polite\Math\Matrix\Buffer as BufferInterface;

class OpenCLFactory
{
    protected FFI $ffi;

    public function __construct(string $file=null)
    {
        $file = $file ?? __DIR__ . "/opencl_win.h";
        $ffi = FFI::load($file);
        $this->ffi = $ffi;
    }

    public function PlatformList() : PlatformList
    {
        return new PlatformList($this->ffi);
    }

    public function DeviceList(
        PlatformList $platforms,
        int $index=NULL,
        int $device_type=NULL,
    ) : DeviceList
    {
        return new DeviceList($this->ffi,$platforms,$index,$device_type);
    }

    public function Context(
        DeviceList|int $arg
    ) : Context
    {
        return new Context($this->ffi,$arg);
    }

    public function EventList(
        Context $context=null
    ) : EventList
    {
        return new EventList($this->ffi, $context);
    }

    public function CommandQueue(
        Context $context,
        object $device_id=null,
        object $properties=null,
    ) : CommandQueue
    {
        return new CommandQueue($this->ffi, $context, $device_id, $properties);
    }

    public function Program(
        Context $context,
        string|array $source,   // string or list of something
        int $mode=null,         // mode  0:source codes, 1:binary, 2:built-in kernel, 3:linker
        DeviceList $device_list=null,
        string $options=null,
        ) : Program
    {
        return new Program($this->ffi, $context, $source, $mode, $device_list, $options);
    }

    public function Buffer(
        Context $context,
        int $size,
        int $flags=null,
        BufferInterface $host_buffer=null,
        int $host_offset=null,
        int $dtype=null,
        ) : Buffer
    {
        return new Buffer($this->ffi, $context, $size, $flags, $host_buffer, $host_offset, $dtype);
    }

    public function Kernel
    (
        Program $program,
        string $kernel_name,
        ) : Kernel
    {
        return new Kernel($this->ffi, $program, $kernel_name);
    }
}
