<?php

namespace App\Transformers;


class ProductTransformer extends Transformer {

    public function transform($data)
    {        
        if(!empty($data["image_path"])){
            $smallPath = url('images/products/small/'.$data["image_path"]);
            $largePath = url('images/products/large/'.$data["image_path"]);
        }else{
            $smallPath = "";
            $largePath = "";
        }
        
        return [
            'id' => $data['id'],
            'name' => $data['name'],  
            'price' => $data['price'],  
            'description' => $data["description"],
            'small_image_path' => $smallPath,
            'large_image_path' => $largePath,
            'last_updated_by' => $data->user["name"],
            'created_at' => $data->getReadableCreatedAt(),
            'updated_at' => $data->getReadableUpdatedAt(), 
        ];
    }
}
