<?php

namespace App\Transformers;


class UserTransformer extends Transformer {

    public function transform($data)
    {        
        
        return [
            'id' => $data['id'],
            'name' => $data['name'],  
            'email' => $data['email'],  
        ];
    }
}
