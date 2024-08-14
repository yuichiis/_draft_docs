<?php
// 再起呼び出しバージョン
function crawler(
    int $depth,
    array $indices,
    array $shape,
) : void
{
    if($depth<count($shape)) {
        for($i=0;$i<$shape[$depth];$i++) {
            $indices[$depth] = $i;
            crawler($depth+1,$indices,$shape);
        }
        return;
    }
    echo "(".implode(',',$indices).")\n";
}

crawler(0,[],[4,3,2]);

