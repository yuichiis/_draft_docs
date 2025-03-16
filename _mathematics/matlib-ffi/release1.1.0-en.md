    # Release Notes: Version 1.1.0

    ## New PHP Support
    - Added support for PHP 8.4.
    - Compatible with PHP 8.1, 8.2, 8.3, and 8.4.

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
    - Tested on Windows 11 and Ubuntu 22.04/24.04.
    - Likely to work on Windows 10 and Debian 12 as well.
    - The module appears to work on macOS, but due to issues with the rindow-math-buffer-ffi module on macOS, it has not been fully tested.