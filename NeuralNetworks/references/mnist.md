Mnist
=====

- **namespace**: Rindow\NeuralNetworks\Model
- **classname**: Mnist

MNIST handwritten digits sample dataset.
See [MNIST web site](http://yann.lecun.com/exdb/mnist/).

Methods
-------

### constructor
```PHP
$builer->mnist()
return $mnist
```
You can create a Mnist dataset instances with the Dataset Builder.


### loadData
```PHP
public function loadData(string $filePath=null)
return [[$train_images, $train_labels],
        [$test_images,  $test_labels ]];
```
Load dataset from the MNIST public site. And translate to NDArray.
Downloaded data is cached.

Arguments:

- **filePath**: path where to cache the dataset locally.
    - Default path is sys_get_temp_dir().'/rindow/nn/datasets'

Examples

```PHP
$mnist = $nn->datasets()->mnist();
[[$train_images, $train_labels],
 [$test_images,  $test_labels ]] = $mnist->loadData(__DIR__.'/../data/mnist');
```
