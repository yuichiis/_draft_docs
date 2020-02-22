---
layout: document
title: "Relu"
upper_section: references
previous_section: dense
next_section: sigmoid
---

- **namespace**: Rindow\NeuralNetworks\Layer
- **classname**: Relu

Rectified Linear Unit activation function.

Methods
-------

### constructor
```php
$builer->Relu()
```
You can create a Relu layer instances with the Layer Builder.

Examples

```php
$model->add($nn->layers()->Relu());
```
