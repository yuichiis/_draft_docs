# リリースノート: バージョン 0.2.0

## 変更内容
- Spacesインターフェスが公式インターフェースになりました。
- Dict型がSpacesに追加されました。
- Dict型はMasked Actionsの場合にObservationとして返されます。
- InfoによるMaskがDeprecatedになりました。
- Maked ActionおよびDict型関連に変更によりresetとstepの戻り値の型が変わるため、コードの修正が必要です。
- 乱数発生器を独自実装のPcg32に統一しました。
- PHPのsrand/randから乱数系が独立したため、乱数の挙動が変わります。
- srandでは乱数のリセットはできません。個別にリセットしたい場合はreset(seed:$seed)で設定してください。
- 環境インスタンス生成時にrindow-math-matrixから乱数系の初期値を引き継ぐようにしました。

