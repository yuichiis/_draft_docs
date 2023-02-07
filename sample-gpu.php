<?php
include 'opencl-tests/benchmark/init_autoloader.php';

use Interop\Polite\Math\Matrix\OpenCL;

$mo = new Rindow\Math\Matrix\MatrixOperator();
$la = $mo->laAccelerated('clblast',['deviceType'=>OpenCL::CL_DEVICE_TYPE_GPU]);
$la->blocking(true);

$a = $mo->array([[1.0, 2.0],[3.0, 4.0]]);
$b = $mo->array([[3.0, 4.0],[5.0, 6.0]]);

$a = $la->array($a);
$b = $la->array($b);
$c = $la->gemm($a,$b);
$c = $la->toNDArray($c);

echo $mo->toString($c)."\n";
print_r($c->toArray());

### If you want to create a graph like this:

$plt = new Rindow\Math\Plot\Plot();

$plt->bar(['x','y'],$c);
$plt->show();
