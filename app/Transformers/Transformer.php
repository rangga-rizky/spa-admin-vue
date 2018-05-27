<?php

namespace App\Transformers;

abstract class Transformer {

    /**
     * Transform a collection of items
     * 
     * @param $items
     * @return array
     */
    public function transformCollection($items)
    {
        return $items->map(function($item){
            return $this->transform($item);
        });
    }

    public abstract function transform($item);
}