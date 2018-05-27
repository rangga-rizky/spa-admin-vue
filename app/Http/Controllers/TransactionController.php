<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Transaction;
use App\TransactionDetail;
use App\Transformers\TransactionTransformer;
use App\Http\Requests\TransactionRequest;

class TransactionController extends Controller
{
      public function __construct(Transaction $transaction,TransactionTransformer $transactionTransformer,
        TransactionDetail $transactionDetail){
        $this->transaction = $transaction;
        $this->transactionTransformer = $transactionTransformer;
        $this->transactionDetail = $transactionDetail;
    }

    public function index(Request $request)
    {
        $limit = $request->input('limit') ?: 5;
        $transactions = $this->transaction->paginate($limit);
        return  $this->respondWithPagination($transactions, [
            'data' =>  $this->transactionTransformer->transformCollection($transactions)
        ]);
    }
    
        
    public function show($id)
    {
        $transaction = $this->transaction->find($id);  
        if(empty($transaction)){
            return $this->respondNotFound();
        }
        return response()->json($this->transactionTransformer->transform($transaction));
    }
    
    public function store(Request $request)
    {
        $user = $this->getUser();
        $total_price = 0;
        $total_amount =0;
        $transDetails = [];
        foreach ($request->all() as $transDetail) {
            $total_price += $transDetail["sub_price"];
            $total_amount += $transDetail["qty"];
        }
        $this->transaction->user_id = $user->id;
        $this->transaction->total_price = $total_price;
        $this->transaction->total_amount = $total_amount;
        try{            
            $this->transaction->save();
            foreach ($request->all() as $transDetail) {
                $transDetail["transaction_id"] = $this->transaction->id;
                $transDetail["created_at"] = date("Y-m-d H:i:s");
                $transDetail["updated_at"] = date("Y-m-d H:i:s");
                $transDetails[] = $transDetail;
            }
            $this->transactionDetail->insert($transDetails);

        }catch(\Exception $e){
            return response()->json(['error' => true, 'message' => 'There is problem on server']);
        }

        return response()->json(['error' => false, 'message' => 'productItem success created']);
  
    }
    
    public function update(TransactionRequest $request, $id)
    {
        $user = $this->getUser();
        $transaction = $this->transaction->find($id);  
        if(empty($transaction)){
            return $this->respondNotFound();
        }
        $transaction->total_amount = $request->total_amount;
        $transaction->total_price = $request->total_price;
        $transaction->user_id = $user->id;

         try{            
            $transaction->save();
        }catch(\Exception $e){
            return response()->json(['error' => true, 'message' => 'There is problem on server']);
        }

        return response()->json(['error' => false, 'message' => 'Transaction successfully updated']);
    }

    
    public function destroy($id)
    {
        $transaction = $this->transaction->find($id);
        if(empty($transaction)){
            return $this->respondNotFound();
        }
        try{            
            $transaction->delete();
        }catch(\Exception $e){
            return response()->json(['error' => true, 'message' => 'There is problem on server']);
        }

        return response()->json(['error' => false, 'message' => 'Transaction success deleted']);
  
    }
}
