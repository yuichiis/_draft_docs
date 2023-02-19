<?php
declare(strict_types=1);

FFI::load(__DIR__ . "/blasffi.i");
$ffi = FFI::cdef("
    void cblas_sscal(int N, float alpha, float *X, int incX);

    ","libopenblas.dll");

$buf = FFI::new('float[10]');
for($i=0;$i<10;$i++) {
    $buf[$i] = $i;
}
$ffi->cblas_sscal(10,2.0,FFI::addr($buf[0]),1);
for($i=0;$i<10;$i++) {
    var_dump($buf[$i]);
}
