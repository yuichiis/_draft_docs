
mask_zero

入力値0が特別な「パディング」値としてマスクされるべきかどうかのブール値です。これは可変長の入力を取るリカレントレイヤーやアテンションレイヤを使用する際に便利です。もしこれがTrueに設定されている場合、モデル内のそれ以降のすべてのレイヤーはマスキングをサポートしている必要があり、そうでなければマスキング情報は消失します。またレイヤー以外を通過する場合も、マスク情報は消失しますmask_zeroがTrueに設定されている場合、その結果として、インデックス0は語彙の中で使用できなくなります（input_dimは語彙のサイズ+1に等しくなければなりません）。


Here's the English translation:

A boolean value indicating whether the input value 0 should be masked as a special "padding" value. This is useful when using recurrent layers or attention layers that handle variable-length inputs. If this is set to True, all subsequent layers in the model must support masking, otherwise the masking information will be lost. The masking information will also be lost if it passes through anything other than a layer. When mask_zero is set to True, as a result, index 0 becomes unavailable for use in the vocabulary (input_dim must be equal to vocabulary size + 1).
