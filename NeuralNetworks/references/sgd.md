SGD
===

- **namespace**: Rindow\NeuralNetworks\Optimizer
- **classname**: SGD

Stochastic gradient descent and momentum optimizer.

Methods
-------

### constructor
```PHP
$builer->SGD(
    array $options=[
        'lr'=>0.01,
    ]
)
```
You can create a SGD optimizer instances with the Optimizer Builder.

Options

- **lr**: learning rate.
    - float >= 0
    - default is 0.01

Examples

```PHP
$model->compile([
    $nn->optimizers()->SGD(['lr'=>0.01]),
]);
```
