Summary:

- New functions added to Gradient
    - BandPart,Cast,Equal,Get,Greater,Increment,Less,NotEqual,Ones,Repeat,Reshape,Scale,Shape,Transpose,Zeros,ZeroLike
- New layer added
    - Attention (significantly changed functionality), LayerNormalization,
- Metric feature added
    - BinaryAccuracy, CategoricalAccuracy, GenericMetric, MeanNorm2Error, MeanSquaredError, ScalarMetric, SparseCategoricalAccuracy
- Added scheduling feature to Optimizer
    - ExponentialDecay, InverseTimeDecay
- Compatible with Rindow Math Matrix version 2.0.

compatibility:

- The model save format has been changed due to changes in Rindow Math Matrix. Previous models and other data may not be loaded.
- The method for specifying array ranges has changed due to changes in Rindow Math Matrix. You may need to modify previous source code.
- Due to changes in Rindow Math Matrix, the external library call method has been changed from PHP Extension to PHP FFI. FFI must be enabled and available. There is no need to enable FFI if you do not use external libraries.
