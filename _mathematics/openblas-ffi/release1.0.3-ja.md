

### OpenBLASの動作モードに対する対処方法の方針変更

- rindow-matlibの動作がOpenBLASの動作モードと関係する事が分ったため、OpenBLASへの対処方法を文書化した。

- 動作モードの選択作業を明確にするためシェアードライブラリのファイル名を厳格にした。
  - Linux上でlibopenblas.so.0とliblapacke.so.3のみを読み込むように変更。開発用ライブラリを認めない。

### 型定義の全面見直し

- php7のなごりの型定義の無い変数や引数に型定義を適用した。

### BLAS関数追加

- rotm, rotmgを追加

### エラー発生時のバグ

- エラー発生時に起きる細かなバグの修正

