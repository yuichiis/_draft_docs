Datasets
========
Overview
-------

- namespace: Rindow\NeuralNetworks\Builder
- classname: Datasets

Create an instance of each dataset by calling method with the same name as the class name of the datasets.
Please refer to each dataset for usage.

Datasets
--------

- [**mnist**](minist.html): MNIST handwritten digits dataset.


Examples
--------

```PHP
use Rindow\NeuralNetworks\Builder\NeuralNetworks;
$nn = new NeuralNetworks($mo);
$mnist = $nn->datasets()->mnist(),
```
