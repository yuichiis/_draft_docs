<?php
$loader = include __DIR__.'/autoload.php';
use FFI\Env\Runtime;
use FFI\Env\Status;
use FFI\Location\Locator;

$isAvailable = Runtime::isAvailable();
var_dump($isAvailable);

$lib = 'OpenCL.DLL';
//$lib = 'libOpenCL.so';
$exists = Locator::exists($lib);
echo "exists:"; var_dump($exists);
$pathname = Locator::pathname($lib);
echo "pathname:"; var_dump($pathname);
$pathname = Locator::resolve($lib, 'test.so', 'libvulkan.so');
echo "resolve:"; var_dump($pathname);
