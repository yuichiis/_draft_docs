<?php
// ループ展開バージョン
function crawlerLoop(array $shape) : void {
    $depth = count($shape);
    $indices = array_fill(0, $depth, 0);
    $isFinished = false;

    while (!$isFinished) {
        // 現在のインデックスを出力
        echo "(".implode(',', $indices).")\n";

        // 次のインデックスへ
        $i = $depth - 1;
        while ($i >= 0 && $indices[$i] == $shape[$i] - 1) {
            $indices[$i] = 0;
            $i--;
        }

        if ($i < 0) {
            // 全ての組み合わせを探索済み
            $isFinished = true;
        } else {
            $indices[$i]++;
        }
    }
}

//crawlerLoop([4, 3, 2]);
crawlerLoop([2, 3, 4]);
