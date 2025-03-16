# Release Notes: Version 2.2.0

## New PHP Support
- Added support for PHP 8.4.
- Compatible with PHP 8.1, 8.2, 8.3, and 8.4.

## New Features
- Added example code for a basic Transformer model.
- Automatic generation and propagation of tensor masks in layers is now supported.
- Added `MaskedArray` type arrays.
- Added `mask_zero` option to Embedding, supporting automatic generation of mask tensors.
- Added mask functionality to `GRU`, `LSTM`, and `SimpleRNN` layers.
- Overhauled mask functionality in the `Attention` layer to support mask propagation.
- `ArraySpec` can now be used in automatic differentiation expressions.
- `onesLike` can now be used in automatic differentiation expressions.
- Constants can now be defined using `constant`.
- Added ndarray function to convert from `Variable` to plain `NDArray`.
- Added `SequentialDataset` for handling data that cannot be loaded into memory.
- Added `Models` variable for storing multiple Layers and Models.

## New Layers
- `MultiHeadAttention`: Multi-head attention layer for Transformer models.
- `Add`: Adds two arrays.
- `EinsumDense`: Dense layer using the `einsum` function.
- `inheritMask`: Inherits mask tensors from another array.

## Backward Compatibility
- Compatible with version 2.0.

## Known Issues
- The runtime environment depends on the supported platforms of the Rindow-Math-Matrix extension module. In basic mode with PHP only, it works on all platforms.
- Due to issues with the rindow-math-buffer-ffi module on macOS, it does not work in Advanced mode or Accelerated mode on macOS.
