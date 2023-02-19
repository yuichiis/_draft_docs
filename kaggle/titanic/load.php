<?php
$filename = 'train.csv';

$f = fopen($filename,'r');
$head = 5;
while ($data=fgetcsv($f)) {
    if($head<0)
        break;
    var_dump($data);
    $head--;
}
fclose($f);
