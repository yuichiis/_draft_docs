<?php
namespace Rindow\Stdlib\Collection;

use ArrayAccess;
use Countable;

/**
 * @template T
 * @implements iterable<T>
 */
interface Sequence extends ArrayAccess,Countable
{
    public function has(mixed $item) : bool;
    public function add(Sequence $sequence) : Sequence;
    public function mul(Sequence $sequence) : Sequence;
    public function max() : mixed;
    public function min() : mixed;
    public function indexof(mixed $item) : int;
    public function matches(mixed $item) : int;
}