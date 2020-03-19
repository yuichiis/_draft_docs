---
layout: document
title: "rindow mathematics libraries"
next_section: matrix
---

Overview
--------
A project to provide a mathematical libraries for PHP.

Most scientific calculations and machine learning use vector operations,
but PHP functions are only scalar operations.
Also, PHP Array is not suitable for vector operation.

Therefore, the basic policy is to define an Array object suitable
for vector operation and build everything on it.

It has the following features.

- Define a common Array object interface "NDArray".
- Provides a flexible matrix operation library.
- Provide C language interface of Array object by PHP extension
- High-speed matrix operation provided by PHP extension
- Provides a visualization library for mathematical data

Libraries
---------
Divided into three libraries

- [**Rindow Math Matrix**](matrix/matrix.html): NDArray and array operations
- [**Rindow Math Plot**](plot/overviewplot.html): Visualization mathematical data
- **Rindow OpenBLAS extension**: C language interface and High-speed operation