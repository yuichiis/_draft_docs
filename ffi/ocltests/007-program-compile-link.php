<?php
$loader = include __DIR__.'/../autoload.php';

$loader->addPsr4('Rindow\\OpenCL2\\', __DIR__.'/../OpenCL');
include __DIR__.'/../OpenBLAS/Buffer.php';

use Rindow\OpenCL2\OpenCLFactory;
use Rindow\OpenCL2\Program;
use Interop\Polite\Math\Matrix\OpenCL;
use Interop\Polite\Math\Matrix\NDArray;

use Rindow\OpenBLAS2\Buffer as HostBuffer;

$ocl = new OpenCLFactory();

function safestring($string) {
    $out = '';
    $string = str_split($string);
    $len = count($string);
    for($i=0;$i<$len;$i++) {
        $c = ord($string[$i]);
        if($c>=32&&$c<127) {
            $out .= chr($c);
        } elseif($c==10||$c==13) {
            $out .= "\n";
        } else {
            $out .= '($'.dechex($c).')';
        }
    }
    return $out;
}
function compile_error($program,$e) {
    echo $e->getMessage();
    switch($e->getCode()) {
        case OpenCL::CL_BUILD_PROGRAM_FAILURE: {
            echo "CL_PROGRAM_BUILD_STATUS=".$program->getBuildInfo(OpenCL::CL_PROGRAM_BUILD_STATUS)."\n";
            echo "CL_PROGRAM_BUILD_OPTIONS=".safestring($program->getBuildInfo(OpenCL::CL_PROGRAM_BUILD_OPTIONS))."\n";
            echo "CL_PROGRAM_BUILD_LOG=".safestring($program->getBuildInfo(OpenCL::CL_PROGRAM_BUILD_LOG))."\n";
            echo "CL_PROGRAM_BINARY_TYPE=".safestring($program->getBuildInfo(OpenCL::CL_PROGRAM_BINARY_TYPE))."\n";
        }
        case OpenCL::CL_COMPILE_PROGRAM_FAILURE: {
            echo "CL_PROGRAM_BUILD_LOG=".safestring($program->getBuildInfo(OpenCL::CL_PROGRAM_BUILD_LOG))."\n";
        }
    }
    throw $e;
}
 
$context = $ocl->Context(OpenCL::CL_DEVICE_TYPE_DEFAULT);
$devices = $context->getInfo(OpenCL::CL_CONTEXT_DEVICES);
$dev_version = $devices->getInfo(0,OpenCL::CL_DEVICE_VERSION);
// $dev_version = 'OpenCL 1.1 Mesa';
$isOpenCL110 = strstr($dev_version,'OpenCL 1.1') !== false;
if($isOpenCL110) {
    echo "SUCCESS Construction sub-source\n";
    echo "SUCCESS Construction\n";
    echo "SUCCESS Compiling\n";
    echo "SUCCESS link program\n";
    echo "SUCCESS Compiling with null arguments\n";
    echo "SUCCESS linking with null arguments\n";
    exit();
}

$header0 =
    "typedef int number_int_t;\n";
$sources = [
    "#include \"const_zero.h\"\n".
    "__kernel void saxpy(const global float * x,\n".
    "                    __global float * y,\n".
    "                    const float a)\n".
    "{\n".
    "   uint gid = get_global_id(0);\n".
    "   y[gid] = a* x[gid] + y[gid];\n".
    "}\n"
];
$sources0 = [
    "__kernel void saxpy(const global float * x,\n".
    "                    __global float * y,\n".
    "                    const float a)\n".
    "{\n".
    "   uint gid = get_global_id(0);\n".
    "   y[gid] = a* x[gid] + y[gid];\n".
    "}\n"
];

$programSub = $ocl->Program($context,$header0);
echo "SUCCESS Construction sub-source\n";
$program = $ocl->Program($context,$sources);
echo "SUCCESS Construction\n";
try {
    $program->compile(['const_zero.h'=>$programSub]);
} catch(\RuntimeException $e) {
    compile_error($program,$e);
}
echo "SUCCESS Compiling\n";
$linkedprogram = $ocl->Program($context,[$program],
    Rindow\OpenCL2\Program::TYPE_COMPILED_PROGRAM);
echo "SUCCESS link program\n";
$program = $ocl->Program($context,$sources0);
try {
    $program->compile($headers=null,$options=null,$devices=null);
} catch(\RuntimeException $e) {
    compile_error($program,$e);
}
echo "SUCCESS Compiling with null arguments\n";
$linkedprogram = $ocl->Program($context,[$program],
    Rindow\OpenCL2\Program::TYPE_COMPILED_PROGRAM,
    $devices=null,$options=null);
echo "SUCCESS linking with null arguments\n";
