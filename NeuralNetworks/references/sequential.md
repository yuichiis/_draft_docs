Sequential
==========

- **namespace**: Rindow\NeuralNetworks\Builder
- **classname**: Sequential

The Sequential model is a linear stack of layers.

Methods
-------

### constructor
```PHP
$builer->Sequential(
    array<Layer> $layers=null
)
return $model
```
You can create a Sequential model by passing a list of layer instances with the Builder.

- **layers**: a list of layer instances.


Examples

```PHP
$model = $nn->models()->Sequential([
    $dense   = $nn->layers()->Dense(128,['input_shape'=>[10]]);
    $softmax = $nn->layers()->Sigmoid();
    $dense   = $nn->layers()->Dense(1);
    $softmax = $nn->layers()->Sigmoid();
]);
```

### add
```PHP
public function add(
    Layer $layer
) : void
```
You can simply add layers via the add() method:

- **layer**: layer instance.

Examples

```PHP
$model = $nn->models()->Sequential();
$model->add($nn->layers()->Dense(128,['input_shape'=>[784]]));
$model->add($nn->layers()->Sigmoid());
```


### compile
```PHP
public function compile(
    array $options=[
        'optimizer'=>'SGD',
        'loss'=>'SparseCategoricalCrossEntropy',
        'metrics'=>array<string> $metrics=['loss','accuracy'],
    ]=null
) : void
```
Compile a model to configure the learning process.
Several options can be specified.

- **optimizer**:
    - Specify the optimizer instance.
    - Default is the SGD.
- **loss**:
    - Specify an instance of the loss function.
    - Default is the SparseCategoricalCrossEntropy.
- **metrics**:
    - Specify the type of metrics in the list.
    - The default is ['loss', 'accuracy'].

Examples


```PHP
# For Adam,MeanSquaredError
$model->compile([
    'optimizer'=>$nn->optimizers()->Adam(),
    'loss'=>$nn->losses()->MeanSquaredError(),
    'metrics'=>['accuracy','loss'],
]);
```
```PHP
# For Defaults: SparseCategoricalCrossEntropy, SGD
$model->compile();
```


### fit
```PHP
$history = $model->fit(
        NDArray $inputs,
        NDArray $tests,
        array $options=[
            'batch_size'=>32,
            'epochs'=>1,
            'verbose'=>1,
            'validation_data'=>array<NDArray>$val_data=null,
            'shuffle'=>true,
        ]=null
) : array
return array $history
```
The models are trained on the NDArray of input data and labels.
For training a model, you will typically use the fit method.

- **inputs**: Input data in most cases.
    - Normally, the input data is in the form of batch data.
    - NDArray datasets.
- **tests**: Test target data in most cases.
    - The test data is arranged in the order corresponding to the input data.
    - NDArray datasets.

Several options can be specified.

- **batch_size**: Batch size
    - Number of samples per paramator values update.
    - Default is 32.
- **epochs**: Specify an instance of the loss function.
    - How many times to train the model repeatedly
    - Default is 1.
- **verbose**: Verbosity mode.
    - 0 = silent, 1 or greater = progress bar and metrics per epoch.
    - The default is 1.
- **validation_data**: evaluate data set.
    - Data on which to evaluate the loss and any model metrics at the end of each epoch.
    - List [inputs_val, tests_val] of NDArray
    - The default is Null. Mean not to evaluate
- **shuffle**: Shuffle mode.
    - Boolean whether to shuffle the training data before each epoch
    - The default is true.

Examples

```PHP
# Train the model
$history = $model->fit($data,$labels,[
        'epochs'=>10,'batch_size'=>8,'verbose'=>1,
        'validation_data'=>[$inputs_val, $tests_val],
        'shuffle'=>true,
]);
```

### evaluate
```PHP
public function evaluate(
    NDArray $inputs,
    NDArray $tests,
    array $options=[
        'batch_size'=>32,
        'verbose'=>0,
    ]=null
) : array<float>
return [$loss,$accuracy]
```
Returns the loss value & metrics values for the model in test mode.

The models evaluate on the NDArray of input data and tests.

- **inputs**: Input data in most cases.
    - Normally, the input data is in the form of batch data.
    - NDArray datasets.
- **tests**: Test target data in most cases.
    - The test data is arranged in the order corresponding to the input data.
    - NDArray datasets.

Several options can be specified.

- **batch_size**: Batch size
    - Number of samples per paramator values update.
    - Default is 32.
- **verbose**: Verbosity mode.
    - 0 = silent, 1 or greater = progress bar and metrics per epoch.
    - The default is 0.

Returns

- **loss**: test loss
- **accuracy**: test accuracy


### predict
```PHP
public function predict(
    NDArray $inputs
) : NDArray
return $predictions
```
Returns predictions for sample data.

The models predict on the NDArray of input data.

- **inputs**: Input data in most cases.
    - Normally, the input data is in the form of batch data.
    - NDArray datasets.

Returns

- **predictions**: test accuracy
    - The prediction data is arranged in the order corresponding to the input data.
    - NDArray datasets.


### toJson
```PHP
public function toJson() : string
return $json
```
Returns a JSON string containing the model configuration.
To load a model from a JSON save file, extract to array
and use the "modelFromConfig" method of the models builder.

Model configuration does not include weight information.

- **json**: JSON string

### saveWeights
```PHP
public function saveWeights(
    &$modelWeights,
    $portable=false
) : void
```
Saves all layer weights.

- **modelWeights**: model weights container
    - Specify the save destination objecct or array.
- **portable**: Save mode.
    - **true**: Save in a hardware-independent format. However, the conversion takes time and the weight information has an error due to the conversion.
    - **false**:Save in a hardware-dependent format. You can save at high speed.

### loadWeights
```PHP
public function loadWeights(
    $modelWeights
) : void
```
Load the weight information saved by saveWeights into the model.

- **modelWeights**: model weights container

### save
```PHP
public function save(
    $filepath,
    $portable=null) : void
```
Saves the model configure and weight information to file.
To load a model from a saved file, use the "loadModel" method of the models builder.

- **filepath**: file name
    - Specify the save destination file name.
- **portable**: Save mode.
    - **true**: Save in a hardware-independent format. However, the conversion takes time and the weight information has an error due to the conversion.
    - **false**:Save in a hardware-dependent format. You can save at high speed.
