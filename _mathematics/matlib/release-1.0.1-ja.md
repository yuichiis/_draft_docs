### MSVC用の名前バインディング
名前バインディング ライブラリを追加し、Windows で DLL バージョンがわずかに変更された場合の予期しない動作を防ぐためにデフォルトにしました。
新しく追加されたライブラリは、MSVC の標準インポート ライブラリを使用するときに、アドレス テーブルが変更され、DLL 内の関数を呼び出すことができなくなる問題を解決します。

### MacOS用のプレビルドバイナリファイル
Githubの機能によりプレビルドバイナリーを自動的に公開するようにしました。
これによりMacOS用のarm64とx86_64の両方を提供できるようになりました。
MacOSのユニバーサルバイナリーをビルドできないのはGithubホステッドランナーの使用です。

### MSVC name-binding on Windows
Added name binding library and made it default to prevent unexpected behavior if DLL version changes slightly on Windows.
A newly added library resolves an issue when using MSVC's standard import library that modifies the address table and prevents you from calling functions in a DLL.

### Arm64 and Intel pre-build binary for MacOS
Pre-built binaries are now automatically published using Github's capabilities.
This allows us to provide both arm64 and x86_64 for MacOS.
The reason why you can't build universal binaries for MacOS is due to the specifications of the hosted runner on Github.
