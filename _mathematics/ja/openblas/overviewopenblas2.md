## 概要

Rindow-MatlibFFIサービスは、Rindow-math-matrixのバックエンドライブラリとして機能し、C言語で実装された高速な数値演算機能を提供するために、外部ライブラリを呼び出します。

### 主な特徴

  * C言語とPHP間での効率的なデータ交換を実現する一次元ユニバーサルバッファを提供します。
  * OpenBLASライブラリとほぼ同一の低レベルインターフェースをPHPから利用できます。これにより、配列の形状に依存しない柔軟な数値演算が可能です。
  * Rindow-matlibライブラリも、C言語とほぼ同一の低レベルインターフェースでPHPから利用できます。
  * [Rindow Math Matrix](https://www.google.com/search?q=/mathematics/matrix/matrix.html) と組み合わせることで、高性能なN次元配列演算を高速に実行できます。

PHPでのディープラーニング開発において、高いパフォーマンスを発揮します。

### 高速な演算

OpenBLASとRindow-Matlibは、C言語で記述されたCPUによる高速な演算を可能にする主要なバックエンドです。

OpenBLASは広く知られた高性能な線形代数ライブラリであり、Rindow-Matlibは機械学習に有用な様々な関数群を提供します。これらのライブラリは、マルチスレッドによる並列演算やCPUのSIMD命令を活用することで、高速な処理を実現しています。

### ポータビリティ

バージョン2以降では、PHPのFFI (Foreign Function Interface) 機能を利用してC言語インターフェースライブラリを呼び出す方式に変更されました（バージョン1ではPHP拡張機能を使用していました）。

これにより、PHP専用の拡張機能が不要となり、高い移植性を実現しています。各ライブラリが対応するWindows、Linux、macOSの各プラットフォーム向けに提供されているプリビルドバイナリをインストールするだけで、すぐに利用可能です。

また、バックエンドはBufferインターフェースというRindow-Math-Matrixとは独立した汎用的なインターフェースを通じて提供されるため、Rindow-Math-Matrixを経由せずに他のシステムから直接利用したり、逆にBufferインターフェースに準拠した独自のバックエンドを作成してRindow-Math-Matrixで使用することも可能です。

各関数はOpenBLASおよびRindow-MatlibのC言語インターフェースとほぼ同一の低レベルインターフェースとしてPHPから直接利用できるため、C/C++で開発されたアプリケーションからの移植を容易にします。

## 動作要件

  * PHP 8.1、PHP 8.2、PHP 8.3、または PHP 8.4
  * Windows 10/11, Linux (Ubuntu 22.04 以降, Debian 12 以降), macOS
  * OpenBLAS ライブラリ バージョン 0.3.20 以降
  * Rindow-Math ライブラリ バージョン 1.1 以降

## プリビルドバイナリからのインストール手順

### プリビルドバイナリのダウンロード

以下の各プロジェクトのリリースFページから、プリビルドバイナリファイルをダウンロードしてください。これらのライブラリを連携させることで、高速なN次元配列演算が可能になります。

  * プリビルドバイナリ
      * [Rindow Matlib](https://github.com/rindow/rindow-matlib/releases)
      * [OpenBLAS](https://github.com/OpenMathLib/OpenBLAS/releases)

### Windows での設定

ダウンロードしたバイナリファイルを解凍し、PHPの実行ディレクトリにコピーします。

  * `rindow-matlib-X.X.X-win64.zip`
  * `OpenBLAS-X.X.X-x64.zip`

`php.ini` ファイルに FFI 拡張機能を有効にする設定を追加します。

```shell
C:\TMP> cd C:\path\to\php\directory  # PHPのインストールディレクトリへ移動
C:\PHP> notepad php.ini               # php.ini をテキストエディタで開く

; extension=ffi                      # この行の先頭のセミコロンを削除するか、この行を追加
extension=ffi
C:\PHP> php -m                       # FFI拡張が有効になっていることを確認

C:\TMP> set PATH=%PATH%;C:\path\to\binary\directories\bin  # ダウンロードしたバイナリのbinディレクトリへのパスを追加
C:\TMP> cd C:\your\project\directory                    # プロジェクトのルートディレクトリへ移動
C:\PRJ> composer require rindow/rindow-math-matrix
C:\PRJ> composer require rindow/rindow-math-matrix-matlibffi
C:\PRJ> vendor/bin/rindow-math-matrix                    # 設定確認コマンドを実行
Service Level  : Advanced
Buffer Factory : Rindow\Math\Buffer\FFI\BufferFactory
BLAS Driver    : Rindow\OpenBLAS\FFI\Blas
LAPACK Driver  : Rindow\OpenBLAS\FFI\Lapack
Math Driver    : Rindow\Matlib\FFI\Matlib
```

### Linux での設定

`apt` コマンドを使用して、必要なライブラリをインストールします。

まず、FFI拡張機能が有効になっていることを確認してください。

```shell
$ php -m | grep FFI
FFI
```

**OpenBLAS のインストール:**

Rindow-matlibは現在 `pthreads` を使用するため、OpenBLASも `pthread` 版を選択してください。以前のバージョン（1.0）ではOpenMP版を推奨していましたが、現在ではpthread版を推奨しています。

OpenMP版のOpenBLASを使用すると、競合が発生し、システムの不安定化やパフォーマンスの低下を招く可能性があります。この問題はWindows環境では発生しません。

```shell
$ sudo apt install libopenblas0 liblapacke
```

**Rindow-Matlib のインストール:**

以下のURLからプリビルドバイナリファイルをダウンロードします。

  * [https://github.com/rindow/rindow-matlib/releases](https://github.com/rindow/rindow-matlib/releases)

ダウンロードした `deb` ファイルを `apt` コマンドでインストールします。

```shell
$ sudo apt install ./rindow-matlib_X.X.X_amd64.deb
```

**Rindow-Matlib-FFI のインストール:**

`composer` を使用してプロジェクトにインストールします。

```shell
$ cd /your/project/directory  # プロジェクトのルートディレクトリへ移動
$ composer require rindow/rindow-math-matrix
$ composer require rindow/rindow-math-matrix-matlibffi
$ vendor/bin/rindow-math-matrix # 設定確認コマンドを実行
Service Level  : Advanced
Buffer Factory : Rindow\Math\Buffer\FFI\BufferFactory
BLAS Driver    : Rindow\OpenBLAS\FFI\Blas
LAPACK Driver  : Rindow\OpenBLAS\FFI\Lapack
Math Driver    : Rindow\Matlib\FFI\Matlib
```

### Linux のトラブルシューティング

もし OpenMP 版の OpenBLAS が既にインストールされている場合は、以下のコマンドで削除してください。

```shell
$ sudo apt remove libopenblas0-openmp
```

依存関係などの理由で削除できない場合は、`update-alternatives` コマンドを使用してpthread版に切り替えることができます。

```shell
$ sudo update-alternatives --config libopenblas.so.0-x86_64-linux-gnu
$ sudo update-alternatives --config liblapack.so.3-x86_64-linux-gnu
```

（プロンプトに従って、pthread版の選択肢を選んでください。）

どうしても OpenMP 版の OpenBLAS を使用したい場合は、Rindow-matlibをOpenMP版に切り替える必要があります。

```shell
$ sudo update-alternatives --config librindowmatlib.so

alternative librindowmatlib.so (提供元 /usr/lib/librindowmatlib.so) には 3 個の選択肢があります。

  選択肢    パス                                          優先度  状態
------------------------------------------------------------
* 0         /usr/lib/rindowmatlib-thread/librindowmatlib.so   95    自動モード
  1         /usr/lib/rindowmatlib-openmp/librindowmatlib.so   95    手動モード
  2         /usr/lib/rindowmatlib-serial/librindowmatlib.so   90    手動モード
  3         /usr/lib/rindowmatlib-thread/librindowmatlib.so  100   手動モード

現在の選択 [*] を保持するには <enter> を押すか、選択肢番号を入力してください: 1
```

上記のように表示されたら、「1」を入力して `rindowmatlib-openmp` を選択してください。

