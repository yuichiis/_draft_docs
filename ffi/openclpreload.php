<?php
declare(strict_types=1);

//$ffi = FFI::load(__DIR__ . "/opencl_win.h");
$ffi = FFI::load(__DIR__ . "/openclffi.i");

//$ffi_null = FFI::new("size_t *");
//$ffi_null->cdata = 0;
$numPlatforms = $ffi->new("unsigned int[1]");

$errcode_ret = $ffi->clGetPlatformIDs(0, null, $numPlatforms);
var_dump($errcode_ret);
var_dump($numPlatforms[0]);
$num = $numPlatforms[0];
$ids = $ffi->new("cl_platform_id[$num]");

$errcode_ret = $ffi->clGetPlatformIDs($num, $ids, $numPlatforms);
var_dump($errcode_ret);
var_dump($numPlatforms[0]);
