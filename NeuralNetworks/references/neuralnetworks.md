NeuralNetworks
==============
Overview
-------

- namespace: Rindow\NeuralNetworks\Builder
- classname: NeuralNetworks

The instance of each PHP class is created using builders.
This builder is the root builder and creates other subclass builders.

Methods
-------

### constructor

```PHP
public function __construct(
    $matrixOperator=null,
    $backend=null
)
```
For $matrixOperator, specify the instance of the data operation module to be used.
If omitted, it will be created inside Rindow\Math\Matrix\MatrixOperator.

For $backend, specify the backend instance to be used.
If omitted, Rindow\NeuralNetworks\Backend\RindowBlas\Backend will be created internally.


### models
```PHP
public function models()
return $models
```
Get models subclass builder Rindow\NeuralNetworks\Builder\Models.
The builder is a singleton.

### layers
```PHP
public function layers()
return $layers
```
Get layers subclass builder Rindow\NeuralNetworks\Builder\Layers.
The builder is a singleton.

### losses
```PHP
public function losses()
return $layers
```
Get losses subclass builder Rindow\NeuralNetworks\Builder\Losses.
The builder is a singleton.

### optimizers
```PHP
public function optimizers()
return $optimizers
```
Get optimizers subclass builder Rindow\NeuralNetworks\Builder\Optimizers.
The builder is a singleton.

### datasets
```PHP
public function datasets()
return $datasets
```
Get datasets subclass builder Rindow\NeuralNetworks\Builder\Datasets.
The builder is a singleton.

### utils
```PHP
public function utils()
return $utils
```
Get utils subclass builder Rindow\NeuralNetworks\Builder\Utils.
The builder is a singleton.


Example
-------

```PHP
use Rindow\Math\Matrix\MatrixOperator;
use Rindow\NeuralNetworks\Builder\NeuralNetworks;

$mo = new MatrixOperator();
$nn = new NeuralNetworks($mo);
$model = $nn->models()->Sequential([
    $dense   = $nn->layers()->Dense(128,['input_shape'=>[10]]);
    $softmax = $nn->layers()->Sigmoid();
    $dense   = $nn->layers()->Dense(1);
    $softmax = $nn->layers()->Sigmoid();
]);
```