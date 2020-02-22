---
layout: document
title: "Softmax"
upper_section: references
previous_section: sigmoid
next_section: dropout
---

- **namespace**: Rindow\NeuralNetworks\Layer
- **classname**: Softmax

Softmax activation function.

Methods
-------

### constructor
```php
$builer->Softmax()
```
You can create a Softmax layer instances with the Layer Builder.

Examples

```php
$model->add($nn->layers()->Softmax());
```
