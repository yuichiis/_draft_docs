# リリースノート: バージョン 2.2.0

## 新しいPHPに対応
- PHP 8.4に対応しました。
- PHP 8.1,8.2,8.3,8.4に対応しています。

## 新しい機能
- レイヤでテンソルマスクの自動的な生成と伝搬がサポートされました。
- MaskedArray型の配列が追加されました。
- Embeddingにmask_zeroオプションが追加され自動てきなマスクテンソルの生成がサポートされました。
- GRU,LSTM,SimpleRNNレイヤーにマスク機能が追加されました。
- Attentionレイヤーのマスク機能が全面的に変更されマスク伝搬に対応しました。
- 自動微分式の中でArraySpecが使えるようになりました。
- 自動微分式の中でonesLikeが使えるようになりました。
- 定数をconstantで記述することができるようになりました。
- VariableからプレーンなNDArrayに変換するndarray関数が追加されました。
- メモリーに読み込みきれないデータを取り扱うためのSequentialDatasetが追加されました。
- 複数のLayerおよびModelを格納するModels変数が追加されました。

## 新しいレイヤー
- `MultiHeadAttention`: Transformarモデルに対応したマルチヘッドアテンションレイヤーです。
- `Add`: ２つの配列を加算します。
- `EinsumDense`: `einsum`関数を使ったDenseレイヤーです。
- `inheritMask`: マスクテンソルを別の配列から継承させます。

## 下位互換性
- バージョン2.0と下位互換性があります。

## 既知の問題
- 動作環境はRindow-Math-Matrixの拡張モジュールの対応プラットフォームに依存します。PHPのみの基本モードではすべてのプラットフォームで動作できます。
- rindow-math-buffer-ffiモジュールがmacOSで動作しない問題があるため、macOSではAdvancedモードやAcceralatedモードでは動作しません。
