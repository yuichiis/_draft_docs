<?php
include 'opencl-tests/benchmark/init_autoloader.php';

$mo = new Rindow\Math\Matrix\MatrixOperator();
$la = $mo->la();

$a = $mo->array([[1.0, 2.0],[3.0, 4.0]]);
$b = $mo->array([[3.0, 4.0],[5.0, 6.0]]);

$c = $la->gemm($a,$b);

echo $mo->toString($c)."\n";
print_r($c->toArray());

### If you want to create a graph like this:

$plt = new Rindow\Math\Plot\Plot();

$plt->bar(['x','y'],$c);
$plt->show();
