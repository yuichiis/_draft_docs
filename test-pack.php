<?php
include 'opencl-tests/benchmark/init_autoloader.php';

use Interop\Polite\Math\Matrix\OpenCL;
use Interop\Polite\Math\Matrix\NDArray;
use Rindow\Math\Matrix\MatrixOperator;

function myArray(object $la, array $arr) : object
{
	$buf = '';
	foreach($arr as $row)
		$buf .= pack('d*',...$row);
	$a = $la->alloc([count($arr),count(reset($arr))],NDArray::float64);
	$a->buffer()->load($buf);
	return $a;
}

$A = [[1,2],[3,4]];

$mo = new MatrixOperator;
$la = $mo->la();
$gla = $mo->laAccelerated('clblast',['deviceType'=>OpenCL::CL_DEVICE_TYPE_GPU]);
$gla->blocking(true);

$a = myArray($la,$A);
$ga = $gla->array($a);
### something ####
//$y = $gla->toNDArray($y);
