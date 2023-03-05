<?php

$ffi = FFI::cdef("
uint64_t testdll(int * x);
int* returnpointer(int * x);
", "testdll.dll");

$x = $ffi->new("int[2]");
$xx = $ffi->new("int*");
var_dump($x);
$x[0] = 1;
$x[1] = 2;
$y = $ffi->testdll($x);
echo "y="; var_dump($y);
$z = $ffi->returnpointer($x);
echo "z="; var_dump($z);

echo "size z=" ; var_dump(FFI::sizeof($z));

$zz = $ffi->returnpointer($z);
echo "zz[0]="; var_dump($zz[0]);
echo "zz[1]="; var_dump($zz[1]);
$x[0] = 3;
$x[1] = 4;
echo "zz[0]="; var_dump($zz[0]);
echo "zz[1]="; var_dump($zz[1]);
