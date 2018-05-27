<?php

namespace App;

use Illuminate\Notifications\Notifiable;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Tymon\JWTAuth\Contracts\JWTSubject;

class User extends Authenticatable 
{
    use Notifiable;

     protected $fillable = [
        'name', 'email', 'password', 'is_verified'
    ];
    
      protected $hidden = [
        'password', 'remember_token',
    ];

    
  
  


}
