<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Vendor\VendorDashboardController;
use App\Http\Controllers\Vendor\VendorProfileController;
use App\Http\Controllers\Vendor\VendorProductController;
use App\Http\Controllers\Vendor\VendorPasswordController;
use App\Http\Controllers\Vendor\VendorSubscriptionController;

Route::middleware(['auth', 'vendor'])->group(function () {
    // Dashboard
    Route::get('/dashboard', [VendorDashboardController::class, 'index'])->name('vendor.dashboard');
    
    // Profile
    Route::get('/profile', [VendorProfileController::class, 'profile'])->name('vendor.profile.show');
    Route::post('profile/update', [VendorProfileController::class, 'update'])->name('vendor.profile.update');
    
    // Password
    Route::get('/change-password', [VendorPasswordController::class, 'edit'])->name('vendor.password.edit');
    Route::post('/change-password', [VendorPasswordController::class, 'update'])->name('vendor.password.update');

    // Subscription
    Route::get('/subscription', [VendorSubscriptionController::class, 'index'])->name('vendor.subscription.index');
    Route::post('/subscription', [VendorSubscriptionController::class, 'store'])->name('vendor.subscription.store');
    Route::get('/subscription/invoice', [VendorSubscriptionController::class, 'invoice'])->name('vendor.subscription.invoice');

    // Products
    Route::prefix('products')->name('vendor.products.')->group(function () {
        Route::get('list', [VendorProductController::class, 'index'])->name('index');
        Route::get('approved', [VendorProductController::class, 'approved'])->name('approved');
        Route::get('pending', [VendorProductController::class, 'pending'])->name('pending');
        Route::get('rejected', [VendorProductController::class, 'rejected'])->name('rejected');
        Route::get('data', [VendorProductController::class, 'getProducts'])->name('data');
        Route::get('render-table', [VendorProductController::class, 'renderProductsTable'])->name('render-table');
        Route::get('create', [VendorProductController::class, 'create'])->name('create');
        Route::post('save', [VendorProductController::class, 'store'])->name('store');
        Route::get('{id}/edit', [VendorProductController::class, 'edit'])->name('edit');
        Route::put('update/{id}', [VendorProductController::class, 'update'])->name('update');
        Route::get('{id}', [VendorProductController::class, 'show'])->name('show');
        Route::delete('delete/{id}', [VendorProductController::class, 'destroy'])->name('destroy');
        Route::get('export-data/list', [VendorProductController::class, 'exportData'])->name('export-data');
        Route::get('export/init', [VendorProductController::class, 'exportInit'])->name('export.init');
    });

    Route::get('get-subcategories/{parentId}', [VendorProductController::class, 'getSubcategories'])->name('vendor.get-subcategories');

    // Help & Support
    Route::prefix('help-support')->name('vendor.help-support.')->group(function () {
        Route::get('list', [App\Http\Controllers\Vendor\VendorHelpSupportController::class, 'index'])->name('index');
        Route::get('render-table', [App\Http\Controllers\Vendor\VendorHelpSupportController::class, 'renderHelpsTable'])->name('render-table');
        Route::get('create', [App\Http\Controllers\Vendor\VendorHelpSupportController::class, 'create'])->name('create');
        Route::post('store', [App\Http\Controllers\Vendor\VendorHelpSupportController::class, 'store'])->name('store');
        Route::get('{id}', [App\Http\Controllers\Vendor\VendorHelpSupportController::class, 'show'])->name('show');
    });

    // Inventory
    Route::prefix('inventory')->name('vendor.inventory.')->group(function () {
        Route::get('list', [App\Http\Controllers\Vendor\VendorInventoryController::class, 'index'])->name('index');
        Route::get('render-table', [App\Http\Controllers\Vendor\VendorInventoryController::class, 'renderInventoryTable'])->name('render-table');
        Route::get('stock/{id}', [App\Http\Controllers\Vendor\VendorInventoryController::class, 'getWarehouseStock'])->name('stock');
        Route::post('update/{id}', [App\Http\Controllers\Vendor\VendorInventoryController::class, 'updateStock'])->name('update');
        Route::get('{id}/logs', [App\Http\Controllers\Vendor\VendorInventoryController::class, 'stockLogs'])->name('logs');
        Route::get('export/init', [App\Http\Controllers\Vendor\VendorInventoryController::class, 'exportInit'])->name('export.init');
        Route::get('export/chunk', [App\Http\Controllers\Vendor\VendorInventoryController::class, 'exportChunk'])->name('export.chunk');
    });

    // Warehouses
    Route::prefix('warehouses')->name('vendor.warehouses.')->group(function () {
        Route::get('list', [App\Http\Controllers\Vendor\WarehouseController::class, 'index'])->name('index');
        Route::get('render-table', [App\Http\Controllers\Vendor\WarehouseController::class, 'renderTable'])->name('render-table');
        Route::post('store', [App\Http\Controllers\Vendor\WarehouseController::class, 'store'])->name('store');
        Route::put('update/{id}', [App\Http\Controllers\Vendor\WarehouseController::class, 'update'])->name('update');
        Route::delete('delete/{id}', [App\Http\Controllers\Vendor\WarehouseController::class, 'destroy'])->name('delete');
    });
});