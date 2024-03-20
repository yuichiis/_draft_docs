Summary:

- Gradientに新しい関数が追加されました
    - BandPart,Cast,Equal,Get,Greater,Increment,Less,NotEqual,Ones,Repeat,Reshape,Scale,Shape,Transpose,Zeros,ZeroLike
- 新しいレイヤーが追加されました
    - Attention(大幅に機能変更),LayerNormalization,
- Metric機能が追加されました
    - BinaryAccuracy, CategoricalAccuracy, GenericMetric, MeanNorm2Error, MeanSquaredError, ScalarMetric, SparseCategoricalAccuracy
- Optimizerにスケジュール機能が追加されました
    - ExponentialDecay, InverseTimeDecay
- Rindow Math Matrix version 2.0に対応しました。

互換性:
- Rindow Math Matrixの変更によりモデルの保存形式が変更になりました。以前のモデルやその他のデータが読み込めない可能性があります。
- Rindow Math Matrixの変更により配列の範囲指定方法が変わりました。以前のソースコードを修正する必要がある場合があります。
- Rindow Math Matrixの変更により外部ライブラリ呼び出し方法がPHP ExtensionからPHP のFFIに変更れました。FFIを有効にして利用可能にする必要があります。外部ライブラリを使用しない場合はFFIを有効にする必要はありません。
