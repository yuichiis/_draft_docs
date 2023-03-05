<?php
// create FFI object, loading libc and exporting function printf()
//$ffi = FFI::cdef(
//    "int printf(const char *format, ...);", // this is a regular C declaration
//    "libc.so.6");
// call C's printf()
//$ffi->printf("Hello %s!\n", "world");
//$ffi = FFI::cdef(
//    "void glBegin(int mode);",
//    "opengl32.dll");
//$filename = "C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.18362.0\\um\\GL\\gl.h";
//assert(file_exists($filename));
//$ffi = FFI::load($filename);
//$filename = 'opengl.h';
//assert(file_exists($filename));
//$ffi = FFI::load($filename);
//$ffi = FFI::scope('sdl');
//var_dump(ZEND_THREAD_SAFE);
//$a = 'abc';
//$b = array('a','b','c');
//$j = 1;
//var_dump($a{$j});
//var_dump($b[$j]);

//var_dump(phpversion('rindow_openblas'));

//$str = ["abc","def"];
//$objs = [];
//$a = FFI::new("char*[".count($str)."]");
//foreach($str as $i => $v) {
//    $len = strlen($v)+1;
//    $s = FFI::new("char[$len]");
//    FFI::memcpy($s,$v."\0",$len);
//    $objs[] = $s;
//    $a[$i] = FFI::cast("char*",FFI::addr($s));
//}
//var_dump($a);

$types = [
    'char','short','int','long','size_t',
    'int8_t','int32_t','int64_t',
    'float','double','long double',
];
foreach ($types as $type) {
    $bits = FFI::sizeof(FFI::type($type))*8;
    echo "$type: $bits\n";
}

$a = FFI::new("float[2]");
try {
    $a[-1] = 1.0;
} catch (\Throwable $th) {
    echo get_class($th).": ".$th->getMessage()."\n";
}

$ffi = FFI::cdef("enum tst { ea = 1, eb = 2, };");
$a = $ffi->new("enum tst[1]");
echo "enum size=".(FFI::sizeof($a))."\n";

var_dump(chr(0x21));
$a = FFI::new("char");
$a->cdata = chr(0x21);
var_dump($a);

