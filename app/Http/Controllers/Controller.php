<?php

namespace App\Http\Controllers;

use Illuminate\Foundation\Bus\DispatchesJobs;
use Illuminate\Routing\Controller as BaseController;
use Illuminate\Foundation\Validation\ValidatesRequests;
use Illuminate\Foundation\Auth\Access\AuthorizesRequests;
use JWTAuth;

class Controller extends BaseController
{
    use AuthorizesRequests, DispatchesJobs, ValidatesRequests;

    public function getUser(){
    	return JWTAuth::toUser(JWTAuth::getToken());
    }

    public function respondNotFound(){
    	 return response()->json(['error' => true, 'message' => 'Resource not Found']);
    }

    protected function respondWithPagination($paginator, $data)
    {
         $data = array_merge($data, [
            'paginator' => [
                'total_count' => $paginator->total(),
                'total_pages' => ceil($paginator->total() / $paginator->perPage()),
                'current_page' => $paginator->currentPage(),
                'limit' => $paginator->perPage()
            ]
        ]);

        return response()->json($data);
     }

}
