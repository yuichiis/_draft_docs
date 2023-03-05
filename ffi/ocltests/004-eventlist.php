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


$events1 = $ocl->EventList();
assert(count($events1)==0);
echo "SUCCESS construct empty\n";
$context = $ocl->Context(OpenCL::CL_DEVICE_TYPE_DEFAULT);
$events2 = $ocl->EventList($context);
assert(count($events2)==1);
echo "SUCCESS construct user event\n";
$events3 = $ocl->EventList($context);
assert(count($events3)==1);
#  move ev2 to ev1
$events1->move($events2);
#  copy ev3 to ev1
$events1->copy($events3);
assert(count($events1)==2);
assert(count($events2)==0);
assert(count($events3)==1);
echo "SUCCESS move events\n";
$events3->setStatus(OpenCL::CL_COMPLETE);
echo "SUCCESS setStatus\n";
unset($events1);
unset($events2);
unset($events3);
echo "SUCCESS destruct events\n";
$events = $ocl->EventList(null);
assert(count($events)==0);
echo "SUCCESS construct events with null arguments\n";
