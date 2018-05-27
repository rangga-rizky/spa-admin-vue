<?php

namespace App\Transformers;


class TransactionTransformer extends Transformer {

    public function transform($data)
    {        
        
        return [
            'id' => $data['id'],
            'total_price' => $data['total_price'],  
            'total_amount' => $data['total_amount'],  
            'user' => $data->user["name"],
            'created_at' => $data->getReadableCreatedAt(),
            'updated_at' => $data->getReadableUpdatedAt(), 
        ];
    }
}
