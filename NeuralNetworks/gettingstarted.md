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
Before training a model, you need to configure the learning process, which is done via the compile method. It receives three options:

- An optimizer. This could be an instance of the Optimizer. The default is "SGD". see Optimizers
- An loss function. This is the objective that the model will try to minimize. It can be an instance of loss function. The default is "SparseCategoricalCrossEntropy". See Losses.
- A list of metrics. Specify a list of strings of items to be written to the history of training. Currently, only "accuracy" and "loss" can be specified.

```PHP
# For Adam,MeanSquaredError
$model->compile([
    'optimizer'=>$nn->optimizers()->Adam(),
    'loss'=>$nn->Losses()->MeanSquaredError(),
    'metrics'=>['accuracy','loss'],
]);
# For Defaults: SparseCategoricalCrossEntropy, SGD
$model->compile();
```

Training
--------
Keras models are trained on Numpy arrays of input data and labels. For training a model, you will typically use the fit function.

```PHP
# For 10 class categorical classification model
$model = $nn->models()->Sequential([
    $nn->layers()->Dense(128,
        ['input_shape'=>[100],'kernel_initializer'=>'relu_normal']),
    $nn->layers()->Relu(),
    $nn->layers()->Dense(10),
    $nn->layers()->Sigmoid(),
]);
$model->compile([
    'optimizer'=>$nn->optimizers()->Adam(),
    #'loss'=> 'SparseCategoricalCrossEntropy'  <==== default
    'metrics'=>['accuracy'],
]);
# Dummy data
$data = $mo->random()->rand([1000, 100]);
$labels = $mo->random()->choice(10,1000);
# Train the model
$model->fit($train_img,$train_label,[
        'epochs'=10,'batch_size'=>32,
]);
```
