<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\ProductItem;
use App\Http\Requests\ProductItemRequest;
use App\Transformers\ProductItemTransformer;


class ProductItemController extends Controller
{
     public function __construct(productItem $productItem,productItemTransformer $productItemTransformer){
        $this->productItem = $productItem;
        $this->productItemTransformer = $productItemTransformer;
    }

    public function index(Request $request)
    {
        $limit = $request->input('limit') ?: 5;
        $productItems = $this->productItem->orderBy("product_id")->paginate($limit);
        return  $this->respondWithPagination($productItems, [
            'data' =>  $this->productItemTransformer->transformCollection($productItems)
        ]);
    }

    
    public function store(Request $request)
    {
        try{            
            $this->productItem->insert($request->all());
        }catch(\Exception $e){
            return response()->json(['error' => true, 'message' => 'There is problem on server']);
        }

        return response()->json(['error' => false, 'message' => 'productItem success created']);
  
    }

    
    public function show($id)
    {
        $productItem = $this->productItem->find($id);  
        if(empty($productItem)){
            return $this->respondNotFound();
        }
        return response()->json($this->productItemTransformer->transform($productItem));
    }
    
    
    public function update(ProductItemRequest $request, $id)
    {
        $user = $this->getUser();
        $productItem = $this->productItem->find($id);  
        if(empty($productItem)){
            return $this->respondNotFound();
        }
        $productItem->product_id = $request->product_id;
        $productItem->item_id = $request->item_id;
        $productItem->qty = $request->qty;

         try{            
            $productItem->save();
        }catch(\Exception $e){
            return response()->json(['error' => true, 'message' => 'There is problem on server']);
        }

        return response()->json(['error' => false, 'message' => 'productItem successfully updated']);
    }

    
    public function destroy($id)
    {
        $productItem = $this->productItem->find($id);
        if(empty($productItem)){
            return $this->respondNotFound();
        }
        try{            
            $productItem->delete();
        }catch(\Exception $e){
            return response()->json(['error' => true, 'message' => 'There is problem on server']);
        }

        return response()->json(['error' => false, 'message' => 'productItem success deleted']);
  
    }
}
