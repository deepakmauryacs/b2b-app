@extends('vendor.layouts.app')
@section('title', 'Add Product | Deal24hours')
@section('content')

{{-- CKEditor 4 (full-all build) --}}
<!-- <script src="https://cdn.ckeditor.com/4.22.1/full-all/ckeditor.js"></script> -->

<script src="{{ asset('standard_ckeditor/ckeditor.js') }}"></script>


<style>
  .error{ color:#dc3545; font-size:.875em; margin-top:.25rem; }
  .is-invalid{ border-color:#dc3545 !important; }
  .form-control:focus,.form-select:focus{ box-shadow:0 0 0 .25rem rgba(13,110,253,.25); }
</style>

<div class="row">
  <div class="col-md-12">
    <div class="card">
      <div class="card-header d-flex justify-content-between align-items-center gap-1">
        <h4 class="card-title flex-grow-1">Add New Product</h4>
        <a href="{{ route('vendor.products.index') }}" class="badge border border-secondary text-secondary px-2 py-1 fs-13">← Back to List</a>
      </div>

      <div class="card-body">
        {{-- Important Note --}}
        <div class="alert alert-warning alert-dismissible fade show mb-4" role="alert">
            <strong>Note:</strong> Please 
            <a href="{{ route('vendor.warehouses.index') }}" class="text-decoration-underline">add a Warehouse</a> 
            first before adding a product.

            {{-- Close Button --}}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
        
        <form action="{{ route('vendor.products.store') }}" method="POST" enctype="multipart/form-data" id="productForm">
          @csrf
          <div class="row gy-3">

            {{-- Category --}}
            <div class="col-md-6">
              <label for="category_id" class="form-label">Category <span class="text-danger">*</span></label>
              <select name="category_id" id="category_id" class="form-select">
                <option value="">-- Select Category --</option>
                @foreach($categories as $category)
                  <option value="{{ $category->id }}" {{ old('category_id') == $category->id ? 'selected' : '' }}>{{ $category->name }}</option>
                @endforeach
              </select>
            </div>

            {{-- Sub-category --}}
            <div class="col-md-6">
              <label for="sub_category_id" class="form-label">Sub-Category</label>
              <select name="sub_category_id" id="sub_category_id" class="form-select @error('sub_category_id') is-invalid @enderror">
                <option value="">-- Select Sub-Category --</option>
                @if(old('sub_category_id'))
                  @foreach($subCategories as $subCategory)
                    @if(old('sub_category_id') == $subCategory->id)
                      <option value="{{ $subCategory->id }}" selected>{{ $subCategory->name }}</option>
                    @endif
                  @endforeach
                @endif
              </select>
            </div>

            {{-- Product Name --}}
            <div class="col-md-12">
              <label for="product_name" class="form-label">Product Name <span class="text-danger">*</span></label>
              <input type="text" name="product_name" id="product_name" class="form-control" placeholder="Enter product name" value="{{ old('product_name') }}" />
            </div>

            {{-- Slug --}}
            <div class="col-md-12">
              <label for="slug" class="form-label">Slug (optional)</label>
              <input type="text" name="slug" id="slug" class="form-control" placeholder="Enter custom slug or leave blank" value="{{ old('slug') }}" />
            </div>

            {{-- ✅ Description (CKEditor target) --}}
            <div class="col-12">
              <label for="description" class="form-label">Description</label>
              <textarea name="description" id="description" class="form-control" rows="6" placeholder="Enter product description">{{ old('description') }}</textarea>
            </div>

            {{-- Price --}}
            <div class="col-md-4">
              <label for="price" class="form-label">Price <span class="text-danger">*</span></label>
              <input type="number" step="0.01" name="price" id="price" class="form-control" placeholder="0.00" value="{{ old('price', '0.00') }}" required />
            </div>

            {{-- Unit --}}
            <div class="col-md-4">
              <label for="unit" class="form-label">Unit <span class="text-danger">*</span></label>
              <input type="text" name="unit" id="unit" class="form-control" placeholder="e.g., pcs, kg" value="{{ old('unit') }}" />
            </div>

            {{-- Min Order Qty --}}
            <div class="col-md-4">
              <label for="min_order_qty" class="form-label">Min Order Qty <span class="text-danger">*</span></label>
              <input type="number" name="min_order_qty" id="min_order_qty" class="form-control" placeholder="1" min="1" value="{{ old('min_order_qty', 1) }}" />
            </div>

            {{-- Stock --}}
            <div class="col-md-4">
              <label for="stock_quantity" class="form-label">Stock Quantity <span class="text-danger">*</span></label>
              <input type="number" name="stock_quantity" id="stock_quantity" class="form-control" placeholder="0" min="0" value="{{ old('stock_quantity', 0) }}" />
            </div>

            {{-- Warehouse --}}
            <div class="col-md-4">
              <label for="warehouse_id" class="form-label">Warehouse <span class="text-danger">*</span></label>
              <select name="warehouse_id" id="warehouse_id" class="form-select">
                <option value="">-- Select Warehouse --</option>
                @foreach($warehouses as $warehouse)
                  <option value="{{ $warehouse->id }}" {{ old('warehouse_id') == $warehouse->id ? 'selected' : '' }}>{{ $warehouse->name }}</option>
                @endforeach
              </select>
            </div>

            {{-- HSN / GST --}}
            <div class="col-md-4">
              <label for="hsn_code" class="form-label">HSN Code</label>
              <input type="text" name="hsn_code" id="hsn_code" class="form-control" placeholder="Enter HSN code" value="{{ old('hsn_code') }}" />
            </div>
            <div class="col-md-4">
              <label for="gst_rate" class="form-label">GST Rate (%)</label>
              <input type="number" name="gst_rate" id="gst_rate" class="form-control" placeholder="e.g., 5, 12, 18" min="0" max="100" value="{{ old('gst_rate') }}" />
            </div>

            {{-- Image --}}
            <div class="col-md-6">
              <label for="product_image" class="form-label">Product Image</label>
              <input type="file" name="product_image" id="product_image" class="form-control" accept="image/jpeg,image/png,image/jpg" />
              <small class="text-muted">Max file size: 2MB (JPEG, JPG or PNG only)</small>
            </div>

            {{-- Status (hidden default) --}}
            <div class="col-md-6 d-none">
              <input type="hidden" name="status" value="pending">
              <label for="status" class="form-label">Status</label>
              <select name="status" id="status" class="form-select">
                <option value="pending" selected>Pending</option>
                <option value="approved">Approved</option>
                <option value="rejected">Rejected</option>
              </select>
            </div>

            <div class="col-12 text-end mt-3">
              <button type="submit" class="btn btn-primary">Save Product</button>
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>

<script>
$(function(){

  // --- CKEditor 4 init (same as your sample) ---
  CKEDITOR.replace('description', {
    height: 300,               // <- same as sample
    toolbarCanCollapse: true,  // <- same as sample
  });

  // Slug from product name
  $("#product_name").on("keyup", function () {
    var text = $(this).val();
    var slug = text.toLowerCase().replace(/[^a-z0-9]+/g,"-").replace(/(^-|-$)+/g,"");
    $("#slug").val(slug);
  });

  function validateForm(){
    let isValid = true;
    $('.is-invalid').removeClass('is-invalid');
    $('.error-message').remove();

    if(!$('#category_id').val()){
      $('#category_id').addClass('is-invalid').after('<span class="error error-message">Please select a category</span>');
      toastr.error('Please select a category'); isValid = false;
    }

    const productName = $('#product_name').val();
    if(!productName || productName.length < 3){
      $('#product_name').addClass('is-invalid').after('<span class="error error-message">Product name must be at least 3 characters long</span>');
      toastr.error('Product name must be at least 3 characters long'); isValid = false;
    }else if(productName.length > 255){
      $('#product_name').addClass('is-invalid').after('<span class="error error-message">Product name cannot exceed 255 characters</span>');
      toastr.error('Product name cannot exceed 255 characters'); isValid = false;
    }

    const slug = $('#slug').val();
    if(slug && !/^[a-z0-9-]+$/.test(slug)){
      $('#slug').addClass('is-invalid').after('<span class="error error-message">Slug can only contain lowercase letters, numbers and hyphens</span>');
      toastr.error('Slug can only contain lowercase letters, numbers and hyphens'); isValid = false;
    }

    const price = parseFloat($('#price').val());
    if(isNaN(price) || price <= 0){
      $('#price').addClass('is-invalid').after('<span class="error error-message">Price must be greater than 0</span>');
      toastr.error('Please enter a valid price > 0'); isValid = false;
    }

    const unit = $('#unit').val().trim();
    if(!unit){
      $('#unit').addClass('is-invalid').after('<span class="error error-message">Unit is required</span>');
      toastr.error('Unit is required'); isValid = false;
    }

    const moq = parseInt($('#min_order_qty').val());
    if(!$('#min_order_qty').val() || isNaN(moq) || moq < 1){
      $('#min_order_qty').addClass('is-invalid').after('<span class="error error-message">Minimum order quantity must be at least 1</span>');
      toastr.error('Minimum order quantity must be at least 1'); isValid = false;
    }

    const stock = parseInt($('#stock_quantity').val());
    if(!$('#stock_quantity').val() || isNaN(stock) || stock < 0){
      $('#stock_quantity').addClass('is-invalid').after('<span class="error error-message">Please enter a valid stock quantity</span>');
      toastr.error('Please enter a valid stock quantity'); isValid = false;
    }

    if(!$('#warehouse_id').val()){
      $('#warehouse_id').addClass('is-invalid').after('<span class="error error-message">Please select a warehouse</span>');
      toastr.error('Please select a warehouse'); isValid = false;
    }

    const gst = parseFloat($('#gst_rate').val());
    if($('#gst_rate').val()){
      if(isNaN(gst) || gst < 0 || gst > 100){
        $('#gst_rate').addClass('is-invalid').after('<span class="error error-message">GST rate must be between 0 and 100</span>');
        toastr.error('GST rate must be between 0 and 100'); isValid = false;
      }
    }

    // Image validation
    const fileInput = $('#product_image')[0];
    if(fileInput.files.length > 0){
      const file = fileInput.files[0];
      const validTypes = ['image/jpeg','image/png','image/jpg'];
      const maxSize = 2 * 1024 * 1024;
      if(!validTypes.includes(file.type)){
        $('#product_image').addClass('is-invalid').after('<span class="error error-message">Only JPEG, JPG or PNG images are allowed</span>');
        toastr.error('Only JPEG, JPG or PNG images are allowed'); isValid = false;
      }else if(file.size > maxSize){
        $('#product_image').addClass('is-invalid').after('<span class="error error-message">Image size must be less than 2MB</span>');
        toastr.error('Image size must be less than 2MB'); isValid = false;
      }
    }

    return isValid;
  }

  // Load subcategories
  $('#category_id').on('change', function(){
    let categoryId = $(this).val();
    $('#sub_category_id').html('<option value="">-- Select Sub-Category --</option>');
    if(categoryId){
      let url = "{{ route('vendor.get-subcategories', ['parentId' => '___id___']) }}".replace('___id___', categoryId);
      $.ajax({
        url: url, type:'GET',
        success: function (data) {
          $.each(data, function (k, v) {
            $('#sub_category_id').append('<option value="'+v.id+'">'+v.name+'</option>');
          });
        },
        error: function(){ toastr.error('Failed to load subcategories. Please try again.'); }
      });
    }
  });

  // Submit via AJAX
  $('#productForm').on('submit', function(e){
    e.preventDefault();
    if(!validateForm()){
      toastr.error("Please fix the validation errors.");
      return;
    }

    var formData = new FormData(this);

    //  Get HTML from CKEditor (instead of Summernote)
    var descriptionHtml = CKEDITOR.instances.description.getData();
    formData.set('description', descriptionHtml);

    $.ajax({
      url: $(this).attr('action'),
      type: 'POST',
      data: formData,
      processData: false,
      contentType: false,
      beforeSend: function(){
        $('button[type="submit"]').prop('disabled', true).html('<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> Saving...');
      },
      success: function(response){
        if(response.status == 1){
          toastr.success(response.message);
          $('#productForm').trigger('reset');

          // Clear CKEditor content
          if(CKEDITOR.instances.description){
            CKEDITOR.instances.description.setData('');
          }

          setTimeout(function(){
            window.location.href = response.redirect || "{{ route('vendor.products.index') }}";
          }, 1000);
        }else{
          toastr.error(response.message || 'An error occurred');
        }
      },
      error: function(xhr){
        if(xhr.responseJSON){
          if(Array.isArray(xhr.responseJSON.message)){
            $.each(xhr.responseJSON.message, function(i, err){ toastr.error(err); });
          }else if(xhr.responseJSON.message){
            toastr.error(xhr.responseJSON.message);
          }else if(xhr.responseJSON.errors){
            $.each(xhr.responseJSON.errors, function(k, v){ toastr.error(v[0]); });
          }
        }else{
          toastr.error('An error occurred. Please try again.');
        }
      },
      complete: function(){
        $('button[type="submit"]').prop('disabled', false).html('Save Product');
      }
    });
  });

});
</script>
@endsection
