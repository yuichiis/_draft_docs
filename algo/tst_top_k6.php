<?php
require_once __DIR__.'/../../rindow-math-matrix/vendor/autoload.php';

use Interop\Polite\Math\Matrix\OpenCL;
use Interop\Polite\Math\Matrix\NDArray;
use Interop\Polite\Math\Matrix\DeviceBuffer;
use Rindow\Math\Matrix\MatrixOperator;

class TopK
{
    private object $service;
    private object $cl;
    private object $context;
    private object $queue;

    /** @var array<string,string> $source */
    protected array $sources = [];
    /** @var array<string,object> $program */
    protected array $program = [];
    /** @var array<int> $maxWorkItem */
    protected array $maxWorkItem;
    protected int $localMemSize;

    public function __construct(object $service,object $queue)
    {
        $this->service = $service;
        $this->cl = $service->opencl();
        $this->queue = $queue;
        $this->context = $queue->getContext();
        $devices = $this->context->getInfo(OpenCL::CL_CONTEXT_DEVICES);
        $this->maxWorkItem = $devices->getInfo(0,OpenCL::CL_DEVICE_MAX_WORK_ITEM_SIZES);
        $this->localMemSize = $devices->getInfo(0,OpenCL::CL_DEVICE_LOCAL_MEM_SIZE);
        
    }

    private function source() : string
    {
        $source = <<<EOT
        void topkSwapFloat(
            __local float *a,
            __local float *b
            ) 
        {
            float tmp = *a;
            *a = *b;
            *b = tmp;
        }
    
        void topkSwapInt(
            __local int *a,
            __local int *b
            ) 
        {
            int tmp = *a;
            *a = *b;
            *b = tmp;
        }
    
        void topkMinHeapify(
            int size,
            __local float *heap,
            __local int *indices,
            int parent
            )
        {
            //echo sprintf("========================\\n");
            //echo sprintf("minHeapify: size=%d parent=%d\\n",size,parent);
            int left = 2 * parent + 1;
            int right = 2 * parent + 2;
            //echo sprintf("parent=%d left=%d, right=%d\\n",parent,left,right);
        
            while (left < size) {
                //if(right < size) {
                //    echo sprintf("*left:%d =%4.1f *right:%d =%4.1f\\n",left,heap[left],right,heap[offsetHeat+right]);
                //} else {
                //    echo sprintf("*left:%d =%4.1f *right:%d = NONE\\n",left,heap[offsetHeat+left],right);
                //}
                int smallest;
                if (right < size && heap[right] < heap[left]) {
                    //echo sprintf("right is smaller\\n");
                    smallest = right;
                } else {
                    //echo sprintf("left is smaller\\n");
                    smallest = left;
                }
        
                //echo sprintf("*parent:%d =%4.1f *smaller:%d =%4.1f\\n",parent,heap[parent],smallest,heap[smallest]);
                if (heap[parent] <= heap[smallest]) {
                    //echo sprintf("parent is smallest\\n");
                    break;
                }
                //echo sprintf("parent is not smallest\\n");
                //echo sprintf("swap: parent:%d:%4.1f, smallest:%d:%4.1f\\n",parent,heap[parent],smallest,heap[smallest]);
                topkSwapFloat(&heap[parent],&heap[smallest]);
                topkSwapInt(&indices[parent],&indices[smallest]);
                //echo sprintf("*parent:%d =%4.1f *smallest:%d =%4.1f\\n",parent,heap[parent],smallest,heap[smallest]);
    
                parent = smallest;
                left = 2 * parent + 1;
                right = 2 * parent + 2;
                //echo sprintf("parent=%d left=%d, right=%d\\n",parent,left,right);
            }
        }

        __kernel void topkFindTopNumbers(
            int size,
            __global const float * inputs,
            int offsetInputs,
            int k,
            int sorted,
            __global       float * values,
            int offsetValues,
            __global       int * indices,
            int offsetIndices,
            __local        float * valuesHeap,
            __local        int * indicesHeap
            )
        {
            int gid0 = get_global_id(0);
            int gid1 = get_global_id(1);
            int grid0 = get_group_id(0);
            int grid1 = get_group_id(1);
            int lid0 = get_local_id(0);
            int lid1 = get_local_id(1);
            int grsz0 = get_num_groups(0);
            int grsz1 = get_num_groups(1);
            int lsz0 = get_local_size(0);
            int lsz1 = get_local_size(1);

            //printf("gid=[%d,%d],grid=[%d,%d],lid=[%d,%d],grsz=[%d,%d],lsz=[%d,%d]\\n",
            //    gid0,gid1,grid0,grid1,lid0,lid1,grsz0,grsz1,lsz0,lsz1);

            int batchid = gid0 / lsz0;
            int thid = lid0;
            int groups = lsz0;

            int rowOffset = offsetInputs+batchid*size;
            int heapOffset = k*thid;
            // copy first elements
            for(int i=0; i<k; ++i) {
                if(i*groups+thid<size) {
                    valuesHeap[heapOffset+i] = inputs[rowOffset+i*groups+thid];
                    indicesHeap[heapOffset+i] = i*groups+thid;
                } else {
                    valuesHeap[heapOffset+i] = -INFINITY;
                    indicesHeap[heapOffset+i] = 0;
                }
            }

            // Build minimum heap with first TOP_NUM element
            for(int i=k/2-1; i>=0; --i) {
                topkMinHeapify(k, &valuesHeap[heapOffset], &indicesHeap[heapOffset], i);
            }

            // Process remaining elements
            for(int i=k*groups+thid; i<size; i+=groups) {
                if(inputs[rowOffset+i] > valuesHeap[heapOffset]) {
                    //printf("batch=%d, rowOffset=%d, th=%d, i=%d, data=%f\\n",batchid,rowOffset,thid,i,inputs[rowOffset+i]);
                    valuesHeap[heapOffset] = inputs[rowOffset+i];
                    indicesHeap[heapOffset] = i;
                    topkMinHeapify(k, &valuesHeap[heapOffset], &indicesHeap[heapOffset], 0);
                }
            }
            barrier(CLK_LOCAL_MEM_FENCE);

            if(thid==0) {
                // Rebuild minimum heap for all groups
                for(int i = (k*groups)/2-1; i >= 0; --i) {
                    topkMinHeapify(k, valuesHeap, indicesHeap, i);
                }
                // Merge heap
                for(int i = k; i < (k*groups); ++i) {
                    if (valuesHeap[i] > valuesHeap[0]) {
                        valuesHeap[0] = valuesHeap[i];
                        indicesHeap[0] = indicesHeap[i];
                        topkMinHeapify(k, valuesHeap, indicesHeap, 0);
                    }
                }
            }
            
            if(sorted && thid==0) {
                // sort
                for(int i = k - 1; i > 0; --i) {
                    topkSwapFloat(&valuesHeap[0],&valuesHeap[i]);
                    topkSwapInt(&indicesHeap[0],&indicesHeap[i]);
                    topkMinHeapify(i, valuesHeap, indicesHeap, 0);
                }
            }

            barrier(CLK_LOCAL_MEM_FENCE);

            // copy result to global
            for(int i=thid; i<k; i += groups) {
                values[offsetValues+batchid*k+i] = valuesHeap[i];
                indices[offsetIndices+batchid*k+i] = indicesHeap[i];
            }

            // copy debug to global
            //for(int i=0; i<k; ++i) {
            //    values[offsetValues+batchid*k*groups+k*thid+i] = valuesHeap[k*thid+i];
            //    indices[offsetIndices+batchid*k*groups+k*thid+i] = indicesHeap[k*thid+i];
            //}
        }
    
EOT;
        return $source;
    }

    protected function adjBoundary(int $bytes) : int
    {
        $bytes += ($bytes%4) ? 4-($bytes%4) : 0; // Adjust word boundary
        return (int)$bytes;
    }

    protected function createKernel(string $name) : object
    {
        if(!isset($this->program[$name])) {
            $source = $this->sources[$name];
            $program = $this->service->opencl()->Program($this->context,$source);
            try {
                $program->build();
            } catch (\RuntimeException $e) {
                echo get_class($e)."\n";
                echo $e->getMessage();
                if($e->getCode()==OpenCL::CL_BUILD_PROGRAM_FAILURE) {
                    echo "CL_PROGRAM_BUILD_STATUS=".$program->getBuildInfo(OpenCL::CL_PROGRAM_BUILD_STATUS)."\n";
                    echo "CL_PROGRAM_BUILD_OPTIONS=".$program->getBuildInfo(OpenCL::CL_PROGRAM_BUILD_OPTIONS)."\n";
                    echo "CL_PROGRAM_BUILD_LOG=".$program->getBuildInfo(OpenCL::CL_PROGRAM_BUILD_LOG)."\n";
                    echo "CL_PROGRAM_BINARY_TYPE=".$program->getBuildInfo(OpenCL::CL_PROGRAM_BINARY_TYPE)."\n";
                }
                throw $e;
            }
            $this->program[$name] = $program;
        } else {
            $program = $this->program[$name];
        }
        $kernel = $this->service->opencl()->Kernel($program,$name);
        return $kernel;
    }

    public function topk(
        int $m,
        int $n,
        DeviceBuffer $inputs, int $offsetInputs,
        int $k,
        bool $sorted,
        DeviceBuffer $values, int $offsetValues,
        DeviceBuffer $indices, int $offsetIndices,
        object $events, object $waitEvents=null,
        ) : void
    {
        //$this->assertShapeParameter("m", $m);
        //$this->assertShapeParameter("n", $n);
        //$this->assertShapeParameter("k", $k);
        //$this->assertMatrixBufferSpec("inputs", $inputs, $m,$n, $offsetInputs, $n);
        //$this->assertMatrixBufferSpec("values", $values, $m,$k, $offsetValues, $k);
        //$this->assertMatrixBufferSpec("indices", $indices, $m,$k, $offsetIndices, $k);

        if($indices->dtype()!=NDArray::int32) {
            throw new InvalidArgumentException('dtype of indices must be int32.');
        }
        if($k>$n) {
            throw new InvalidArgumentException('size must be greater or equal k.');
        }
        $sorted = $sorted ? 1 : 0;

        $groups = (int)floor(sqrt($n/$k));
        $groupsByMemlimit = intdiv($this->localMemSize,$k*($values->value_size()+$indices->value_size()));
        if($groups>$groupsByMemlimit) {
            $groups = $groupsByMemlimit;
        }
        if($groups>$this->maxWorkItem[0]) {
            $groups = $this->maxWorkItem[0];
        }

        //$total_local_items = $n;
        //$max_work_items = $this->maxWorkItem[0];
        //if($total_local_items>$max_work_items) {
        //    throw new InvalidArgumentException('too large array');
        //} else {
        //    for($max_work_items=1; $max_work_items<$total_local_items;$max_work_items<<=1) {
        //        ;
        //    }
        //}

        //$groups = 16;

        //echo "groups=$groups\n";

        $kernel_name = 'topkFindTopNumbers';
        $this->sources[$kernel_name] = $this->source();
        $kernel = $this->createKernel($kernel_name);
        $kernel->setArg(0,$n,NDArray::int32);
        $kernel->setArg(1,$inputs);
        $kernel->setArg(2,$offsetInputs,NDArray::int32);
        $kernel->setArg(3,$k,NDArray::int32);
        $kernel->setArg(4,$sorted,NDArray::int32);
        $kernel->setArg(5,$values);
        $kernel->setArg(6,$offsetValues,NDArray::int32);
        $kernel->setArg(7,$indices);
        $kernel->setArg(8,$offsetIndices,NDArray::int32);
        $kernel->setArg(9,null,$this->adjBoundary($k*$values->value_size())*$groups);
        $kernel->setArg(10,null,$this->adjBoundary($k*$indices->value_size())*$groups);

        $global_work_size = [$m*$groups];
        $local_work_size = [$groups];
        $kernel->enqueueNDRange($this->queue,$global_work_size,$local_work_size,null,
                $events,$waitEvents);
    }
}

$mo = new MatrixOperator();
$lacl = $mo->laAccelerated('clblast',['deviceType'=>OpenCL::CL_DEVICE_TYPE_GPU]);
$cl = $lacl->service()->opencl();
$topk = new TopK($lacl->service(),$lacl->getQueue());

$m = 64;
$n = 50000;
$k = 10;
$sorted = true;
$epochs = 1000;
$inputs = $lacl->randomUniform([$m,$n],0.0,1000.0,dtype:NDArray::float32);

// imidiate
//$m = 3;
//$n = 16;
//$k = 5;
//$epochs = 1;
//$sorted = false;
//$inputs = $lacl->array([
//    [7,8,10,11, 12,13,14,15, 4,5,1,2,     3,0,6,9,    ],
//    [2,3,4,5,   1,9,7,8,     6,0,10,11,   12,13,14,15,],
//    [5,1,2,3,   4,6,7,8,     12,13,14,15, 9,0,10,11,  ],
//],dtype:NDArray::float32);
$values = $lacl->alloc([$m,$k],dtype:NDArray::float32);
$indices = $lacl->alloc([$m,$k],dtype:NDArray::int32);

$events = $cl->EventList();
$startTime = microtime(true);
for($i=0;$i<$epochs;++$i) {
    $topk->topK(
        $m,$n,
        $inputs->buffer(),$inputs->offset(),
        $k,$sorted,
        $values->buffer(),$values->offset(),
        $indices->buffer(),$indices->offset(),
        $events
    );
    $events->wait();
}
$endTime = microtime(true);
$valuesND = $lacl->toNDArray($values);
$indicesND = $lacl->toNDArray($indices);
echo "time=".(($endTime-$startTime))."\n";
//echo $mo->toString($inputs,format:'%6.1f',indent:true)."\n";
//echo $mo->toString($valuesND,format:'%6.1f',indent:true)."\n";
//echo $mo->toString($indicesND,format:'%6d',indent:true)."\n";
//var_dump($values->toArray());
//var_dump($indices->toArray());
