---
layout: document
title: "MeanSquaredError"
upper_section: references
previous_section: batchnormalization
next_section: binarycrossentropy
---

- **namespace**: Rindow\NeuralNetworks\Losses
- **classname**: MeanSquaredError

Mean Squared Error loss function.

Computes the mean of squares of errors between labels and predictions.

Methods
-------

### constructor
```php
$builer->MeanSquaredError()
```
You can create a MeanSquaredError loss function instances with the Losses Builder.

Examples

```php
$model->compile([
    'loss'=>$nn->losses()->MeanSquaredError(),
]);
```
