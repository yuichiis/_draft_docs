Builders
========
The instance of each PHP class is created using builder. This is to allow replacement as a module.
When you use it on Rindow framework in the future, you can incorporate it into "Inversion of Control".

The builder is divided into seven parts.

- NeuralNetworks: The root of the builder. From here we also generate other builders.
- Models: Create a new model or generate a model instance from a saved model.
- Layers: Create a layer. You can generate connection nodes and activation functions as layers and add them to the model.
- Losses: Create a loss function for your model usage.
- Optimizers: Create an optimizer according to the nature of the model.
- Datasets: Create a dataset that downloads sample data and makes it available in the library.
- Utils: Create various utilitiy instances.


Root Builder
------------
First, create it using the "new" operator of the root Builder. At this time, give Rindow's MatrixOperator. After this, it can be shared with MatrixOperator which operates NDArray type data. If not given, create a new own MatrixOperator internally.

```PHP
use Rindow\Math\Matrix\MatrixOperator;
use Rindow\NeuralNetworks\Builder\NeuralNetworks;

$mo = new MatrixOperator();
$nn = new NeuralNetworks($mo);
```


Subclass Builders
-----------------
Get a subclass builder from the root builder.
The subclass builder is created in a singleton,
so no matter how many times you call it, only one instance is created.

Each builder can specify constructors arguments when instantiating the target.

```PHP
$dense   = $nn->layers()->Dense(128,['input_shape'=>[10]]);
$softmax = $nn->layers()->Softmax();
$bce     = $nn->losses()->BinaryCrossEntropy();
$adam    = $nn->optimizers()->Adam(['lr'=>0.001,'beta1'=> 0.9,'beta2'=>0.999]);
$model   = $nn->models()->Sequential([$dense,$softmax]);
$mnist   = $nn->datasets()->mnist();
```