<?php
$loader = include __DIR__.'/autoload.php';
$loader->addPsr4('Rindow\\OpenCL2\\', __DIR__.'/OpenCL');

use Rindow\OpenCL2\OpenCLFactory;
use Interop\Polite\Math\Matrix\OpenCL;

$ocl = new OpenCLFactory();

echo "clCreateContextFromType:\n";
$context = $ocl->Context(OpenCL::CL_DEVICE_TYPE_GPU);
$dev = $context->getInfo(OpenCL::CL_CONTEXT_DEVICES);
echo "CL_CONTEXT_DEVICES(".count($dev)."): "; var_dump($dev->getInfo(0,OpenCL::CL_DEVICE_NAME));
echo "CL_CONTEXT_PROPERTIES: [".implode(',',$context->getInfo(OpenCL::CL_CONTEXT_PROPERTIES))."]\n";
echo "CL_CONTEXT_REFERENCE_COUNT: "; var_dump($context->getInfo(OpenCL::CL_CONTEXT_REFERENCE_COUNT));
echo "CL_CONTEXT_NUM_DEVICES: "; var_dump($context->getInfo(OpenCL::CL_CONTEXT_NUM_DEVICES));

echo "\n";

echo "clCreateContext:\n";
$platforms = $ocl->PlatformList();
$devices = $ocl->DeviceList($platforms);
echo "dev count(".count($devices).")\n";
$context = $ocl->Context($devices);
$dev = $context->getInfo(OpenCL::CL_CONTEXT_DEVICES);
echo "CL_CONTEXT_DEVICES(".count($dev)."): "; var_dump($dev->getInfo(0,OpenCL::CL_DEVICE_NAME));

$devices = $ocl->DeviceList($platforms,device_type:OpenCL::CL_DEVICE_TYPE_GPU);
//$devices = $ocl->DeviceList($platforms,device_type:OpenCL::CL_DEVICE_TYPE_CPU);
echo "dev count(".count($devices).")\n";
$context = $ocl->Context($devices);

$dev = $context->getInfo(OpenCL::CL_CONTEXT_DEVICES);
echo "CL_CONTEXT_DEVICES(".count($dev)."): "; var_dump($dev->getInfo(0,OpenCL::CL_DEVICE_NAME));
echo "CL_CONTEXT_PROPERTIES: [".implode(',',$context->getInfo(OpenCL::CL_CONTEXT_PROPERTIES))."]\n";
echo "CL_CONTEXT_REFERENCE_COUNT: "; var_dump($context->getInfo(OpenCL::CL_CONTEXT_REFERENCE_COUNT));
echo "CL_CONTEXT_NUM_DEVICES: "; var_dump($context->getInfo(OpenCL::CL_CONTEXT_NUM_DEVICES));

echo "EventList:\n";
$events = $ocl->EventList($context);
echo "ev1:"; var_dump(count($events));
echo "create empty\n";
$events2 = $ocl->EventList();
echo "ev2:"; var_dump(count($events2));
echo "copy\n";
$events2->copy($events);
echo "ev1:"; var_dump(count($events));
echo "ev2:"; var_dump(count($events2));
echo "copy\n";
$events2->copy($events);
echo "ev1:"; var_dump(count($events));
echo "ev2:"; var_dump(count($events2));
echo "create empty\n";
$events3 = $ocl->EventList();
echo "ev3:"; var_dump(count($events3));
echo "move\n";
$events3->move($events2);
echo "ev2:"; var_dump(count($events2));
echo "ev3:"; var_dump(count($events3));
echo "setStatus\n";
$events4 = $ocl->EventList($context);
$events3->move($events4);
echo "ev3:"; var_dump(count($events3));
echo "setStatus(0)\n";
$events3->setStatus(OpenCL::CL_COMPLETE);
echo "setStatus(1)\n";
try {
    $events3->setStatus(OpenCL::CL_COMPLETE,1);
} catch(\Exception $e) {
    echo $e->getMessage()."\n";
}
echo "setStatus(2)\n";
$events3->setStatus(OpenCL::CL_COMPLETE,2);

