<?php
namespace Rindow\Stdlib\Collection\Sequence;

use IteratorAggregate;
use Countable;
use Traversable;
use RuntimeException;

/**
 * @implements IteratorAggregate<int, int|float>
 */
class Range implements IteratorAggregate,Countable
{
    protected int $start;
    protected int $limit;
    protected int $delta;

    public function __construct(
        int $limit,
        int $start=null,
        int $delta=null
    ) {
        if($delta!==null && $delta==0) {
            throw new RuntimeException('infinite times');
        }
        $this->limit = $limit;
        $this->start = $start ?? 0;
        $this->delta = $delta ?? (($limit>=$start)? 1 : -1);
    }

    public function start() : int
    {
        return $this->start;
    }

    public function limit() : int
    {
        return $this->limit;
    }

    public function delta() : int
    {
        return $this->delta;
    }

    public function getIterator() : Traversable
    {
        $index = 0;
        $value = $this->start;
        if($this->delta > 0) {
            while($value < $this->limit) {
                yield $index => $value;
                $index++;
                $value += $this->delta;
            }
        } else {
            while($value > $this->limit) {
                yield $index => $value;
                $index++;
                $value += $this->delta;
            }
        }
    }

    public function count() : int
    {
        $start = $this->start;
        $limit = $this->limit;
        $delta = $this->delta;

        $count = intdiv($limit-$start,$delta);
        return $count;
    }

    public function has(int $item) : bool
    {
        $start = $this->start;
        $limit = $this->limit;
        $delta = $this->delta;

        if($delta>0) {
            if($start>$item||$limit<=$item) {
                return false;
            }
        } else {
            if($start<$item||$limit>=$item) {
                return false;
            }
        }
        return ($item-$start)%$delta == 0;
    }
}
