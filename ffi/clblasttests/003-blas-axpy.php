<?php
$loader = include __DIR__.'/../autoload.php';

$loader->addPsr4('Rindow\\OpenCL2\\', __DIR__.'/../OpenCL');
$loader->addPsr4('Rindow\\CLBlast2\\', __DIR__.'/../CLBlast');
include __DIR__.'/../OpenBLAS/Buffer.php';

use Rindow\OpenCL2\OpenCLFactory;
use Rindow\OpenCL2\Program;
use Interop\Polite\Math\Matrix\OpenCL;
use Interop\Polite\Math\Matrix\NDArray;

use Rindow\OpenBLAS2\Buffer as HostBuffer;

$ocl = new OpenCLFactory();


define('NMITEM',1024);

$context = $ocl->Context(OpenCL::CL_DEVICE_TYPE_DEFAULT);
$queue = $ocl->CommandQueue($context);
$hostBufferX = new HostBuffer(NMITEM,NDArray::float32);
$hostBufferY = new HostBuffer(NMITEM,NDArray::float32);
$alpha=2.0;
for($i=0;$i<NMITEM;$i++) {
    $hostBufferX[$i]=$i;
    $hostBufferY[$i]=NMITEM-1-$i;
}
$bufferX = $ocl->Buffer($context,intval(NMITEM*32/8),
    OpenCL::CL_MEM_READ_ONLY|OpenCL::CL_MEM_COPY_HOST_PTR,
    $hostBufferX);
$bufferY = $ocl->Buffer($context,intval(NMITEM*32/8),
    OpenCL::CL_MEM_READ_WRITE|OpenCL::CL_MEM_COPY_HOST_PTR,
    $hostBufferY);

$blas = new Rindow\CLBlast2\Blas();
$events = $ocl->EventList();
$blas->axpy(NMITEM,$alpha,
    $bufferX,$offsetX=0,$incX=1,
    $bufferY,$offsetY=0,$incY=1,
    $queue,$events);
$events->wait();
$bufferY->read($queue,$hostBufferY);
for($i=0;$i<NMITEM;$i++) {
    assert($hostBufferY[$i]==($i*2)+(NMITEM-1-$i));
}
echo "SUCCESS\n";
//
// invalid object arguments
//
$events = $ocl->EventList();
$invalidBuffer = new \stdClass();
try {
    $blas->axpy(intval(2),$alpha=1.0,
        $invalidBuffer,$offset=0,$inc=1,
        $bufferY,$offsetY=0,$incY=1,
        $queue,$events);
} catch (\Throwable $e) {
    echo "Invalid Buffer catch: ".get_class($e)."\n";
}
try {
    $blas->axpy(intval(2),$alpha=1.0,
        $bufferX,$offset=0,$inc=1,
        $invalidBuffer,$offsetY=0,$incY=1,
        $queue,$events);
} catch (\Throwable $e) {
    echo "Invalid Buffer catch: ".get_class($e)."\n";
}
$events = $ocl->EventList();
$invalidQueue = new \stdClass();
try {
    $blas->axpy(intval(2),$alpha=1.0,
        $bufferX,$offset=0,$inc=1,
        $bufferY,$offsetY=0,$incY=1,
        $invalidQueue,$events);
} catch (\Throwable $e) {
    echo "Invalid Queue catch: ".get_class($e)."\n";
}
$events = $ocl->EventList();
$invalidEvents = new \stdClass();
try {
    $blas->axpy(intval(2),$alpha=1.0,
        $bufferX,$offset=0,$inc=1,
        $bufferY,$offsetY=0,$incY=1,
        $queue,$invalidEvents);
} catch (\Throwable $e) {
    echo "Invalid Event catch: ".get_class($e)."\n";
}
echo "SUCCESS invalid object arguments\n";
