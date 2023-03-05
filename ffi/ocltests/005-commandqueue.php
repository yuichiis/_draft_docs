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

$context = $ocl->Context(OpenCL::CL_DEVICE_TYPE_DEFAULT);
$queue = $ocl->CommandQueue($context);
echo "SUCCESS\n";

$hostBuffer = new HostBuffer(
    16,NDArray::float32);
foreach(range(0,15) as $value) {
    $hostBuffer[$value] = $value;
}
$buffer = $ocl->Buffer($context,intval(16*32/8),
    OpenCL::CL_MEM_READ_WRITE);
$buffer->write($queue,$hostBuffer,0,0,0,false);
$queue->flush();
$queue->finish();
echo "SUCCESS finish\n";
