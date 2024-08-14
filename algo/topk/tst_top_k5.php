<?php
use ArrayObject as Buffer;

class TopK
{
    private function topkSwap(Buffer $data, int $offset, int $ia, int $ib) : void
    {
        $tmp = $data[$ia+$offset];
        $data[$ia+$offset] = $data[$ib+$offset];
        $data[$ib+$offset] = $tmp;
    }

    private function topkMinHeapify(
        int $size,
        Buffer $heap, int $offsetHeat,
        Buffer $indices, int $offsetIndices,
        int $parent
        ) : void
    {
        //echo sprintf("========================\n");
        //echo sprintf("minHeapify: size=%d parent=%d\n",$size,$parent);
        $left = 2 * $parent + 1;
        $right = 2 * $parent + 2;
        //echo sprintf("parent=%d left=%d, right=%d\n",$parent,$left,$right);
    
        while ($left < $size) {
            //if($right < $size) {
            //    echo sprintf("*left:%d =%4.1f *right:%d =%4.1f\n",$left,$heap[$offsetHeat+$left],$right,$heap[$offsetHeat+$right]);
            //} else {
            //    echo sprintf("*left:%d =%4.1f *right:%d = NONE\n",$left,$heap[$offsetHeat+$left],$right);
            //}
            if ($right < $size && $heap[$offsetHeat+$right] < $heap[$offsetHeat+$left]) {
                //echo sprintf("right is smaller\n");
                $smallest = $right;
            } else {
                //echo sprintf("left is smaller\n");
                $smallest = $left;
            }
    
            //echo sprintf("*parent:%d =%4.1f *smaller:%d =%4.1f\n",$parent,$heap[$offsetHeat+$parent],$smallest,$heap[$offsetHeat+$smallest]);
            if ($heap[$offsetHeat+$parent] <= $heap[$offsetHeat+$smallest]) {
                //echo sprintf("parent is smallest\n");
                break;
            }
            //echo sprintf("parent is not smallest\n");
            //echo sprintf("swap: parent:%d:%4.1f, smallest:%d:%4.1f\n",$parent,$heap[$offsetHeat+$parent],$smallest,$heap[$offsetHeat+$smallest]);
            $this->topkSwap($heap,$offsetHeat,$parent,$smallest);
            $this->topkSwap($indices,$offsetIndices,$parent,$smallest);
            //echo sprintf("*parent:%d =%4.1f *smallest:%d =%4.1f\n",$parent,$heap[$offsetHeat+$parent],$smallest,$heap[$offsetHeat+$smallest]);

            $parent = $smallest;
            $left = 2 * $parent + 1;
            $right = 2 * $parent + 2;
            //echo sprintf("parent=%d left=%d, right=%d\n",$parent,$left,$right);
        }
    }
    
    private function topkFindTopNumbers(
        int $size,
        Buffer $arr, int $offsetArr,
        int $k,
        Buffer $topNumbers, int $offsetTopNumbers,
        Buffer $indices, int $offsetIndices,
        bool $sorted
        ) : void
    {
        // Build minimum heap with first TOP_NUM element
        
        for ($i = 0; $i < $k; ++$i) {
            $topNumbers[$i+$offsetTopNumbers] = $arr[$i+$offsetArr];
            $indices[$i+$offsetIndices] = $i;
        }
        //print_arr(k, arr, indices);
        for ($i = intdiv($k,2) - 1; $i >= 0; --$i) {
            $this->topkMinHeapify($k, $topNumbers,$offsetTopNumbers, $indices,$offsetIndices, $i);
        }
        //print_arr(k, arr, indices);
    
        // Process remaining elements
        for ($i = $k; $i < $size; ++$i) {
            if ($arr[$i+$offsetArr] > $topNumbers[$offsetTopNumbers]) {
                $topNumbers[$offsetTopNumbers] = $arr[$i+$offsetArr];
                $indices[$offsetIndices] = $i;
                $this->topkMinHeapify($k, $topNumbers,$offsetTopNumbers, $indices,$offsetIndices, 0);
            }
        }
    
        if($sorted) {
            // sort
            for ($i = $k - 1; $i > 0; --$i) {
                $this->topkSwap($topNumbers,$offsetTopNumbers, 0, $i);
                $this->topkSwap($indices,$offsetIndices, 0, $i);
                $this->topkMinHeapify($i, $topNumbers,$offsetTopNumbers, $indices,$offsetIndices, 0);
            }
        }
    }

    public function topk(
        int $m,
        int $n,
        Buffer $input, int $offsetInput,
        int $k,
        bool $sorted,
        Buffer $values, int $offsetValues,
        Buffer $indices, int $offsetIndices
        ) : void
    {
        //$this->assertShapeParameter("m", $m);
        //$this->assertShapeParameter("n", $n);
        //$this->assertShapeParameter("k", $k);
        //$this->assertMatrixBufferSpec("input", $input, $m,$n, $offsetInput, $n);
        //$this->assertMatrixBufferSpec("values", $values, $m,$k, $offsetValues, $k);
        //$this->assertMatrixBufferSpec("indices", $indices, $m,$k, $offsetIndices, $k);

        if($k>$n) {
            return;
        }

        for($i = 0; $i < $m; ++$i) {
            $this->topkFindTopNumbers(
                $n,
                $input, $offsetInput+$i*$n,
                $k,
                $values, $offsetValues+$i*$k,
                $indices, $offsetIndices+$i*$k,
                $sorted
            );
        }
    }
}

$math = new TopK();
$input = new Buffer([4,5,1,2,3]);
$values = new Buffer([0,0,0,0,0]);
$indices = new Buffer([0,0,0,0,0]);
$m = 1;
$n = 5;
$k = 5;
$math->topK($m,$n,$input,0,$k,false,$values,0,$indices,0);
var_dump($values->getArrayCopy());
