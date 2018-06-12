<?php

namespace App\Transformers;


class NotificationTransformer extends Transformer {

    public function transform($data)
    {        
        
        return [
            "user_id" => $data["data"]["user_id"],
            "username" => $data["data"]["user_name"],
            "id" => $data["id"]
        
        ];
    }
}
