<?php
$loader = include __DIR__.'/../autoload.php';

$loader->addPsr4('Rindow\\OpenCL2\\', __DIR__.'/../OpenCL');
include __DIR__.'/../OpenBLAS/Buffer.php';

use Rindow\OpenCL2\OpenCLFactory;
use Interop\Polite\Math\Matrix\OpenCL;
use Interop\Polite\Math\Matrix\NDArray;

use Rindow\OpenBLAS2\Buffer as HostBuffer;

$ocl = new OpenCLFactory();

#
# construct by default
#
$platforms = $ocl->PlatformList();
#echo "count=".$platforms->count()."\n";
assert($platforms->count()>=0);
echo "SUCCESS construct by default\n";
#
# getone
#
$num = $platforms->count();
$one = $platforms->getOne(0);
assert($one->count()==1);
#echo "CL_PLATFORM_NAME=".$one->getInfo(0,OpenCL::CL_PLATFORM_NAME)."\n";
echo "SUCCESS getOne\n";
#
# get info
#
$n = $platforms->count();
assert(null!=$platforms->getInfo(0,OpenCL::CL_PLATFORM_NAME));
echo "SUCCESS info\n";
for($i=0;$i<$n;$i++) {
    assert(null!=$platforms->getInfo($i,OpenCL::CL_PLATFORM_NAME));
    echo "platform(".$i.")\n";
    echo "    CL_PLATFORM_NAME=".$platforms->getInfo($i,OpenCL::CL_PLATFORM_NAME)."\n";
    echo "    CL_PLATFORM_PROFILE=".$platforms->getInfo($i,OpenCL::CL_PLATFORM_PROFILE)."\n";
    echo "    CL_PLATFORM_VERSION=".$platforms->getInfo($i,OpenCL::CL_PLATFORM_VERSION)."\n";
    echo "    CL_PLATFORM_VENDOR=".$platforms->getInfo($i,OpenCL::CL_PLATFORM_VENDOR)."\n";
    echo "    CL_PLATFORM_EXTENSIONS=".$platforms->getInfo($i,OpenCL::CL_PLATFORM_EXTENSIONS)."\n";
}
echo "SUCCESS";
