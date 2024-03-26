概要
--------
「Rindow Math Matrix」はベクトル計算環境を提供するライブラリです。

多くの人が学習する時間を節約するために、Python numpy に似て作られています。

以下のような特徴があります。

- 共通の Array オブジェクト インターフェイス「NDArray」を実装します。
- 柔軟な N 次元配列演算ライブラリを提供します。
- OpenBLASと互換性があります

要件
------------
- PHP 8.1、8.2、8.3
   - (PHP 7.2から8.0までの環境で使用する場合は、リリース1.1を使用してください。)
- Window 10、11、または Linux (OpenBLASを使用する場合)

Recommends
----------
- [**Rindow Math Plot**](/mathematics/plot/overviewplot.html): Visualization mathematical data
- [**Rindow Matlib and OpenBLAS**](/mathematics/openblas/overviewopenblas.html): C language interface and High-speed operation
- [**OpenCL and CLBlast**](/mathematics/acceleration/openblas.html): Supports GPU acceleration


Installation
------------
### Install the Rindow Math Matrix
Please set up with composer.

```shell
$ composer require rindow/rindow-math-matrix
```

If you want a graphical display, set up rindow-math-plot.

```shell
$ composer require rindow/rindow-math-plot
```

For Linux, image viewer settings are required for rindow-math-plot.

```shell
$ RINDOW_MATH_PLOT_VIEWER=/some/bin/dir/png-file-viewer
$ export RINDOW_MATH_PLOT_VIEWER
```
Note: Specify "viewnior" etc. for RINDOW_MATH_PLOT_VIEWER

### Install accelarators

To use OpenBLAS and Rindow-Matlib, read and install them [here](/mathematics/openblas/overviewopenblas.html).


To use GPU, please read [here](/mathematics/acceleration/openblas.html) and install it.
