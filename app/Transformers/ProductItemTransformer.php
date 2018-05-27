<?php

namespace App\Transformers;


class ProductItemTransformer extends Transformer {

    public function transform($data)
    {        
        
        return [
            'id' => $data['id'],
            'product' => $data->product['name'],  
            'product_id' => $data->product['id'],  
            'item' => $data->item['name'], 
            'item_id' => $data->item['id'],  
            'qty' => $data["qty"],
        ];
    }
}
