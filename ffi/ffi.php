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
$a = 'abc';
$b = array('a','b','c');
$j = 1;
//var_dump($a{$j});
var_dump($b{$j});

//var_dump(phpversion('rindow_openblas'));
