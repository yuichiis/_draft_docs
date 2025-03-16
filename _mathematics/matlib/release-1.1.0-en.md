# Release Notes: Version 1.1.0

## New Features
- Added a native thread-based parallel processing library. It is recommended to use the thread-based library instead of the OpenMP version from now on. This is due to issues with the Windows OpenMP library causing problems when PHP processes terminate, and for the efficiency of parallel processing algorithms.

## New Functions
- `masking`: Masks a numerical array with a boolean array.
- `cumsumb`: An extended version of the `cumsum` function.
- `bandpart` (integer support): Added integer support to the `bandpart` function.
- `gatherb`: An extended version of the `gather` function.
- `einsum`: A general version of `einsum`. It has high flexibility in the formulas it can process but is slow.
- `einsum4p1`: A limited version of the `einsum` function. It can only compute 4+1 dimensional arrays but is fast.

## Preview Functions
These may change or be removed in future releases.
- `topk`: The `top_k` function.
- `gathernd`: The `gathernd` function.

## Backward Compatibility
- Compatible with version 1.0.

## Supported Platforms
- Can be built from source in a C++ environment. There are C++ thread versions, OpenMP versions, and single-thread versions for each environment.

### Prebuilt Binaries
- Ubuntu 24.04
- Ubuntu 22.04 (also available on Ubuntu 24.04 and Debian 12)
- Windows (usable with Visual Studio runtime libraries on Windows 10/11)
- macOS x86_64 (usable on macOS 13 for Intel Macs)
- macOS Arm64 (usable on macOS 14 for Apple Silicon)