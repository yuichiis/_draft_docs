<?php
// main.php
require_once dirname(__FILE__) . '/lib.php';
 
use parallel\{Future, Runtime};
 
$width = 300 * 4;
$height = 300 * 4;
$bounds = [$width, $height];
 
$lower_left = new Complex(-0.5877, 0.4527);
$upper_right = new Complex(-0.4597, 0.5807);

echo "start \n";
$start_time = microtime(true);
 
$pixels = calcMandelbrot($bounds, $width, $height, $lower_left, $upper_right);
 
$end_time = microtime(true);
echo ($end_time - $start_time) . " sec.\n";
 
saveToFile($pixels, $width, $height, 'mandelbrot.png');
