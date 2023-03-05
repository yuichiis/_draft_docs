<?php
use Interop\Polite\Math\Matrix\NDArray;

function new_array($obf,array $array, int $dtype)
{
    $size = count($array);
    if(is_array($array[0])) {
        $size = $size * count($array[0]);
    }
    $buf = $obf->Buffer($size, $dtype);
    foreach ($array as $row => $v) {
        if(!is_array($v)) {
            $buf[$row] = $v;
        } else {
            $cols = count($v);
            foreach ($v as $col => $vv) {
                $buf[$row*$cols+$col] = $vv;
            }
        }
    }
    return $buf;
}

function new_zeros($obf,array $shape, int $dtype)
{
    $size = array_product($shape);
    $buf = $obf->Buffer($size, $dtype);
    for($i=0;$i<$size;$i++) {
        $buf[$i] = 0;
    }
    return $buf;
}

function print_array($obf, object $buf, int $m, int $n)
{
    for($i=0;$i<$m;$i++) {
        for($j=0;$j<$n;$j++) {
            echo sprintf("%+5.5f, ",$buf[$i*$n+$j]);
        }
        echo "\n";
    }
    return $buf;
}