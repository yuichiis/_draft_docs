---
layout: document
title: "MeanSquaredError"
grand_upper_section: index
upper_section: apitoc
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