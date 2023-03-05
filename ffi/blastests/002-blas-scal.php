<?php
$loader = include __DIR__.'/../autoload.php';

$loader->addPsr4('Rindow\\OpenBLAS\\FFI\\', __DIR__.'/../OpenBLAS');

include __DIR__.'/new_array.php';

use Rindow\OpenBLAS\FFI\OpenBLASFactory;
use Interop\Polite\Math\Matrix\NDArray;

$obf = new OpenBLASFactory();
$blas = $obf->Blas();

$a = new_array($obf,[1,2],NDArray::float32);

$blas->scal(2,10,$a,0,1);
var_dump($a[0]);
var_dump($a[1]);

