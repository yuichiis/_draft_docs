Losses
======
Overview
-------

- namespace: Rindow\NeuralNetworks\Builder
- classname: Losses

Create new loss function instances.

Create an instance of each loss function by calling method with the same name as the class name of the loss function.
Refer to the constructor of each loss function for details.

Examples
--------

```PHP
use Rindow\NeuralNetworks\Builder\NeuralNetworks;
$nn = new NeuralNetworks($mo);
$model->compile([
    'loss'=>$nn->losses()->MeanSquaredError(),
]);
```
