---
layout: document
title: "Optimizers"
upper_section: references
previous_section: losses
next_section: datasets
---
Overview
-------

- **namespace**: Rindow\NeuralNetworks\Builder
- **classname**: Optimizers

Create new optimizer instances.

Create an instance of each optimizer by calling method with the same name as the class name of the optimizer.
Refer to the constructor of each optimizer for details.

Optimizers
----------

- [**Adam**](adam.html): Adam optimization.
- [**SGD**](sgd.html): Stochastic gradient descent and momentum optimizer.

Examples
--------

```php
use Rindow\NeuralNetworks\Builder\NeuralNetworks;
$nn = new NeuralNetworks($mo);
$model->compile([
    'optimizer'=>$nn->optimizers()->SGD(['lr'=>0.01]),
]);
```
