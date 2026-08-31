# Release Note Version 2.2.0

## 変更点
- PHP8.5のテストに対応
- PHP8.5のphpstan対応
- 明示的にseedを設定できるように変更
- NDArrayでゼロ次元のNDArrayをscalarとしてoffsetSetで使用可能に変更

## 追加関数
LinearAlgebra
- trsv
- randomCategorical
- isfinite
- isinf
- where
- solveg
- setSeed
- randInt
- dtypeToString
- shapeToString
- toString

MatrixOperater
- setSeed
- randInt
