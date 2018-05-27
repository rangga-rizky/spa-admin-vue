<?php

namespace App\Transformers;


class ItemTransformer extends Transformer {

    public function transform($data)
    {        
        
        return [
            'id' => $data['id'],
            'name' => $data['name'],  
            'stock' => $data['stock'],  
            'unit' => $data["unit"],
            'last_updated_by' => $data->user["name"],
            'created_at' => $data->getReadableCreatedAt(),
            'updated_at' => $data->getReadableUpdatedAt(), 
        ];
    }
}
