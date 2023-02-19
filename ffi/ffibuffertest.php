<?php
include '../opencl-tests/benchmark/init_autoloader.php';
include __DIR__.'/FFIBuffer.php';
include __DIR__.'/FFIOpenBlas.php';

use Interop\Polite\Math\Matrix\NDArray;
use Rindow\Math\Matrix\FFIBuffer;
use Rindow\Math\Matrix\FFIOpenBlas;

$blas = new FFIOpenBlas();
$buf = new FFIBuffer(10, NDArray::float32);

for($i=0;$i<10;$i++) {
    $buf[$i] = $i;
}
$blas->scal(10,2.0,$buf,0,1);
for($i=0;$i<10;$i++) {
    var_dump($buf[$i]);
}

var_dump(isset($buf[11]));
var_dump($blas->getNumThreads());
var_dump($blas->getNumProcs());
var_dump($blas->getConfig());
var_dump($blas->getCorename());
var_dump($blas->getParallel());

$data = $buf->dump();
echo "dumped..\n";
$array = unpack('f*', $data);
var_dump($array);
$data = pack('f*',...$array);

$buf2 = new FFIBuffer(10, NDArray::float32);
$buf2->load($data);
echo "loaded..\n";
for($i=0;$i<count($buf2);$i++) {
    var_dump($buf2[$i]);
}
