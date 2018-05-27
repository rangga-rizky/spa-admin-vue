<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class ProductItem extends Model
{
	public $timestamps = False;

    public function product(){
		return $this->belongsTo('App\Product');
	}

	public function item(){
		return $this->belongsTo('App\Item');
	}

}
