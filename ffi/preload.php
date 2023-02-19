<?php
declare(strict_types=1);

$ffi = FFI::load(__DIR__ . "/blas_win.h");

$buf = FFI::new('float[10]');
var_dump(count($buf));

for($i=0;$i<10;$i++) {
    $buf[$i] = $i;
}
var_dump(gettype($buf));
var_dump(get_class($buf));
var_dump(gettype($buf[0]));
var_dump(gettype(FFI::addr($buf[0])));
var_dump(get_class(FFI::addr($buf[0])));
$ffi->cblas_sscal(10,2.0,FFI::addr($buf[0]),1);
for($i=0;$i<10;$i++) {
    var_dump($buf[$i]);
}

//var_dump(isset($buf[11]));
//echo $buf[11];