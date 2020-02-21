SparseCategoricalCrossEntropy
=======================

- **namespace**: Rindow\NeuralNetworks\Losses
- **classname**: SparseCategoricalCrossEntropy

Sparse Categorical Cross Entropy loss function.

Use this crossentropy loss function when there are two or more label classes.
We expect labels to be provided as integers. If you want to provide labels
using `one-hot` representation, please use `CategoricalCrossentropy` loss.


Methods
-------

### constructor
```PHP
$builer->SparseCategoricalCrossEntropy()
```
You can create a SparseCategoricalCrossEntropy loss function instances with the Losses Builder.

Examples

```PHP
$model->compile([
    'loss'=>$nn->losses()->SparseCategoricalCrossEntropy(),
]);
```
