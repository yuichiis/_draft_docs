# Name-based calling of functions in OpenBLAS DLL for MSVC

この MSVC ライブラリは、OpenBLAS DLL に対して名前ベースの呼び出しを行います。 バージョンの多少の違いでアドレステーブルが変わっても、DLLを正しく呼び出すことができます。

インポート ライブラリとリンクする代わりに、このライブラリとリンクするだけで、簡単に OpenBLAS アプリケーションを公開できます。

一般的にはMSVCでインポートライブラリを使用したDLLを呼び出す場合、DLLのバージョンが少しでも変わったり、別の環境で再構築したりすると、アドレステーブルが変更され、関数が正しく呼び出されなくなります。

このため、多くの人は vcpkg を使用して毎回すべてを再構築し、使用するプロジェクトのバイナリを作成してリンクすることを選択します。

しかし、プロジェクトごとに毎回DLLをリンクしてリビルドするのは手間がかかり、Windows上でOpenBLASを利用したオープンソースソフトウェアを利用するのは非常に困難です。

このライブラリは、アドレス テーブルの問題を解決するために使用できます。

## 

This MSVC library makes name-based calls to OpenBLAS DLLs. Even if the address table changes due to slight differences in versions, the DLL can be called correctly.

You can easily publish OpenBLAS applications by simply linking with this library instead of linking with the import library.

Generally, when calling a DLL using an import library with MSVC, if the DLL version changes even slightly or is rebuilt in a different environment, the address table will change and the function will not be called correctly.

For this reason, many people choose to use his vcpkg to rebuild everything every time, creating and linking binaries for the projects they use.

However, linking and rebuilding DLLs for each project is time-consuming and extremely difficult to use open source software that uses OpenBLAS on Windows.

This library can be used to solve address table problems.
