<?php

if(PHP_OS=='Linux') {
    $lib = "libtestdll.so";
} elseif(PHP_OS=='WINNT') {
    $lib = "testdll.dll";
}
$ffi = FFI::cdef("
uint64_t testdll(int * x);
int* returnpointer(int * x);
int64_t get_server_var();
void set_server_var(int64_t val);
", $lib);

echo "sizeof(int)="; var_dump(FFI::sizeof(FFI::new("int")));
echo "sizeof(long)="; var_dump(FFI::sizeof(FFI::new("long")));
echo "sizeof(long long)="; var_dump(FFI::sizeof(FFI::new("long long")));
echo "sizeof(size_t)="; var_dump(FFI::sizeof(FFI::new("size_t")));
echo "sizeof(int32_t)="; var_dump(FFI::sizeof(FFI::new("int32_t")));
echo "sizeof(int64_t)="; var_dump(FFI::sizeof(FFI::new("int64_t")));

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

while(true) {
    $var = $ffi->get_server_var();
    echo "get_server_var=";
    var_dump($var);
    echo "wait>";
    $s = fgets(STDIN);
    if(trim($s)=="exit") {
        break;
    }
    $var++;
    echo "set_server_var($var)\n";
    $ffi->set_server_var($var);
}
