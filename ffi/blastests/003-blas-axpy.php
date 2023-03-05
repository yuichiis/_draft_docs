<?php
$loader = include __DIR__.'/../autoload.php';

$loader->addPsr4('Rindow\\OpenBLAS\\FFI\\', __DIR__.'/../OpenBLAS');

include __DIR__.'/new_array.php';

use Rindow\OpenBLAS\FFI\OpenBLASFactory;
use Interop\Polite\Math\Matrix\NDArray;

$obf = new OpenBLASFactory();
$blas = $obf->Blas();

$dtype = NDArray::float32;
$n = 2;
$X = new_array($obf,[1,2],$dtype);
$Y = new_array($obf,[2,3],$dtype);
$blas->axpy($n,$alpha=2.0,
    $X,$offsetX=0,$incX=1,
    $Y,$offsetY=0,$incY=1,
);
print_array($obf,$Y,1,$n);

