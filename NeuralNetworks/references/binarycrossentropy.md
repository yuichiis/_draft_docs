BinaryCrossEntropy
==================

- **namespace**: Rindow\NeuralNetworks\Losses
- **classname**: BinaryCrossEntropy

Binary Cross Entropy loss function.

Use this cross-entropy loss when there are only two label classes (assumed to be 0 and 1). For each example, there should be a single floating-point value per prediction.

Methods
-------

### constructor
```PHP
$builer->BinaryCrossEntropy()
```
You can create a BinaryCrossEntropy loss function instances with the Losses Builder.

Examples

```PHP
$model->compile([
    'loss'=>$nn->losses()->BinaryCrossEntropy(),
]);
```
