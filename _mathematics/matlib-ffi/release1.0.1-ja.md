### OpenBLASの動作モードに対する対処方法の方針変更

- rindow-matlibの動作がOpenBLASの動作モードと関係する事が分ったため、OpenBLASへの対処方法を文書化した。

### 型定義の全面見直し

- php7のなごりの型定義の無い変数や引数に型定義を適用した。

### 追加関数

- getConfig: rindow-matlibのバージョンを取得

### バグフィックス

- updateAddOnehot: float64で動作しない問題をfix

### エラー発生時のバグ

- エラー発生時に起きる細かなバグの修正


Add Support for Loading Rindow Matlib Library on macOS
