<?php
include __DIR__.'/../rindow-neuralnetworks/vendor/autoload.php';

$mo = new Rindow\Math\Matrix\MatrixOperator();

$lacpu = $mo->la();
$lacl = $mo->laAccelerated('clblast');
$lacl->blocking(true);

$times = [];
foreach([$lacpu,$lacl] as $la) {
    $a = $la->fill(2.0,$la->alloc([1000,1000]));
    $b = $la->fill(3.0,$la->alloc([1000,1000]));
    
    echo "build gemm\n";
    $z = $la->gemm($a,$b);
    echo "start gemm\n";
    $start = hrtime(true);
    $z = $la->gemm($a,$b);
    $time = hrtime(true)-$start;
    $times[] = $time;
    echo $time."\n";
}

foreach([$lacpu,$lacl] as $la) {
    $a = $la->fill(2.0,$la->alloc([1000,1000]));
    
    echo "build sum\n";
    $z = $la->sum($a);
    echo "start sum\n";
    $start = hrtime(true);
    $z = $la->sum($a);
    $time = hrtime(true)-$start;
    $times[] = $time;
    echo $time."\n";
}

foreach([$lacpu,$lacl] as $la) {
    $a = $la->fill(2.0,$la->alloc([64,64,64,3]));
    
    echo "build im2col2d\n";
    $z = $la->im2col($a);
    echo "start im2col2d\n";
    $start = hrtime(true);
    $z = $la->im2col($a);
    $time = hrtime(true)-$start;
    $times[] = $time;
    echo $time."\n";
}

echo "gemm cpu=".$times[0]."\n";
echo "gemm gpu=".$times[1]."\n";
echo "sum cpu=".$times[2]."\n";
echo "sum gpu=".$times[3]."\n";
echo "im2col2d cpu=".$times[4]."\n";
echo "im2col2d gpu=".$times[5]."\n";

// linux-mesa-clc on AMD
// gemm cpu=336814360
// gemm gpu=433350690
// sum cpu=3248213
// sum gpu=2923017
// im2col2d cpu=251985661
// im2col2d gpu=133678056

// windows10 windows-standard-driver on AMD
// gemm cpu=326405300
// gemm gpu=105720300
// sum cpu=3767300
// sum gpu=3279800
// im2col2d cpu=184174000
// im2col2d gpu=51568600

