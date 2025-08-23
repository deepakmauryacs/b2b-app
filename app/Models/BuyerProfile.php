<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class BuyerProfile extends Model
{
    use HasFactory;

    protected $fillable = [
        'user_id',
        'store_name',      // updated from 'name'
        'email',
        'phone',
        'country',
        'state',
        'city',
        'pincode',
        'address',
        'gst_no',          // allow GST number updates
        'gst_doc',         // allow uploading GST document path
        'store_logo',      // allow uploading store logo path
    ];

    /**
     * Get the user that owns the buyer profile.
     */
    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }
}
