<?php
include __DIR__.'/../../rindow-neuralnetworks/vendor/autoload.php';

use Interop\Polite\Math\Matrix\NDArray;

$mo = new Rindow\Math\Matrix\MatrixOperator();
$la = $mo->la();


class Math
{
    protected object $mo;
    public function __construct(object $mo)
    {
        $this->mo = $mo;
    }

    public function parseEinsum(
        string $equation,
        NDArray ...$arrays,
    ) : array
    {
        $equation = str_replace(' ','',$equation);
        $parts = explode('->',$equation);
        if(count($parts)!=2) {
            throw new InvalidArgumentException('One "->" symbol is required in the formula string.');
        }
        ///var_dump($parts);
        [$sumEquation,$target] = $parts;

        // parse input indices
        $indicesList = explode(',',$sumEquation);
        $parsedIndicesList = [];
        $allIndices = [];
        foreach($indicesList as $indices) {
            $parsedIndices = $this->parseIndices($indices);
            $parsedIndicesList[] = $parsedIndices;
            foreach($parsedIndices as $index) {
                $allIndices[$index] = true;
            }
        }
        //foreach($parsedIndicesList as $i => $indices) {
        //    echo "arg{$i}:".implode(',',$indices)."\n";
        //}

        // parse target indices
        $parsedTargetIndices = $this->parseIndices($target);
        //echo "targetIndices:".implode(',',$parsedTargetIndices)."\n";
        foreach($parsedTargetIndices as $index) {
            if(!array_key_exists($index,$allIndices)) {
                throw new InvalidArgumentException(
                    'The target index is not included in the input array argument.: '.
                    'Input indices is ('.implode(',',array_keys($allIndices)).'), '.
                    'Target indices('.implode(',',$parsedTargetIndices).')'
                );
            }
        }
        $allIndices = array_keys($allIndices);
        //echo "allIndices:".implode(',',$allIndices)."\n";

        // check input indices
        if(count($parsedIndicesList)!=count($arrays)) {
            throw new InvalidArgumentException(
                'The number of input arrays in the einsum expression does not match the number of input arrays in the argument.');
        }
        $sizeOfAllIndices = [];
        foreach(array_map(null,$parsedIndicesList,$arrays) as $i => [$indices,$array]) {
            if(count($indices)!=$array->ndim()) {
                throw new InvalidArgumentException(
                    'Number of input indices for '.$i.'th einsum does not match rank of array: '.
                    'Input indices is ('.implode(',',$indices).'), '.
                    'shape of array is ('.implode(',',$array->shape()).')'
                );
            }
            foreach(array_map(null,$indices,$array->shape()) as [$index,$size]) {
                if(array_key_exists($index,$sizeOfAllIndices)) {
                    if($sizeOfAllIndices[$index]!=$size) {
                        throw new InvalidArgumentException(
                            'Size of input indices for '.$i.'th einsum does not match size of array: '.
                            'Input indices is ('.implode(',',$indices).'), '.
                            'shape of array is ('.implode(',',$array->shape()).'), '.
                            'index "'.$index.'" must be '.$sizeOfAllIndices[$index].'.'
                        );
                    }
                } else {
                    $sizeOfAllIndices[$index] = $size;
                }
            }
        }

        // build target array
        foreach($parsedTargetIndices as $index) {
            $targetShape[] = $sizeOfAllIndices[$index];
        }

        // complie labels
        $labels = array_keys($sizeOfAllIndices);
        $orig = $parsedIndicesList;
        $parsedIndicesList = [];
        foreach($orig as $parsedIndices) {
            $count = count($parsedIndices);
            for($i=0;$i<$count;$i++) {
                $parsedIndices[$i] = array_search($parsedIndices[$i],$labels);
            }
            $parsedIndicesList[] = $parsedIndices;
        }
        $count = count($parsedTargetIndices);
        for($i=0;$i<$count;$i++) {
            $parsedTargetIndices[$i] = array_search($parsedTargetIndices[$i],$labels);
        }
        $sizeOfAllIndices = array_values($sizeOfAllIndices);

        // regenerate einsum equation
        $equation = '';
        $chrA = ord('a');
        foreach($parsedIndicesList as $indices) {
            if($equation!=='') {
                $equation .= ',';
            }
            foreach($indices as $index) {
                $equation .= chr($chrA+$index);
            }
        }
        $equation .= '->';
        foreach($parsedTargetIndices as $index) {
            $equation .= chr($chrA+$index);
        }

        return [$equation,$sizeOfAllIndices,$parsedIndicesList,$parsedTargetIndices,$targetShape];
    }

    protected function parseIndices(
        string $indices
    )
    {
        $indices = strtolower($indices);
        if(preg_match('/[^a-z]/',$indices)==1) {
            throw new InvalidArgumentException("The array index contains non-alphabetical characters.: {$indices}");
        }
        return str_split($indices);
    }

    protected function genericEinsum(
        int $depth,
        array $indices,
        array $sizeOfIndices,
        array $inputIndicesList,
        array $outputIndices,
        NDArray $outputs,
        NDArray ...$inputs
    ) : void
    {
        if($depth < count($sizeOfIndices)-1) {
            //$currentLabel = array_keys($sizeOfIndices)[$depth];
            $currentLabel = $depth;
            $count = $sizeOfIndices[$currentLabel];
            for($current=0;$current<$count;$current++) {
                $indices[$currentLabel] = $current;
                $this->genericEinsum(
                    $depth+1,$indices,
                    $sizeOfIndices,$inputIndicesList,$outputIndices,
                    $outputs,
                    ...$inputs
                );
            }
            return;
        }
        //echo "begin genericEinsum bottom\n";
        //$currentLabel = array_keys($sizeOfIndices)[$depth];
        $currentLabel = $depth;
        $count = $sizeOfIndices[$currentLabel];
        for($current=0;$current<$count;$current++) {
            //echo "currentLabel=$currentLabel\n";
            $indices[$currentLabel] = $current;
            $value = 1;
            //echo "indices=[".implode(',',$indices)."]\n";
            foreach(array_map(null,$inputs,$inputIndicesList) as $i => [$inputArray,$inputIndices]) {
                $index = 0;
                //echo "inputArray[$i]=(".implode(',',$inputIndices).")=(".implode(',',$inputArray->shape()).")\n";
                foreach(array_map(null,$inputArray->shape(),$inputIndices) as [$size,$label]) {
                    //echo "size=$size,currentIndex=".$indices[$label];
                    $index *= $size;
                    $index += $indices[$label];
                    //echo ",linearIndex=".$index."\n";
                }
                $value *= $inputArray->buffer()[$index];
            }
            $index = 0;
            foreach(array_map(null,$outputs->shape(),$outputIndices) as [$size,$label]) {
                $index *= $size;
                $index += $indices[$label];
            }
            $outputs->buffer()[$index] = $outputs->buffer()[$index] + $value;
        }
        //echo "end genericEinsum bottom\n";
    }

    public function einsum(
        string $equation,
        NDArray ...$arrays,
    ) : NDArray
    {
        [$formatedEquation,$sizeOfAllIndices,$parsedIndicesList,$parsedTargetIndices,$targetShape] = $this->parseEinsum($equation, ...$arrays);
        $outputs = $this->mo->zeros($targetShape,dtype:$arrays[0]->dtype());
        var_dump($formatedEquation);
        $this->genericEinsum(
            0,[],
            $sizeOfAllIndices,$parsedIndicesList,$parsedTargetIndices,
            $outputs,
            ...$arrays
        );
        return $outputs;
    }
}

$math = new Math($mo);
$x = $mo->array([[1,2],[3,4]]);
$y = $mo->array([[5,6],[7,8]]);

$z = $math->einsum(' ij , ik -> i ',$x,$y);

echo $mo->toString($x,indent:true)."\n";
echo $mo->toString($y,indent:true)."\n";
echo $mo->toString($z,indent:true)."\n";
