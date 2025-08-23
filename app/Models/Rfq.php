<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Rfq extends Model
{
    protected $fillable = [
        'rfq_id',
        'buyer_id',
        'user_id',
        'product_name',
        'product_specification',
        'quantity',
        'measurement_unit',
    ];

}
