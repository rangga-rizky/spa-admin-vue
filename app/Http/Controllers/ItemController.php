<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Item;
use App\Http\Requests\ItemRequest;
use App\Transformers\ItemTransformer;

class ItemController extends Controller
{
    

    public function __construct(Item $item,ItemTransformer $itemTransformer){
        $this->item = $item;
        $this->itemTransformer = $itemTransformer;
    }

    public function index(Request $request)
    {
        $limit = $request->input('limit') ?: 5;
        $items = $this->item->paginate($limit);
        return  $this->respondWithPagination($items, [
            'data' =>  $this->itemTransformer->transformCollection($items)
        ]);
    }

     public function array_data(){
        $items = $this->item->orderBy('id')->select("id","name")->get(); 
        return response()->json($items);
    }


     public function searchByName(Request $request,$name){
        $limit = $request->input('limit') ?: 5;
        $items = $this->item->where('name', 'like', '%' . $name . '%')->paginate($limit); 
        return  $this->respondWithPagination($items, [
            'data' =>  $this->itemTransformer->transformCollection($items)
        ]);
    }

    
    public function store(ItemRequest $request)
    {
        $user = $this->getUser();
        $this->item->name = $request->name;
        $this->item->stock = $request->stock;
        $this->item->unit = $request->unit;
        $this->item->last_updated_by = $user->id;;
        try{            
            $this->item->save();
        }catch(\Exception $e){
            return response()->json(['error' => true, 'message' => $e->getMessage()]);
        }

        return response()->json(['error' => false, 'message' => 'Item success created']);
  
    }

    
    public function show($id)
    {
        $item = $this->item->find($id);  
        if(empty($item)){
            return $this->respondNotFound();
        }
        return response()->json($this->itemTransformer->transform($item));
    }
    
    
    public function update(ItemRequest $request, $id)
    {
        $user = $this->getUser();
        $item = $this->item->find($id);  
        if(empty($item)){
            return $this->respondNotFound();
        }
        $item->name = $request->name;
        $item->stock = $request->stock;
        $item->unit = $request->unit;
        $item->last_updated_by = $user->id;

         try{            
            $item->save();
        }catch(\Exception $e){
            if($e->getCode() == "23000"){
                return response()->json(['error' => true, 'message' => 'Failed, Other Data Refrence this data']);
            }
            
            return response()->json(['error' => true, 'message' => 'There is problem on server']);
        }

        return response()->json(['error' => false, 'message' => 'Item successfully updated']);
    }

    
    public function destroy($id)
    {
        $item = $this->item->find($id);
        if(empty($item)){
            return $this->respondNotFound();
        }
        try{            
            $item->delete();
        }catch(\Exception $e){
             if($e->getCode() == "23000"){
                return response()->json(['error' => true, 'message' => 'Failed, Other Data Refrence this data']);
            }
            return response()->json(['error' => true, 'message' => 'There is problem on server']);
        }

        return response()->json(['error' => false, 'message' => 'Item success deleted']);
  
    }
}
