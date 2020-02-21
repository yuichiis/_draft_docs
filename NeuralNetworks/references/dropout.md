Dropout
=======

- **namespace**: Rindow\NeuralNetworks\Layer
- **classname**: Dropout

Dropout layer.

Applies Dropout to the input.

Methods
-------

### constructor
```PHP
$builer->Dropout(float $rate)
```
You can create a Dropout layer instances with the Layer Builder.

Arguments

- **rate**: Fraction of the input units to drop.
    - Float between 0 and 1.

Examples

```PHP
$model->add($nn->layers()->Dropout(0.15));
```
