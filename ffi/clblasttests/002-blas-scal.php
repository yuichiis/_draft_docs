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


define('NMITEM',2048);

$context = $ocl->Context(OpenCL::CL_DEVICE_TYPE_DEFAULT);
$queue = $ocl->CommandQueue($context);
$hostBuffer = new HostBuffer(NMITEM,NDArray::float32);
for($i=0;$i<NMITEM;$i++) {
    $hostBuffer[$i]=$i;
}
$buffer = $ocl->Buffer($context,intval(NMITEM*32/8),
    OpenCL::CL_MEM_READ_WRITE|OpenCL::CL_MEM_COPY_HOST_PTR,
    $hostBuffer);

$blas = new Rindow\CLBlast2\Blas();
$events = $ocl->EventList();
$blas->scal(NMITEM,$alpha=2.0,$buffer,$offset=0,$inc=1,$queue,$events);
$events->wait();
$buffer->read($queue,$hostBuffer);
for($i=0;$i<NMITEM;$i++) {
    assert($hostBuffer[$i]==$i*2);
}
echo "SUCCESS Full-range\n";
$blas->scal(intval(NMITEM/2),$alpha=0.5,$buffer,
            $offset=intval(NMITEM/2),$inc=1,$queue,$events);
$events->wait();
$buffer->read($queue,$hostBuffer);
for($i=0;$i<NMITEM;$i++) {
    if($i<intval(NMITEM/2))
        assert($hostBuffer[$i]==$i*2);
    else
        assert($hostBuffer[$i]==$i);
}
echo "SUCCESS Offset-range\n";
$blas->scal(intval(NMITEM/2),$alpha=0.5,$buffer,
            $offset=0,$inc=1,$queue,$events);
$events->wait();
$buffer->read($queue,$hostBuffer);
for($i=0;$i<NMITEM;$i++) {
    assert($hostBuffer[$i]==$i);
}
echo "SUCCESS Limit-range\n";
//
// invalid object arguments
//
$events = $ocl->EventList();
$invalidBuffer = new \stdClass();
try {
    $blas->scal(intval(2),$alpha=1.0,
        $invalidBuffer,$offset=0,$inc=1,
        $queue,$events);
} catch (\Throwable $e) {
    echo "Invalid Buffer catch: ".get_class($e)."\n";
}
$events = $ocl->EventList();
$invalidQueue = new \stdClass();
try {
    $blas->scal(intval(2),$alpha=1.0,
        $buffer,$offset=0,$inc=1,
        $invalidQueue,$events);
} catch (\Throwable $e) {
    echo "Invalid Queue catch: ".get_class($e)."\n";
}
$events = $ocl->EventList();
$invalidEvents = new \stdClass();
try {
    $blas->scal(intval(2),$alpha=1.0,
        $buffer,$offset=0,$inc=1,
        $queue,$invalidEvents);
} catch (\Throwable $e) {
    echo "Invalid Event catch: ".get_class($e)."\n";
}
echo "SUCCESS invalid object arguments\n";
