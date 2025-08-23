<?php

namespace App\Http\Controllers\Buyer;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\RfqCart;
use Illuminate\Support\Facades\Auth;

class RfqCartController extends Controller
{
    public function addToCart(Request $request)
    {
        $request->validate([
            'product_name' => 'required|string',
        ]);

        $user = Auth::user();
        if (!$user) {
            return response()->json(['status' => false, 'message' => 'Unauthorized'], 401);
        }

        RfqCart::create([
            'user_id' => $user->id,
            'product_name' => $request->product_name,
        ]);

        return response()->json(['status' => true, 'message' => 'Product added to RFQ cart']);
    }
}
