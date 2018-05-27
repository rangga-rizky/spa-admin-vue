<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\TransactionDetail;
use App\Transformers\TransactionDetailTransformer;

class TransactionDetailController extends Controller
{
    public function __construct(TransactionDetail $transactionDetail,TransactionDetailTransformer $transactionDetailTransformer){
        $this->transactionDetail = $transactionDetail;
        $this->transactionDetailTransformer = $transactionDetailTransformer;
    }

    public function showByTransaction($transaction_id){
        $transactionDetails = $this->transactionDetail->where('transaction_id',$transaction_id)->get();
        if(empty($transactionDetails)){
            return $this->respondNotFound();
        }
        $transaction = array('user' => $transactionDetails[0]->transaction->user->name, 
        					'id' => $transactionDetails[0]->transaction_id,
        					'total_price' => $transactionDetails[0]->transaction->total_price);
        return response()->json([
        	'meta' => $transaction,
        	'data' => $this->transactionDetailTransformer->transformCollection($transactionDetails)
        ]);
    }

    public function destroy($id)
    {
        $transactionDetail = $this->transactionDetail->find($id);
        if(empty($transactionDetail)){
            return $this->respondNotFound();
        }
        try{              
            $transactionDetail->delete();     
        }catch(\Exception $e){
            dd($e->getMessage());
            return response()->json(['error' => true, 'message' => 'There is problem on server']);
        }

        return response()->json(['error' => false, 'message' => 'Transaction success deleted']);
  
    }
}
