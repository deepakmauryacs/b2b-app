<?php

namespace App\Http\Controllers\Buyer;

use App\Http\Controllers\Controller;
use App\Models\Product;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Auth;

class ProductController extends Controller
{
    /**
     * Display product list page.
     */
    public function index()
    {
        return view('website.product_list');
    }

    /**
     * Return paginated products in JSON format.
     */
    public function list(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'page' => 'sometimes|integer|min:1',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'status' => 0,
                'message' => $validator->errors()->first(),
                'errors' => $validator->errors(),
            ], 422);
        }

        $perPage = 24;
        $page = $request->input('page', 1);

        $products = Product::where('status', 'approved')
            ->orderBy('created_at', 'desc')
            ->paginate($perPage, ['*'], 'page', $page);

        // Get existing RFQ product names for current user
        $userId = Auth::id();
        $rfqProducts = [];
        if ($userId) {
            $rfqProducts = \DB::table('rfq_carts')
                ->where('user_id', $userId)
                ->pluck('product_name')
                ->map('strtolower') // ensure case-insensitive
                ->toArray();
        }

        $items = $products->getCollection()->map(function ($item) use ($rfqProducts) {
            $productName = strtolower($item->product_name);
            return [
                'id' => $item->id,
                'product_name' => $item->product_name,
                'product_image' => $item->product_image ? asset('storage/' . $item->product_image) : null,
                'date' => optional($item->created_at)->format('d-m-Y'),
                'added_to_rfq' => in_array($productName, $rfqProducts),
            ];
        });

        return response()->json([
            'status' => 1,
            'products' => $items,
            'has_more' => $products->hasMorePages(),
        ]);
    }
}