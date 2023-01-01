<?php
// lib.php
class Complex
{
    public float $re;
    public float $im;
 
    function __construct(float $re, float $im)
    {
        $this->re = $re;
        $this->im = $im;
    }
 
    public function add(Complex $other): Complex
    {
        return new Complex($this->re + $other->re, $this->im + $other->im);
    }
 
    public function mul(Complex $other): Complex
    {
        return new Complex(
            $this->re * $other->re - $this->im * $other->im,
            $this->re * $other->im + $this->im * $other->re
        );
    }
 
    public function squareNorm()
    {
        return $this->re * $this->re + $this->im * $this->im;
    }
 
    public function __toString()
    {
        return '(' . $this->re . ' x ' . $this->im . ')';
    }
}
 
//function calcDiverge(Complex $c): int
//{
//    $z = new Complex(0, 0);
//    for ($i = 0; $i < 255; $i++) {
//        if ($z->squareNorm() > 4) return $i;
// 
//        $z = $z->mul($z)->add($c);
//    }
//    return 255;
//}
 
function convertPoint(array $bounds, array $pixel, Complex $lower_left, Complex $upper_right): Complex
{
    $complex_width = $upper_right->re - $lower_left->re;
    $complex_height = $upper_right->im - $lower_left->im;
    return new Complex(
        $lower_left->re + $complex_width * ($pixel[0] / $bounds[0]),
        $lower_left->im + $complex_height * ($pixel[1] / $bounds[1]),
    );
}
 
function saveToFile(array $pixels, int $width, int $height, string $filename)
{
    $im = imagecreatetruecolor($width, $height);
 
    $colors = [];
    for ($i = 0; $i <= 255; $i++) {
        $colors[$i] = imagecolorallocate($im, $i, $i, $i);
    }
 
    for ($y = 0; $y < $height; $y++) {
        for ($x = 0; $x < $width; $x++) {
            $diverge_count = $pixels[$x + $y * $width];
            $color = $colors[255 - $diverge_count];
            imagesetpixel($im, $x, $height - $y - 1, $color);
        }
    }
 
    imagepng($im, $filename);
}
 
//function calcMandelbrot(array $bounds, int $width, int $height, Complex $lower_left, Complex $upper_right): array
//{
//    $pixels = [];
//    for ($y = 0; $y < $height; $y++) {
//        for ($x = 0; $x < $width; $x++) {
//            $c = convertPoint($bounds, [$x, $y], $lower_left, $upper_right);
//            $pixels[$x + $y * $width] = calcDiverge($c);
//        }
//    }
//    return $pixels;
//}

///// Ver.2

function calcDiverge(float $c_re, float $c_im): int
{
    $z_re = $z_im = 0;
    for ($i = 0; $i < 255; $i++) {
        $square_norm = $z_re * $z_re + $z_im * $z_im;
        if ($square_norm > 4) return $i;
 
        $next_re = $z_re * $z_re - $z_im * $z_im + $c_re;
        $next_im = $z_re * $z_im + $z_im * $z_re + $c_im;
 
        $z_re = $next_re;
        $z_im = $next_im;
    }
    return 255;
}
 
 
function calcMandelbrot(array $bounds, int $width, int $height, Complex $lower_left, Complex $upper_right): array
{
    $pixels = [];
    for ($y = 0; $y < $height; $y++) {
        for ($x = 0; $x < $width; $x++) {
            $c = convertPoint($bounds, [$x, $y], $lower_left, $upper_right);
            $pixels[$x + $y * $width] = calcDiverge($c->re, $c->im);
        }
    }
    return $pixels;
}
