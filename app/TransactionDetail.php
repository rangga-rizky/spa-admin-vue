<?php

namespace App;
use Carbon\Carbon;
use Illuminate\Database\Eloquent\Model;

class TransactionDetail extends Model
{
	public function transaction(){
		return $this->belongsTo('App\Transaction');
	}

	public function product(){
		return $this->belongsTo('App\Product');
	}
    
	public function getReadableCreatedAt(){
		setlocale(LC_TIME, 'id_ID.UTF-8');
        return Carbon::parse($this->attributes['created_at'])->formatLocalized('%H:%S %A, %d %B %Y');
	}   

	public function getReadableUpdatedAt(){
		setlocale(LC_TIME, 'id_ID.UTF-8');
        return Carbon::parse($this->attributes['updated_at'])->formatLocalized('%H:%S %A, %d %B %Y');
	} 
}
