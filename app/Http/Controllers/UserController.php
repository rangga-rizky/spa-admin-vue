<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Transformers\UserTransformer;

class UserController extends Controller
{
   
    public function __construct(UserTransformer $userTransformer){
        $this->userTransformer = $userTransformer;
    }

    public function getCurrent(){
        $user = auth()->user();
        return response()->json($this->userTransformer->transform($user));
    }


    
}
