<?php
$loader = include __DIR__.'/autoload.php';
$loader->addPsr4('Rindow\\OpenCL2\\', __DIR__.'/OpenCL');

use Rindow\OpenCL2\OpenCLFactory;
use Interop\Polite\Math\Matrix\OpenCL;

$ocl = new OpenCLFactory();

$platforms = $ocl->PlatformList();

var_dump(count($platforms));
var_dump(count($platforms->getOne(0)));
echo "CL_PLATFORM_PROFILE: "; var_dump($platforms->getInfo(0,OpenCL::CL_PLATFORM_PROFILE));
echo "CL_PLATFORM_VERSION: "; var_dump($platforms->getInfo(0,OpenCL::CL_PLATFORM_VERSION));
echo "CL_PLATFORM_NAME: "; var_dump($platforms->getInfo(0,OpenCL::CL_PLATFORM_NAME));
echo "CL_PLATFORM_VENDOR: "; var_dump($platforms->getInfo(0,OpenCL::CL_PLATFORM_VENDOR));
echo "CL_PLATFORM_EXTENSIONS: "; var_dump($platforms->getInfo(0,OpenCL::CL_PLATFORM_EXTENSIONS));

$devices = $ocl->DeviceList($platforms);
var_dump(count($devices));
var_dump(count($devices->getOne(0)));

for($i=0;$i<count($devices);$i++) {
    echo "======\n";
    echo "CL_DEVICE_NAME: "; var_dump($devices->getInfo($i,OpenCL::CL_DEVICE_NAME));
    echo "CL_DEVICE_VENDOR: "; var_dump($devices->getInfo($i,OpenCL::CL_DEVICE_VENDOR));
    echo "CL_DRIVER_VERSION: "; var_dump($devices->getInfo($i,OpenCL::CL_DRIVER_VERSION));
    echo "CL_DEVICE_PROFILE: "; var_dump($devices->getInfo($i,OpenCL::CL_DEVICE_PROFILE));
    echo "CL_DEVICE_VERSION: "; var_dump($devices->getInfo($i,OpenCL::CL_DEVICE_VERSION));
    echo "CL_DEVICE_OPENCL_C_VERSION: "; var_dump($devices->getInfo($i,OpenCL::CL_DEVICE_OPENCL_C_VERSION));
    echo "CL_DEVICE_EXTENSIONS: "; var_dump($devices->getInfo($i,OpenCL::CL_DEVICE_EXTENSIONS));
    echo "CL_DEVICE_BUILT_IN_KERNELS: "; var_dump($devices->getInfo($i,OpenCL::CL_DEVICE_BUILT_IN_KERNELS));
    // int
    echo "CL_DEVICE_VENDOR_ID: "; var_dump($devices->getInfo($i,OpenCL::CL_DEVICE_VENDOR_ID));
    echo "CL_DEVICE_MAX_COMPUTE_UNITS: "; var_dump($devices->getInfo($i,OpenCL::CL_DEVICE_MAX_COMPUTE_UNITS));
    // long
    echo "CL_DEVICE_MAX_MEM_ALLOC_SIZE: "; var_dump($devices->getInfo($i,OpenCL::CL_DEVICE_MAX_MEM_ALLOC_SIZE));
    echo "CL_DEVICE_GLOBAL_MEM_SIZE: "; var_dump($devices->getInfo($i,OpenCL::CL_DEVICE_GLOBAL_MEM_SIZE));
    // bool
    echo "CL_DEVICE_IMAGE_SUPPORT: "; var_dump($devices->getInfo($i,OpenCL::CL_DEVICE_IMAGE_SUPPORT));
    echo "CL_DEVICE_ERROR_CORRECTION_SUPPORT: "; var_dump($devices->getInfo($i,OpenCL::CL_DEVICE_ERROR_CORRECTION_SUPPORT));
    echo "CL_DEVICE_HOST_UNIFIED_MEMORY: "; var_dump($devices->getInfo($i,OpenCL::CL_DEVICE_HOST_UNIFIED_MEMORY));
    echo "CL_DEVICE_ENDIAN_LITTLE: "; var_dump($devices->getInfo($i,OpenCL::CL_DEVICE_ENDIAN_LITTLE));
    echo "CL_DEVICE_AVAILABLE: "; var_dump($devices->getInfo($i,OpenCL::CL_DEVICE_AVAILABLE));
    echo "CL_DEVICE_COMPILER_AVAILABLE: "; var_dump($devices->getInfo($i,OpenCL::CL_DEVICE_COMPILER_AVAILABLE));
    echo "CL_DEVICE_LINKER_AVAILABLE: "; var_dump($devices->getInfo($i,OpenCL::CL_DEVICE_LINKER_AVAILABLE));
    echo "CL_DEVICE_PREFERRED_INTEROP_USER_SYNC: "; var_dump($devices->getInfo($i,OpenCL::CL_DEVICE_PREFERRED_INTEROP_USER_SYNC));
    // size_t
    echo "CL_DEVICE_MAX_WORK_GROUP_SIZE: "; var_dump($devices->getInfo($i,OpenCL::CL_DEVICE_MAX_WORK_GROUP_SIZE));
    echo "CL_DEVICE_IMAGE2D_MAX_WIDTH: "; var_dump($devices->getInfo($i,OpenCL::CL_DEVICE_IMAGE2D_MAX_WIDTH));
    echo "CL_DEVICE_IMAGE2D_MAX_HEIGHT: "; var_dump($devices->getInfo($i,OpenCL::CL_DEVICE_IMAGE2D_MAX_HEIGHT));
    echo "CL_DEVICE_IMAGE3D_MAX_WIDTH: "; var_dump($devices->getInfo($i,OpenCL::CL_DEVICE_IMAGE3D_MAX_WIDTH));
    echo "CL_DEVICE_IMAGE3D_MAX_HEIGHT: "; var_dump($devices->getInfo($i,OpenCL::CL_DEVICE_IMAGE3D_MAX_HEIGHT));
    echo "CL_DEVICE_IMAGE3D_MAX_DEPTH: "; var_dump($devices->getInfo($i,OpenCL::CL_DEVICE_IMAGE3D_MAX_DEPTH));
    echo "CL_DEVICE_MAX_PARAMETER_SIZE: "; var_dump($devices->getInfo($i,OpenCL::CL_DEVICE_MAX_PARAMETER_SIZE));
    echo "CL_DEVICE_PROFILING_TIMER_RESOLUTION: "; var_dump($devices->getInfo($i,OpenCL::CL_DEVICE_PROFILING_TIMER_RESOLUTION));
    echo "CL_DEVICE_IMAGE_MAX_BUFFER_SIZE: "; var_dump($devices->getInfo($i,OpenCL::CL_DEVICE_IMAGE_MAX_BUFFER_SIZE));
    echo "CL_DEVICE_IMAGE_MAX_ARRAY_SIZE: "; var_dump($devices->getInfo($i,OpenCL::CL_DEVICE_IMAGE_MAX_ARRAY_SIZE));
    echo "CL_DEVICE_PRINTF_BUFFER_SIZE: "; var_dump($devices->getInfo($i,OpenCL::CL_DEVICE_PRINTF_BUFFER_SIZE));

    // bitfield
    echo "CL_DEVICE_TYPE: 0x".dechex($devices->getInfo($i,OpenCL::CL_DEVICE_TYPE))."\n";
    echo "CL_DEVICE_SINGLE_FP_CONFIG: 0x".dechex($devices->getInfo($i,OpenCL::CL_DEVICE_SINGLE_FP_CONFIG))."\n";
    echo "CL_DEVICE_DOUBLE_FP_CONFIG: 0x".dechex($devices->getInfo($i,OpenCL::CL_DEVICE_DOUBLE_FP_CONFIG))."\n";
    echo "CL_DEVICE_EXECUTION_CAPABILITIES: 0x".dechex($devices->getInfo($i,OpenCL::CL_DEVICE_EXECUTION_CAPABILITIES))."\n";
    echo "CL_DEVICE_QUEUE_PROPERTIES: 0x".dechex($devices->getInfo($i,OpenCL::CL_DEVICE_QUEUE_PROPERTIES))."\n";
    // devices
    $parentDev = $devices->getInfo($i,OpenCL::CL_DEVICE_PARENT_DEVICE);
    echo "CL_DEVICE_PARENT_DEVICE: ";
    if($parentDev===null) {
        echo "NULL\n";
    } else {
        var_dump($parentDev->getInfo(0,OpenCL::CL_DEVICE_NAME));
    }
    // array<size_t>
    echo "CL_DEVICE_MAX_WORK_ITEM_SIZES: [".implode(',',$devices->getInfo($i,OpenCL::CL_DEVICE_MAX_WORK_ITEM_SIZES))."]\n";
    // array<cl_device_partition_property>
    echo "CL_DEVICE_PARTITION_PROPERTIES: [".implode(',',$devices->getInfo($i,OpenCL::CL_DEVICE_PARTITION_PROPERTIES))."]\n";
    echo "CL_DEVICE_PARTITION_TYPE: [".implode(',',$devices->getInfo($i,OpenCL::CL_DEVICE_PARTITION_TYPE))."]\n";
}
echo "======\n";


$devices2 = $ocl->DeviceList($platforms);
$devices->append($devices2);
var_dump(count($devices));

for($i=0;$i<count($devices);$i++) {
    var_dump($devices->getInfo($i,OpenCL::CL_DEVICE_NAME));
}
