概要
--------
PHPのための数学ライブラリを提供するプロジェクトです。

多くの科学計算や機械学習はベクトル演算を使用します。
しかし、PHPの関数はスカラ演算のみです。
また、PHPの配列はベクトル演算に適していません。

したがって、このプロジェクトの基本的な考え方は適切な配列オブジェクトを定義することです。
その上にベクトル演算のためのすべてを構築します。

以下の特徴があります。

- 共通の配列オブジェクトインターフェース「NDArray」を定義します。
- 柔軟な行列計算ライブラリを提供します。
- 外部の数学ライブラリをリンクして行列演算を高速化します。
- GPUを利用して行列演算を高速化します。
- 数学的データの可視化ライブラリを提供します。
- 上位レイヤから下位レイヤーまで機能を分割して柔軟な組み合わせを可能にしています。


動作モード
---------
利用環境によって３つの動作モードを使い分けることができます。

- **Basic**: 純粋なPHPのみで動作。環境に依存せず動作することが出来ます。一般的なWebホスティングサービスなどで動作する事も出来ます。
- **Advanced**: 外部ライブラリをリンクして高速な計算を可能にします。現在はRindow-MatlibとOpenBLASが利用可能です。
- **Accelerated**: 外部ライブラリをリンクして高速演算可能なハードウェアを利用可能にします。現在はOpenCLとCLBlastが利用可能です。


ライブラリ
---------
7つのライブラリに分割されています。

- [**Rindow Math Matrix**](matrix/matrix.html): NDArrayと配列演算
- [**Rindow Math Plot**](plot/overviewplot.html): 数学的データの可視化
- [**Rindow Math Buffer FFI**](openblas/overviewopenblas.html): NDArrayをC言語インターフェースからアクセス可能にするバッファ
- [**Rindow Matlib FFI**](openblas/overviewopenblas.html): C言語インターフェースと高速演算
- [**Rindow OpenBLAS FFI**](openblas/overviewopenblas.html): BLAS関数のC言語インターフェースと高速演算
- [**Rindow OpenCL FFI**](acceleration/opencl.html#rindow-opencl-ffi): GPUアクセラレーションをサポート
- [**Rindow CLBlast FFI**](acceleration/opencl.html#rindow-clblast-ffi): BLAS関数のGPUアクセラレーションをサポート


