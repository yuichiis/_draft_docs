Models
======
Overview
-------

- namespace: Rindow\NeuralNetworks\Builder
- classname: Models

Create a new model or generate a model instance from a saved model.

Methods
-------

### Sequential

```PHP
public function Sequential(
    array $layers=null
)
return $model
```
Create the new Sequential model instance.

See the constructor of the "Sequential".

### loadModel

```PHP
public function loadModel(
    $filepath
)
return $model
```
Generate the saved model instance from $filepath.

See the loadModel method of the "ModelLoader".

### modelFromConfig

```PHP
public function modelFromConfig(
    $modelFromConfig
)
return $model
```
Generate the saved model instance from $modelFromConfig.
The generated model does not include the trained data.

See the loadModel method of the "ModelLoader".
