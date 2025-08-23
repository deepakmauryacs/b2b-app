<?php

namespace App\Http\Controllers\Buyer;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Str;
use App\Models\Rfq;
use App\Models\RfqVendor;
use App\Models\Product;

class RfqController extends Controller
{
    public function submit(Request $request)
    {
        $request->validate([
            'product_name' => 'required|string|max:191',
            'product_specification' => 'nullable|string',
            'quantity' => 'required|numeric|min:1',
            'measurement_unit' => 'required|string|max:191'
        ]);

        $buyer_id = auth()->id() ?? 0;
        $user_id  = auth()->id() ?? 0;

        $rfq = Rfq::create([
            'rfq_id' => 'RFQ-' . strtoupper(Str::random(8)),
            'buyer_id' => $buyer_id,
            'user_id' => $user_id,
            'product_name' => $request->product_name,
            'product_specification' => $request->product_specification,
            'quantity' => $request->quantity,
            'measurement_unit' => $request->measurement_unit,
        ]);

        $vendors = Product::where('product_name', $request->product_name)->pluck('vendor_id')->unique();
        foreach ($vendors as $vendor_id) {
            RfqVendor::create([
                'rfq_id' => $rfq->rfq_id,
                'vendor_id' => $vendor_id
            ]);
        }

        return response()->json(['success' => true]);
    }
}
