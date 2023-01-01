<?php

$fiber = new Fiber(function (): string {
    $value = Fiber::suspend('fiber1');
    echo 'redume $value1: ', $value, "\n";
    $value = Fiber::suspend('fiber2');
    echo 'redume $value2: ', $value, "\n";
    return 'finish';
});

$value = $fiber->start();

echo 'suspend $value: ', $value, "\n";
echo 'isTerminated';
var_dump($fiber->isTerminated());

$value = $fiber->resume('test1');
echo 'resume return $value1: ', $value, "\n";
echo 'isTerminated';
var_dump($fiber->isTerminated());

$value = $fiber->resume('test2');
echo 'resume return $value2: ', $value, "\n";
echo 'isTerminated';
var_dump($fiber->isTerminated());

$return = $fiber->getReturn();
echo 'getReturn $return: ', $return, "\n";
echo 'isTerminated';
var_dump($fiber->isTerminated());
