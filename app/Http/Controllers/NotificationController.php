<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Transformers\NotificationTransformer;

class NotificationController extends Controller
{
    public function __construct(NotificationTransformer $notificationTransformer){
        $this->notificationTransformer = $notificationTransformer;
    }

    public function index(){
        $notifications = auth()->user()->unreadNotifications()->limit(5)->get();
        return response()->json($this->notificationTransformer->transformCollection ($notifications));
    }   
    


    public function read(Request $request,$id){
        $notification = $request->user()->notifications()->where('id', $id)->first();
        if($notification) {
            $notification->markAsRead();
        }
        return response()->json(["error" => false]);
    }
}
