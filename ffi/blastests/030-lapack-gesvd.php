<?php
$loader = include __DIR__.'/../autoload.php';

$loader->addPsr4('Rindow\\OpenBLAS\\FFI\\', __DIR__.'/../OpenBLAS');

include __DIR__.'/new_array.php';

use Rindow\OpenBLAS\FFI\OpenBLASFactory;
use Interop\Polite\Math\Matrix\NDArray;

const LAPACK_ROW_MAJOR = 101;
const LAPACK_COL_MAJOR = 102;

$obf = new OpenBLASFactory();
$lapack = $obf->Lapack();

$m = 6;
$n = 4;
$A = [
   [ 2.27,  -1.54,   1.15,  -1.94],
   [ 0.28,  -1.67,   0.94,  -0.78],
   [-0.48,  -3.09,   0.99,  -0.21],
   [ 1.07,   1.22,   0.79,   0.63],
   [-2.35,   2.93,  -1.45,   2.30],
   [ 0.62,  -7.39,   1.03,  -2.57],
];
$fullMatrices = true;
$dtype = NDArray::float32;

$A = new_array($obf,$A,$dtype);
echo "==== A ====\n";
print_array($obf,$A,$m,$n);


if($fullMatrices) {
    $jobu  = 'A';
    $jobvt = 'A';
    $ldA = $n;
    $ldU = $m;
    $ldVT = $n;
} else {
    $jobu  = 'S';
    $jobvt = 'S';
    $ldA = $n;
    $ldU = min($m,$n);
    #$ldVT = min($m,$n);
    $ldVT = $n; // bug in the lapacke ???
}

$S = new_zeros($obf,[min($m,$n)],$dtype);
$U = new_zeros($obf,[$m,$ldU],$dtype);
$VT = new_zeros($obf,[$ldVT,$n],$dtype);
$SuperB = new_zeros($obf,[min($m,$n)-1],$dtype);

$offsetA = 0;
$offsetS = 0;
$offsetU = 0;
$offsetVT = 0;
$offsetSuperB = 0;

$lapack->gesvd(
    LAPACK_ROW_MAJOR,
    ord($jobu),
    ord($jobvt),
    $m,
    $n,
    $A,  $offsetA,  $ldA,
    $S,  $offsetS,
    $U,  $offsetU,  $ldU,
    $VT, $offsetVT, $ldVT,
    $SuperB,  $offsetSuperB
);
echo "==== S ====\n";
print_array($obf,$S,1,min($m,$n));
echo "==== U ====\n";
print_array($obf,$U,$m,$ldU);
echo "==== VT ====\n";
print_array($obf,$VT,$ldVT,$n);
echo "==== SuperB ====\n";
print_array($obf,$SuperB,1,min($m,$n)-1);
