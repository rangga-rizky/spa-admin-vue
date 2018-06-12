<?php
namespace App\Observers;

use App\Notifications\NewItem;
use App\Item;
use App\User;

class ItemObserver
{
    public function created(Item $item)
    {
        $author = $item->user;
        $users = User::all();
        foreach ($users as $user) {
            $user->notify(new NewItem($item,$author));
        }
    }
}