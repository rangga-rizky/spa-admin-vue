<?php

use Illuminate\Http\Request;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::post('register', 'AuthController@register');
Route::post('login', 'AuthController@login');
Route::post('recover', 'AuthController@recover');
Route::group(['middleware' => ['jwt.auth']], function() {
    
    Route::get('logout', 'AuthController@logout');
    
    Route::get('items', 'ItemController@index');
    Route::get('items/search/{name}', 'ItemController@searchByName');    
    Route::get('items/array', 'ItemController@array_data');
    Route::post('items', 'ItemController@store');
    Route::delete('items/{id}', 'ItemController@destroy');
    Route::put('items/{id}', 'ItemController@update');
    Route::get('items/{id}', 'ItemController@show');

    Route::get('products', 'ProductController@index');
     Route::get('products/search/{name}', 'ProductController@searchByName');
    Route::get('products/array', 'ProductController@array_data');
    Route::post('products', 'ProductController@store');
    Route::delete('products/{id}', 'ProductController@destroy');
    Route::post('products/{id}', 'ProductController@update');
    Route::get('products/{id}', 'ProductController@show');

    Route::get('product-items', 'ProductItemController@index');
    Route::post('product-items', 'ProductItemController@store');
    Route::delete('product-items/{id}', 'ProductItemController@destroy');
    Route::put('product-items/{id}', 'ProductItemController@update');
    Route::get('product-items/{id}', 'ProductItemController@show');

    Route::get('transactions', 'TransactionController@index');
    Route::post('transactions', 'TransactionController@store');
    Route::delete('transactions/{id}', 'TransactionController@destroy');
    Route::put('transactions/{id}', 'TransactionController@update');
    Route::get('transactions/{id}', 'TransactionController@show');

    Route::get('transaction-details/transaction/{transaction_id}', 'TransactionDetailController@showByTransaction');
    Route::delete('transaction-details/{id}', 'TransactionDetailController@destroy');
});