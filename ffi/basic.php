<?php
declare(strict_types=1);

$ffi = FFI::cdef("
    void cblas_sscal(int N, float alpha, float *X, int incX);

    ","libopenblas.dll");

$buf = FFI::new('float[10]');
//$alpha = FFI::new('float');
//$n = FFI::new('int');
//$incx = FFI::new('int');
//$alpha->cdata = 2.0;
//$n->cdata = 10;
//$incx->cdata = 1;

for($i=0;$i<10;$i++) {
    //$buf[$i]->cdata = $i;
    $buf[$i] = $i;
}
$ffi->cblas_sscal(10,2.0,FFI::addr($buf[0]),1);
for($i=0;$i<10;$i++) {
    var_dump($buf[$i]);
}
