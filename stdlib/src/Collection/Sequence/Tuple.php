<?php
namespace Rindow\Stdlib\Collection\Sequence;

use InvalidArgumentException;

class Tuple
{
    protected readonly array $items;

    public function __construct(array $items)
    {
        if(!array_is_list($items)) {
            throw new InvalidArgumentException('Array must be list.');
        }
        $this->items = $items;
    }

    public function matches($value, bool $strict = false): int
    {
        if ($strict) {
            return count(array_filter($this->items, function ($item) use ($value) {
                return $item === $value;
            }));
        } else {
            return count(array_filter($this->items, function ($item) use ($value) {
                return $item == $value;
            }));
        }
    }

    public function indexOf($value, bool $strict = false): int
    {
        if ($strict) {
            return array_search($value, $this->items, true);
        } else {
            return array_search($value, $this->items, false);
        }
    }
}
  