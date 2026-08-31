# リリースノート: バージョン 2.3.0


## 追加関数
NeuralNetworks:
- la
- deviceArray
- hostArray

Variable:
- update

Gradient:
- randomCategorical
- log1p
- l2norm
- reducemax
- concat
- softmax
- masking
- gather
- expandDims
- squeeze
- minimum
- maximum
- logsoftmax
- randomNormal
- randomCategorical
- tanh
- log1p
- l2norm


## 仕様変更
Gradient:
- 引数にスカラー値を受け付けるようになった。
- Add, Sub, Mul, Div

## 廃止関数
Variable:
- assign
