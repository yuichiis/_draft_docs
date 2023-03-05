<?php
$loader = require __DIR__.'/../../rindow-math-matrix/vendor/autoload.php';
$loader->addPsr4("Rindow\\Math\\Plot\\", __DIR__."/../../rindow-math-plot/src/");
$loader->addPsr4("Rindow\\NeuralNetworks\\", __DIR__."/../../rindow-neuralnetworks/src/");
$loader->addPsr4("Rindow\\ReinforcementLearning\\", __DIR__."/../../rindow-reinforcementlearning/src/");

return $loader;
