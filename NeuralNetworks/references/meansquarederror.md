MeanSquaredError
================

- **namespace**: Rindow\NeuralNetworks\Losses
- **classname**: MeanSquaredError

Mean Squared Error loss function.

Computes the mean of squares of errors between labels and predictions.

Methods
-------

### constructor
```PHP
$builer->MeanSquaredError()
```
You can create a MeanSquaredError loss function instances with the Losses Builder.

Examples

```PHP
$model->compile([
    'loss'=>$nn->losses()->MeanSquaredError(),
]);
```
