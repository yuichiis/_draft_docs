### 新しい世代のPHP extensionに対応
- Rindow Math Matrix version 2の為に作られたPHP Extensionに対応した。
- 新しいExtensionではWindowsにおいて名前ベースのDLL呼び出しに変更。OpenBLASやDLLバージョンが変わっても対応できます。

### インターフェースは変わらずV1.1のまま
- インターフェースが変わらないためRindow Neuralnetworks v1が動作します。

### PHP7.x と PHP8.0に完全に対応
- rindow_openblas, rindow_opencl, rindow_clblastのWindows,Linux用のバイナリーがPHP7.2, 7.3, 7.4, 8.0に対してダウンロード可能。
- PHP 7.xとPHP8.0の上で動作します。
