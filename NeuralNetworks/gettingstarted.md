Getting started
===============

Getting started with the Sequential model
-----------------------------------------

The Sequential model is a linear stack of layers.

You can create a Sequential model by passing a list of layer instances with the Builder:

```PHP
$mo = new Rindow\Math\Matrix\MatrixOperator();
$nn = new Rindow\NeuralNetworks\Builder\NeuralNetworks($mo);

$model = $nn->models()->Sequential([
    $nn->layers()->Dense(128,['input_shape'=>[784]]),
    $nn->layers()->Sigmoid(),
    $nn->layers()->Dense(10),
    $nn->layers()->Softmax(),
]);
```

You can also simply add layers via the .add() method:

```PHP
$model = $nn->models()->Sequential();
$model->add($nn->layers()->Dense(128,['input_shape'=>[784]]));
$model->add($nn->layers()->Sigmoid());
```

Specifying the input shape
--------------------------
The model needs to know what input shape it should expect.
For this reason, the first layer in a Sequential model (and only the first, because following layers can do automatic shape inference) needs to receive information about its input shape.

To do this, use the "input_shape" option.
Pass an input_shape argument to the first layer. This is a shape array of integers. In input_shape, the batch dimension is not included.

As such, the following snippets are strictly equivalent:

```PHP
$model = $nn->models()->Sequential();
$model->add($nn->layers()->Dense(128,['input_shape'=>[784]]));
```

Compilation
-----------
