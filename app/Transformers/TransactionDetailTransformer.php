<?php

namespace App\Transformers;


class TransactionDetailTransformer  extends Transformer {

    public function transform($data)
    {        
        
        return [
            'id' => $data['id'],
            'product' => $data->product['name'],  
            'price' => $data['price'],  
            'sub_price' => $data["sub_price"],
            'qty' => $data["qty"],
            'created_at' => $data->getReadableCreatedAt(),
            'updated_at' => $data->getReadableUpdatedAt(), 
        ];
    }
}
