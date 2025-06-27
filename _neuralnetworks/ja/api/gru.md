mask

形状が`(サンプル数, タイムステップ数)`のブール値テンソルで、特定のタイムステップをマスクすべきかどうかを示します（任意）。個々の`true`エントリは、対応するタイムステップを利用すべきことを示し、`false`エントリは対応するタイムステップを無視すべきことを示します。デフォルトは`null`です。

A boolean tensor with shape `(number of samples, number of timesteps)` that indicates whether specific timesteps should be masked (optional). Individual `true` entries indicate that the corresponding timestep should be utilized, while `false` entries indicate that the corresponding timestep should be ignored. The default is `null`.