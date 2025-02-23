<?php
include __DIR__.'/../../rindow-neuralnetworks/vendor/autoload.php';

use Interop\Polite\Math\Matrix\NDArray;
use Interop\Polite\Math\Matrix\NDArrayPhp;

$mo = new Rindow\Math\Matrix\MatrixOperator();
$la = $mo->la();


class Math
{
    protected object $mo;
    protected Service $service;
    protected int $defaultFloatType = NDArray::float32;
    public function __construct(object $mo)
    {
        $this->mo = $mo;
        $this->service = $mo->service();
    }

    protected function parseIndices(
        string $indicesString,
    ) : array
    {
        //$indices = strtolower($indices);
        while(true) {
            // alphabets only
            $count = preg_match('/^([a-zA-Z]+)$/',$indicesString,$matches);
            if($count==1) {
                $placeholder = null;
                break;
            }
            // alphabets with left placeholder
            $count = preg_match('/^\\.\\.\\.([a-zA-Z]+)$/',$indicesString,$matches);
            if($count==1) {
                $placeholder = 'L';
                break;
            }
            // alphabets with right placeholder
            $count = preg_match('/^([a-zA-Z]+)\\.\\.\\.$/',$indicesString,$matches);
            if($count==1) {
                $placeholder = 'R';
                break;
            }
            // placeholder only
            $count = preg_match('/^\\.\\.\\.$/',$indicesString,$matches);
            if($count==1) {
                $placeholder = 'L';
                $matches[1] = '';
                break;
            }
            throw new InvalidArgumentException("The array index contains non-alphabetical characters.: {$indicesString}");
        }
        return [str_split($matches[1]),$placeholder]; // with right placeholder
    }

    protected function parseEinsum(
        string $equation,
        NDArray ...$arrays,
    ) : array
    {
        $equation = str_replace(' ','',$equation);
        $parts = explode('->',$equation);
        $mode = count($parts); 
        if($mode==1) {          // implicit mode
            $sumEquation = $parts[0];
        } elseif($mode==2) {    // explicit mode
            [$sumEquation,$target] = $parts;
        } else {
            throw new InvalidArgumentException('One "->" symbol is required in the formula string.');
        }

        // parse input indices
        $indicesList = explode(',',$sumEquation);
        if(count($indicesList)!=count($arrays)) {
            throw new InvalidArgumentException('The number of given sequences does not match the number of sequences written in the equation.');
        }
        $parsedIndicesList = [];
        $allIndices = [];
        foreach($indicesList as $indices) {
            [$parsedIndices,$placeholder] = $this->parseIndices($indices);
            $parsedIndicesList[] = $parsedIndices;
            $placeholderList[] = $placeholder;
            foreach($parsedIndices as $index) {
                if(array_key_exists($index,$allIndices)) {
                    $allIndices[$index] += 1;
                } else {
                    $allIndices[$index] = 1;
                }
            }
        }

        if($mode==2) {
            /////////////////////
            // explicit mode 
            /////////////////////
            // parse target indices
            if($target==='') {
                $parsedTargetIndices = [];
                $tagetPlaceholder = null;
            } else {
                [$parsedTargetIndices,$tagetPlaceholder] = $this->parseIndices($target);
            }
            foreach($parsedTargetIndices as $index) {
                if(!array_key_exists($index,$allIndices)) {
                    throw new InvalidArgumentException(
                        'The target index is not included in the input array argument.: '.
                        'Input indices is ('.implode(',',array_keys($allIndices)).'), '.
                        'Target indices('.implode(',',$parsedTargetIndices).')'
                    );
                }
            }
        } else {
            /////////////////////
            // implicit mode 
            /////////////////////
            $parsedTargetIndices = [];
            $tagetPlaceholder = null;
            $numTensor = count($parsedIndicesList);
            if($numTensor>=2) {
                // muilt tensor mode
                foreach($allIndices as $index => $count) {
                    if($numTensor!=$count) {
                        $parsedTargetIndices[] = $index;
                    }
                }
            } else {
                // single tensor mode
                foreach($allIndices as $index => $count) {
                    if($numTensor==$count) {
                        $parsedTargetIndices[] = $index;
                    }
                }
            }
            sort($parsedTargetIndices,SORT_STRING);
        }
        $allIndices = array_keys($allIndices);

        // check input indices
        if(count($parsedIndicesList)!=count($arrays)) {
            throw new InvalidArgumentException(
                'The number of input arrays in the einsum expression does not match the number of input arrays in the argument.');
        }

        ///////////////////////////////////////////////////////
        // build sizes of index and sizes of placeholder index
        ///////////////////////////////////////////////////////
        $sizeOfAllIndices = [];
        $sizeOfPlaceholderIndices = [];
        foreach(array_map(null,$parsedIndicesList,$placeholderList,$arrays) as $i => [$indices,$placeholder,$array]) {
            $numIndices = count($indices);
            if($placeholder===null) {
                if($numIndices!=$array->ndim()) {
                    throw new InvalidArgumentException(
                        'Number of input indices for '.$i.'th einsum does not match rank of array: '.
                        'Input indices is ('.implode(',',$indices).'), '.
                        'shape of array is ('.implode(',',$array->shape()).')'
                    );
                }
            } else {
                if($numIndices>$array->ndim()) {
                    throw new InvalidArgumentException(
                        "too many indices for array {$i} in equation: {$equation}"
                    );
                }
            }
            $shape = $array->shape();
            if($placeholder=='L') {
                $offsetPos = $array->ndim()-$numIndices;
            } else {
                $offsetPos = 0;
            }
            // collect each shape size
            foreach($indices as $pos => $index) {
                $size = $shape[$offsetPos+$pos];
                // specified index mark
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
            // wild index mark of placeholder
            if($placeholder!=null) {
                if($placeholder=='L') {
                    $wildIndexSizes = array_slice($array->shape(),0,$array->ndim()-$numIndices);
                    $wildIndexSizes = array_reverse($wildIndexSizes);
                    // reverse sizeOfPlaceholderIndices because proceeding from left to right. 
                    $sizeOfPlaceholderIndices = array_reverse($sizeOfPlaceholderIndices);
                } elseif($placeholder=='R') {
                    $wildIndexSizes = array_slice($array->shape(),$numIndices);
                } else {
                    throw new LogicException("illegal placeholder mark: {$placeholder}");
                }
                foreach($wildIndexSizes as $pos => $size) {
                    if(array_key_exists($pos, $sizeOfPlaceholderIndices)) {
                        if($sizeOfPlaceholderIndices[$pos] == 1) {
                            $sizeOfPlaceholderIndices[$pos] = $size;
                        } else {
                            if($sizeOfPlaceholderIndices[$pos]!=$size && $size!=1) {
                                throw new InvalidArgumentException(
                                    'Size of broadcast indices for '.$i.'th einsum does not match size of array: '.
                                    'Equation is "'.$equation.'", '.
                                    'shape of array is ('.implode(',',$array->shape()).'), '.
                                    'wild index size "'.$size.'" must be '.$sizeOfPlaceholderIndices[$pos].'.'
                                );
                            }
                        }
                    } else {
                        $sizeOfPlaceholderIndices[$pos] = $size;
                    }
                }
                if($placeholder=='L') {
                    // Return to normal order of reversed sizeOfPlaceholderIndices. 
                    $sizeOfPlaceholderIndices = array_reverse($sizeOfPlaceholderIndices);
                }
            }
        }

        // assign keys of wild indices
        $orig = $sizeOfPlaceholderIndices;
        $sizeOfPlaceholderIndices = [];
        $placeholderIndices = [];
        $i=0;
        foreach($orig as $size) {
            $index = '*'.$i;
            $sizeOfPlaceholderIndices[$index] = $size;
            $placeholderIndices[] = $index;
            $i++;
        }
        // merge explicited indices and wild indices
        $sizeOfAllIndices = array_merge($sizeOfAllIndices,$sizeOfPlaceholderIndices);

        ////////////////////////////////////////////////////
        // merge explicited input indices and wild indices
        ////////////////////////////////////////////////////
        $orig = $parsedIndicesList;
        $parsedIndicesList = [];
        foreach(array_map(null, $orig, $placeholderList,$arrays) as $i => [$indices,$placeholder,$array]) {
            if($placeholder=='L') {
                $indices = array_slice(array_merge($placeholderIndices,$indices),-$array->ndim());
            } elseif($placeholder=='R') {
                $indices = array_merge($indices,array_slice($placeholderIndices,-($array->ndim()-count($indices))));
            }
            $parsedIndicesList[] = $indices;
        }

        ///////////////////////
        // build target array
        ///////////////////////
        // merge explicited output indices and wild indices
        if($tagetPlaceholder=='L') {
            $parsedTargetIndices = array_merge($placeholderIndices,$parsedTargetIndices);
        } elseif($tagetPlaceholder=='R') {
            $parsedTargetIndices = array_merge($parsedTargetIndices,$placeholderIndices);
        }
    
        $targetShape = [];
        foreach($parsedTargetIndices as $index) {
            $targetShape[] = $sizeOfAllIndices[$index];
        }
        if($tagetPlaceholder===null) {
            if(count($sizeOfPlaceholderIndices)>0) {
                throw new InvalidArgumentException("inputs contain broadcast, but output does not contain broadcast.: $equation");
            }
        } else {
            if(count($sizeOfPlaceholderIndices)==0) {
                throw new InvalidArgumentException("inputs do not contain broadcast, but output contains broadcast.: $equation");
            }
        }

        //echo "placeholderList=";
        //var_dump($placeholderList);
        //echo "parsedIndicesList=";
        //var_dump($parsedIndicesList);
        //echo "parsedTargetIndices=";
        //var_dump($parsedTargetIndices);

        // complie labels
        $labels = array_keys($sizeOfAllIndices);
        $orig = $parsedIndicesList;
        $parsedIndicesList = [];
        foreach($orig as $parsedIndices) {
            $count = count($parsedIndices);
            for($i=0;$i<$count;$i++) {
                $parsedIndices[$i] = array_search($parsedIndices[$i],$labels);
                $inputBroadcast[$i] = false;
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

        return [
            $equation,
            $sizeOfAllIndices,
            $sizeOfPlaceholderIndices,
            $parsedIndicesList,
            $parsedTargetIndices,
            $targetShape
        ];
    }

    protected function partOfEinsum(
        array $indices,
        array $sizeOfIndices,
        array $inputIndicesList,
        array $outputIndices,
        NDArray $outputs,
        NDArray ...$inputs
    ) : void
    {
        $value = 1;
        foreach(array_map(null,$inputs,$inputIndicesList) as $i => [$inputArray,$inputIndices]) {
            $index = 0;
            foreach(array_map(null,$inputArray->shape(),$inputIndices) as [$size,$label]) {
                $index *= $size;
                if($size>1) {
                    $index += $indices[$label];
                }
            }
            $index += $inputArray->offset();
            $value *= $inputArray->buffer()[$index];
        }
        $index = 0;
        if($outputs->ndim() > 0) {
            foreach(array_map(null,$outputs->shape(),$outputIndices) as [$size,$label]) {
                $index *= $size;
                $index += $indices[$label];
            }
        }
        $index += $outputs->offset();
        $outputs->buffer()[$index] = $outputs->buffer()[$index] + $value;
    }

    public function einsum(
        string $equation,
        NDArray ...$arrays,
    ) : NDArray
    {
        ///////////////////
        // parse einsum string
        ///////////////////
        [
            $formatedEquation,
            $sizeOfIndices,
            $sizeOfPlaceholderIndices,
            $inputIndicesList,
            $outputIndices,
            $targetShape
        ] = $this->parseEinsum($equation, ...$arrays);
        $outputs = $this->mo->zeros($targetShape,dtype:$arrays[0]->dtype());

        ///////////////////
        // execute eimsum
        ///////////////////
        // crawle indices
        $depth = count($sizeOfIndices);
        $indices = array_fill(0, $depth, 0);
        $isFinished = false;
        while (!$isFinished) {
            // perform on current indices
            $this->partOfEinsum(
                $indices,
                $sizeOfIndices,
                $inputIndicesList,
                $outputIndices,
                $outputs,
                ...$arrays
            );
        
            // next indices
            $i = $depth - 1;
            while ($i >= 0 && $indices[$i] == $sizeOfIndices[$i] - 1) {
                $indices[$i] = 0;
                $i--;
            }
    
            if ($i < 0) {
                // finished all
                $isFinished = true;
            } else {
                $indices[$i]++;
            }
        }

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
