<?php

namespace App\Helper;

use Image;

class ImageHandler 
{
	
	public static function upload($image,$path){
		try{            
	        $name = time().'.'.$image->getClientOriginalExtension();

	       	$image_resize = Image::make($image->getRealPath());              
	   		$image_resize->resize(300, 300);
	    	$image_resize->save(public_path('/images/'.$path.'/small/' .$name));

	       	$destinationPath = public_path('/images/'.$path.'/large');
	       	$image->move($destinationPath, $name);
        }catch(\Exception $e){
            return null;
        }     

       	return $name;
	}	
}