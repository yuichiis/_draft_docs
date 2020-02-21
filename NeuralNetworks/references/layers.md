Layers
======
Overview
-------

- namespace: Rindow\NeuralNetworks\Builder
- classname: Layers

Create new layer instances.

Create an instance of each layer by calling method with the same name as the class name of the layer.
Refer to the constructor of each layer for details.

Examples
--------

```PHP
use Rindow\Math\Matrix\MatrixOperator;
use Rindow\NeuralNetworks\Builder\NeuralNetworks;

$mo = new MatrixOperator();
$nn = new NeuralNetworks($mo);
$model = $nn->models()->Sequential([
    $nn->layers()->Dense(128,['input_shape'=>[10]]);
    $nn->layers()->Sigmoid();
    $nn->layers()->Dense(1);
    $nn->layers()->Sigmoid();
]);
```
