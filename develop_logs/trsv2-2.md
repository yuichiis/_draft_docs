    public function trsv(
        int $order,
        int $uplo,
        int $trans_code, // 元の $trans は $trans_code に変更
        int $diag,
        int $n,
        Buffer $A, int $offsetA, int $ldA,
        Buffer $X, int $offsetX, int $incX
    ) {
        if ($n <= 0) {
            return; // 何もしない
        }

        //[$trans, $conj] = $this->codeToTrans($trans_code); // $trans には操作タイプ(NoTrans/Trans)が入る
        $dtype = $A->dtype();

        // *** 修正点 1: $notrans の条件式 ***
        $notrans = ($trans_code == BLAS::NoTrans);
        $nounit = ($diag == BLAS::NonUnit);
        $upper =  ($uplo == BLAS::Upper);
        $calc = $this->getCalc($dtype);
        // $use_conj = $calc->iscomplex($dtype) && $conj; // 複素数用
        $use_conj = false; // 今回は float なので false

        // --- 1. ループパラメータの設定 ---
        $kx = ($incX > 0) ? 0 : (1 - $n) * $incX;

        // ループ方向の決定 (修正済みのロジックを使用)
        // Forward if (Upper and NoTrans) or (Lower and Trans) is false => (upper == notrans)
        $forward_i_loop = ($upper == $notrans);

        if ($forward_i_loop) {
            $start_i = 0; $end_i = $n; $inc_i = 1;
            $ix_start = $kx; $ix_inc = $incX;
        } else { // Backward loop
            $start_i = $n - 1; $end_i = -1; $inc_i = -1;
            $ix_start = $kx + ($n - 1) * $incX; $ix_inc = -$incX;
        }

        // --- 2. メイン計算ループ ---
        $ix = $ix_start; // Xバッファ内の相対オフセット
        for ($i = $start_i; $i != $end_i; $i += $inc_i) {
            // Aii = A[i,i] (オフセット考慮)
            $Aii = $this->A_ACCESS($A, $offsetA, $i, $i, $ldA, $order);
            // *** 修正点 2: 正しい変数 $X とヘルパー関数でアクセス ***
            $temp = $this->X_GET($X, $offsetX, $ix); // b[i] または計算途中の値を取得
            echo "A[$i,$i]=Aii=$Aii,X[$ix]=temp=$temp\n";

            // 対角要素の共役 (複素数ConjTransの場合のみ)
            // if ($use_conj && $nounit) { $Aii = $calc->conj($Aii); } // ここでやるかは要検討

            // *** 修正点 3: アルゴリズムの修正 ***
            if ($notrans) {
                echo "notrans\n";
                // === NoTrans: op(A)*x = b ===
                // 前進代入 (Lower/NoTrans) または 後退代入 (Upper/NoTrans)

                // 1. Calculate sum = Sum(A[i,j] * x[j]) for relevant j
                $sum_val = $calc->build(0.0);
                if ($forward_i_loop) { // Lower / NoTrans (Sum over j < i)
                    echo "forward_i_loop=true\n";
                    $jx = $kx; // x[0]から
                    for ($j = 0; $j < $i; $j++) {
                        $Aij = $this->A_ACCESS($A, $offsetA, $i, $j, $ldA, $order);
                        $xj = $this->X_GET($X, $offsetX, $jx); // すでに計算済みのx[j]
                        echo "A[$i,$i]=Aij=$Aij,X[$jx]=xj=$jx\n";
                        $sum_val = $calc->add($sum_val, $calc->mul($Aij, $xj));
                        $jx += $incX;
                    }
                } else { // Upper / NoTrans (Sum over j > i)
                    echo "forward_i_loop=false\n";
                    $jx = $kx + ($i + 1) * $incX; // x[i+1]から
                    for ($j = $i + 1; $j < $n; $j++) {
                        $Aij = $this->A_ACCESS($A, $offsetA, $i, $j, $ldA, $order);
                        $xj = $this->X_GET($X, $offsetX, $jx); // すでに計算済みのx[j]
                        echo "A[$i,$i]=Aij=$Aij,X[$jx]=xj=$jx\n";
                        $sum_val = $calc->add($sum_val, $calc->mul($Aij, $xj));
                        $jx += $incX;
                    }
                }
                echo "sum_val=$sum_val\n";

                // 2. temp = b[i] - sum
                $temp = $calc->sub($temp, $sum_val);
                echo "temp=temp-sum_val=$temp\n";

                // 3. x[i] = temp / A[i,i] (if non-unit)
                if ($nounit) {
                    echo "nounit\n";
                    if ($calc->iszero($Aii)) {
                        // Singular matrix handling
                        //trigger_error("Matrix is singular at index $i", E_USER_WARNING);
                        // ここで処理を中断するか、NaNなどを設定するか決める
                        $temp = NAN; // 例
                        //continue; // またはループを抜ける
                    }
                    $temp = $calc->div($temp, $Aii);
                    echo "temp=temp/Aii=$temp\n";
                }
                // *** 修正点 2: 正しい変数 $X とヘルパー関数で書き込み ***
                echo "SET X[$ix]=$temp\n";
                $this->X_SET($X, $offsetX, $ix, $temp); // 計算結果 x[i] を格納

            } else {
                echo "trans\n";
                // === Trans or ConjTrans: op(A)^T*x = b ===
                // M = op(A). Solve M^T * x = b (or M^H * x = b)

                // 1. Calculate temp = b[i] - Sum_{j relevant} M^T[i,j] * x[j]
                // M^T[i,j] = M[j,i] (or conj(M[j,i]))
                // M[j,i] is A[j,i] because op(A) uses the specified uplo part of A.

                $sum_val = $calc->build(0.0);
                if ($forward_i_loop) { // Upper / Trans or ConjTrans (M^T is Lower, sum over j < i)
                    $jx = $kx; // x[0] から
                    for ($j = 0; $j < $i; $j++) {
                        $Aji = $this->A_ACCESS($A, $offsetA, $j, $i, $ldA, $order); // M[j,i] -> A[j,i]
                        // if ($use_conj) { $Aji = $calc->conj($Aji); }
                        $xj = $this->X_GET($X, $offsetX, $jx); // b[j] (まだx[j]は計算されていない) ->間違い。ここはbの値を使うべき
                        // --- Trans/ConjTrans のアルゴリズム再考 ---
                        // この形式 (最初にbから引く) は少し実装が複雑になる。
                        // 別の形式: 最初に x[i] = b[i] を計算し、後で更新する。
                        // x[i] = b[i]
                        // If NonUnit: x[i] /= conj(A[i,i]) if ConjTrans else A[i,i]
                        // For j < i (Lower/Trans) or j > i (Upper/Trans):
                        //   b[j] -= x[i] * conj(A[i,j]) if ConjTrans else A[i,j] (This looks like GER)

                        // --- やはり標準的な代入が良い ---
                        // Transpose の場合、計算済みの x[j] を使う。
                        // temp = b[i] - Sum_{j relevant} M^T[i,j] * x[j]
                        // ここで $xj は b[j] ではなく、ループの前の反復で計算された x[j] である必要がある。
                        // このループ構造 (i と ix の連動) は正しいので、$xj は計算済みの値のはず。
                        $sum_val = $calc->add($sum_val, $calc->mul($Aji, $xj)); // $xj は計算済みの解
                        $jx += $incX;
                    }
                } else { // Lower / Trans or ConjTrans (M^T is Upper, sum over j > i)
                     $jx = $kx + ($i + 1) * $incX; // x[i+1] から
                    for ($j = $i + 1; $j < $n; $j++) {
                         $Aji = $this->A_ACCESS($A, $offsetA, $j, $i, $ldA, $order); // M[j,i] -> A[j,i]
                         // if ($use_conj) { $Aji = $calc->conj($Aji); }
                         $xj = $this->X_GET($X, $offsetX, $jx); // 計算済みの解 x[j]
                         $sum_val = $calc->add($sum_val, $calc->mul($Aji, $xj));
                         $jx += $incX;
                    }
                }
                // temp = b[i] - sum
                $temp = $calc->sub($temp, $sum_val);

                // 2. x[i] = temp / M^T[i,i] (if non-unit)
                // M^T[i,i] = M[i,i] (or conj(M[i,i])) = A[i,i] (or conj(A[i,i]))
                if ($nounit) {
                    $diag_val = $Aii;
                    // if ($use_conj) { $diag_val = $calc->conj($diag_val); }
                    if ($calc->iszero($diag_val)) {
                        //trigger_error("Matrix is singular at index $i", E_USER_WARNING);
                        //continue;
                        $temp = NAN; // 例
                    }
                    $temp = $calc->div($temp, $diag_val);
                }
                 // *** 修正点 2: 正しい変数 $X とヘルパー関数で書き込み ***
                $this->X_SET($X, $offsetX, $ix, $temp); // 計算結果 x[i] を格納
            }

            $ix += $ix_inc; // 次の要素へ
        }
    }
