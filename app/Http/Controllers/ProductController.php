<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Product;
use App\Helper\ImageHandler;
use App\Http\Requests\ProductRequest;
use App\Transformers\ProductTransformer;

class ProductController extends Controller
{
    
    public function __construct(Product $product,ProductTransformer $productTransformer){
        $this->product = $product;
        $this->productTransformer = $productTransformer;
    }

    public function index(Request $request)
    {
        $limit = $request->input('limit') ?: 5;
        $products = $this->product->paginate($limit);
        return  $this->respondWithPagination($products, [
            'data' =>  $this->productTransformer->transformCollection($products)
        ]);
    }

    public function array_data(){
        $products = $this->product->orderBy('id')->select("id","name","price")->get(); 
        return response()->json($products);
    }

     public function searchByName($name){
        $products = $this->product->orderBy('name')->select("id","name","price")->where('name', 'like', '%' . $name . '%')->get(); 
        return response()->json($products);
    }

    
    public function store(productRequest $request)
    {
        $user = $this->getUser();
        if ($request->hasFile('images')) {
        	$image_name = ImageHandler::upload($request->file('images'),'products');
        	if(is_null($image_name)){
        		return response()->json(['error' => true, 'message' => 'There is problem with image']);
        	}
        	$this->product->image_path = $image_name;
        }
        $this->product->name = $request->name;
        $this->product->price = $request->price;
        $this->product->description = $request->description;
        $this->product->last_updated_by = $user->id;;
        try{            
            $this->product->save();
        }catch(\Exception $e){
        	//dd($e);
            return response()->json(['error' => true, 'message' => 'There is problem on server']);
        }

        return response()->json(['error' => false, 'message' => 'product success created']);
  
    }

    
    public function show($id)
    {
        $product = $this->product->find($id);  
        if(empty($product)){
            return $this->respondNotFound();
        }
        return response()->json($this->productTransformer->transform($product));
    }
    
    
    public function update(productRequest $request, $id)
    {
        $user = $this->getUser();
        $product = $this->product->find($id);  
        if(empty($product)){
            return $this->respondNotFound();
        }
          if ($request->hasFile('images')) {
        	$image_name = ImageHandler::upload($request->file('images'),'products');
        	if(is_null($image_name)){
        		return response()->json(['error' => true, 'message' => 'There is problem with image']);
        	}
        	$product->image_path = $image_name;
        }
        $product->name = $request->name;
        $product->price = $request->price;
        $product->description = $request->description;
        $product->last_updated_by = $user->id;

         try{            
            $product->save();
        }catch(\Exception $e){
            return response()->json(['error' => true, 'message' => 'There is problem on server']);
        }

        return response()->json(['error' => false, 'message' => 'product successfully updated']);
    }

    
    public function destroy($id)
    {
        $product = $this->product->find($id);
        if(empty($product)){
            return $this->respondNotFound();
        }
        try{            
            $product->delete();
        }catch(\Exception $e){
            if($e->getCode() == "23000"){
                return response()->json(['error' => true, 'message' => 'Failed, Other Data Refrence this data']);
            }
            return response()->json(['error' => true, 'message' => 'There is problem on server']);
        }

        return response()->json(['error' => false, 'message' => 'product success deleted']);
  
    }
}
