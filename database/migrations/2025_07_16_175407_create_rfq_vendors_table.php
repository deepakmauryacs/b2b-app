<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('rfq_vendors', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('rfq_id'); // Foreign key to the 'rfqs' table's primary ID
            $table->unsignedBigInteger('vendor_id'); // Foreign key to the 'users' table for the vendor
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('rfq_vendors');
    }
};
