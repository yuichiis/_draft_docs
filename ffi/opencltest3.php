<?php
$loader = include __DIR__.'/autoload.php';
$loader->addPsr4('Rindow\\OpenCL2\\', __DIR__.'/OpenCL');

use Rindow\OpenCL2\OpenCLFactory;
use Rindow\OpenCL2\Program;
use Interop\Polite\Math\Matrix\OpenCL;

$ocl = new OpenCLFactory();
$platforms = $ocl->PlatformList();
$devices = $ocl->DeviceList($platforms,device_type:OpenCL::CL_DEVICE_TYPE_GPU);
$context = $ocl->Context($devices);

echo "CommandQueue:\n";
$queue = $ocl->CommandQueue($context);
$queue->flush();

echo "clCreateProgramWithSource:\n";
$src = "
__kernel float test(float a, float b)
{
    return a+b;
}
__kernel float test2(float a, float b)
{
    return a+b;
}
";
$program = $ocl->Program($context,$src,Program::TYPE_SOURCE_CODE);

echo "build:\n";
$program->build();
echo "getInfo:\n";
echo "CL_PROGRAM_REFERENCE_COUNT: "; var_dump($program->getInfo(OpenCL::CL_PROGRAM_REFERENCE_COUNT));
#ifdef CL_VERSION_1_2
echo "CL_PROGRAM_NUM_KERNELS: "; var_dump($program->getInfo(OpenCL::CL_PROGRAM_NUM_KERNELS));
echo "CL_PROGRAM_KERNEL_NAMES: "; var_dump($program->getInfo(OpenCL::CL_PROGRAM_KERNEL_NAMES));
#endif
echo "CL_PROGRAM_NUM_DEVICES: "; var_dump($program->getInfo(OpenCL::CL_PROGRAM_NUM_DEVICES));
$progdevs = $program->getInfo(OpenCL::CL_PROGRAM_DEVICES);
for($i=0;$i<count($progdevs);$i++) {
    echo "CL_PROGRAM_DEVICES($i): "; var_dump($progdevs->getInfo($i,OpenCL::CL_DEVICE_NAME));
}
echo "CL_PROGRAM_SOURCE: "; var_dump($program->getInfo(OpenCL::CL_PROGRAM_SOURCE));
echo "CL_PROGRAM_BINARY_SIZES: [".implode(',',$program->getInfo(OpenCL::CL_PROGRAM_BINARY_SIZES))."]\n";
echo "getBuildInfo:\n";
echo "CL_PROGRAM_BUILD_STATUS: "; var_dump($program->getBuildInfo(OpenCL::CL_PROGRAM_BUILD_STATUS));
echo "CL_PROGRAM_BINARY_TYPE: "; var_dump($program->getBuildInfo(OpenCL::CL_PROGRAM_BINARY_TYPE));
echo "CL_PROGRAM_BUILD_OPTIONS: "; var_dump($program->getBuildInfo(OpenCL::CL_PROGRAM_BUILD_OPTIONS));
echo "CL_PROGRAM_BUILD_LOG: "; var_dump($program->getBuildInfo(OpenCL::CL_PROGRAM_BUILD_LOG));

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
    echo $e->getMessage()."\n";
    switch($e->getCode()) {
        case OpenCL::CL_BUILD_PROGRAM_FAILURE: {
            echo "CL_PROGRAM_BUILD_STATUS=".$program->getBuildInfo(OpenCL::CL_PROGRAM_BUILD_STATUS)."\n";
            echo "CL_PROGRAM_BUILD_OPTIONS=".safestring($program->getBuildInfo(OpenCL::CL_PROGRAM_BUILD_OPTIONS))."\n";
            echo "CL_PROGRAM_BUILD_LOG=".safestring($program->getBuildInfo(OpenCL::CL_PROGRAM_BUILD_LOG))."\n";
            echo "CL_PROGRAM_BINARY_TYPE=".safestring($program->getBuildInfo(OpenCL::CL_PROGRAM_BINARY_TYPE))."\n";
            break;
        }
        case OpenCL::CL_COMPILE_PROGRAM_FAILURE: {
            echo "CL_PROGRAM_BUILD_LOG=".safestring($program->getBuildInfo(OpenCL::CL_PROGRAM_BUILD_LOG))."\n";
            break;
        }
        default:{
            echo "UNKOWN ERROR=".$e->getCode()."\n";
            break;
        }
    }
}

$src = "
__kernel float test(float a, float b)
{
    compile error;
}
";
$program = $ocl->Program($context,$src,Program::TYPE_SOURCE_CODE);

echo "build error:\n";
try {
    $program->build();
} catch(\Exception $e) {
    compile_error($program,$e);
}

echo "\n";

