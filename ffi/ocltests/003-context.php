<?php
$loader = include __DIR__.'/../autoload.php';

$loader->addPsr4('Rindow\\OpenCL2\\', __DIR__.'/../OpenCL');
include __DIR__.'/../OpenBLAS/Buffer.php';

use Rindow\OpenCL2\OpenCLFactory;
use Rindow\OpenCL2\Program;
use Interop\Polite\Math\Matrix\OpenCL;
use Interop\Polite\Math\Matrix\NDArray;

use Rindow\OpenBLAS2\Buffer as HostBuffer;

$ocl = new OpenCLFactory();

$platforms = $ocl->PlatformList();
$devices = $ocl->DeviceList($platforms);
$total_dev = $devices->count();
assert($total_dev>=0);

#
#  construct by default
#
$context = $ocl->Context(OpenCL::CL_DEVICE_TYPE_DEFAULT);
echo "SUCCESS construct by default\n";
#
#  construct context from type
#
$count = 0;
foreach([OpenCL::CL_DEVICE_TYPE_GPU,OpenCL::CL_DEVICE_TYPE_CPU] as $type) {
    try {
        $context = $ocl->Context($type);
        $con_type = $context->getInfo(OpenCL::CL_CONTEXT_DEVICES)->getInfo(0,OpenCL::CL_DEVICE_TYPE);
        assert(true==($con_type&$type));
        $count++;
    } catch(\RuntimeException $e) {
        ;
    }
}
assert($total_dev==$count);
echo "SUCCESS construct from device type\n";
#
#  construct context from device_id
#
$platform = $ocl->PlatformList();
$count = 0;
foreach([OpenCL::CL_DEVICE_TYPE_GPU,OpenCL::CL_DEVICE_TYPE_CPU] as $type) {
    try {
        $devices = $ocl->DeviceList($platform,0,$type);
        $context = $ocl->Context($devices);
        #echo $context->getInfo(OpenCL::CL_CONTEXT_DEVICES)->getInfo(0,OpenCL::CL_DEVICE_NAME)."\n";
        $con_type = $context->getInfo(OpenCL::CL_CONTEXT_DEVICES)->getInfo(0,OpenCL::CL_DEVICE_TYPE);
        assert(true==($con_type&$type));
        $count++;
    } catch(\RuntimeException $e) {
        ;
    }
}
assert($total_dev==$count);
echo "SUCCESS construct from device_id\n";
#
#  get information
#

$context = $ocl->Context(OpenCL::CL_DEVICE_TYPE_DEFAULT);
assert(1==$context->getInfo(OpenCL::CL_CONTEXT_REFERENCE_COUNT));
$devices = $context->getInfo(OpenCL::CL_CONTEXT_DEVICES);
assert($devices instanceof Rindow\OpenCL2\DeviceList);
$properties = $context->getInfo(OpenCL::CL_CONTEXT_PROPERTIES);
assert(is_array($properties));
echo "SUCCESS get array info\n";
/*
echo $context->getInfo(OpenCL::CL_CONTEXT_REFERENCE_COUNT)."\n";
echo "CL_CONTEXT_REFERENCE_COUNT=".$context->getInfo(OpenCL::CL_CONTEXT_REFERENCE_COUNT)."\n";
echo "CL_CONTEXT_NUM_DEVICES=".$context->getInfo(OpenCL::CL_CONTEXT_NUM_DEVICES)."\n";
echo "CL_CONTEXT_DEVICES=";
$devices = $context->getInfo(OpenCL::CL_CONTEXT_DEVICES);
echo "deivces(".$devices->count().")\n";
for($i=0;$i<$devices->count();$i++) {
    echo "    CL_DEVICE_NAME=".$devices->getInfo($i,OpenCL::CL_DEVICE_NAME)."\n";
    echo "    CL_DEVICE_VENDOR=".$devices->getInfo($i,OpenCL::CL_DEVICE_VENDOR)."\n";
    echo "    CL_DEVICE_TYPE=(";
    $device_type = $devices->getInfo($i,OpenCL::CL_DEVICE_TYPE);
    if($device_type&OpenCL::CL_DEVICE_TYPE_CPU) { echo "CPU,"; }
    if($device_type&OpenCL::CL_DEVICE_TYPE_GPU) { echo "GPU,"; }
    if($device_type&OpenCL::CL_DEVICE_TYPE_ACCELERATOR) { echo "ACCEL,"; }
    if($device_type&OpenCL::CL_DEVICE_TYPE_CUSTOM) { echo "CUSTOM,"; }
    echo ")\n";
    echo "    CL_DRIVER_VERSION=".$devices->getInfo($i,OpenCL::CL_DRIVER_VERSION)."\n";
    echo "    CL_DEVICE_VERSION=".$devices->getInfo($i,OpenCL::CL_DEVICE_VERSION)."\n";
}
echo "CL_CONTEXT_PROPERTIES=(".implode(',',array_map(function($x){ return "0x".dechex($x);},
    $context->getInfo(OpenCL::CL_CONTEXT_PROPERTIES))).")\n";
*/
echo 'SUCCESS';
