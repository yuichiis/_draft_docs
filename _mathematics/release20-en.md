Summary:

- The default access method for external libraries has been changed from PHP Extension to FFI.
    - This eliminates the need for individual support for each PHP version, operating system, and external library version.
    - PHP Extension can still be used for environments where FFI is not available, but it will not be actively updated in the future.
    - Modules for loading external libraries are now in plugin format and can be replaced. Plugins can be used to switch between FFI and PHP Extension.
- The data serialization method has been changed. The output format has also been changed.
    - In the old format, the PHP class name was directly embedded in the storage format, which made it difficult to flexibly extend the functionality.
    - In the new format, keywords are embedded.
- Support for complex number functions in the BLAS library has been added.
    - A complex number data type has been supported. However, this is currently only for the BLAS library, not all functions.
- The syntax for specifying array subscript ranges has changed.
    - In version 1, the method to specify elements 0 to 4 was [0,4], but in version 2 it is specified as [0,5]. This is to match the notation of other mathematical libraries.
    - You can specify the version 1 style with NDArrayPhp::$rangeStyle and NDArrayCL::$rangeStyle. You can explicitly declare that it is in the version 2 style using the R function. Specify as R(0,5).
        - RANGE_STYLE_DEFAULT: Default version 2 style
        - RANGE_STYLE_1: Version 1 style
        - RANGE_STYLE_FORCE2: Force R function style
- Automatic data type detection has been abolished in the array() function. The default is fixed to float32. If you want to use a data type other than the default, please specify it explicitly.
- With the introduction of complex numbers, the functions amax and amin now return the absolute value.
- With the introduction of complex numbers, the conj option has been added and the order of arguments for some functions has changed. Please use named arguments.
- New functions have been added.
    - omatcopy, pow (function changed), notEqual

Further details:
- FFI: Foreign Function Interface. It allows PHP to call functions written in other languages, such as C.
- Serialization: The process of converting data into a format that can be stored or transmitted.
- Complex numbers: Numbers that have both a real and imaginary part.
- Named arguments: Arguments that are passed to a function by name, rather than by position.

Compatibility:
- Version 2.0 is not compatible with version 1.0 in many ways.
- If you are using version 1.0, you will need to make changes to your code in order to use version 2.0.

