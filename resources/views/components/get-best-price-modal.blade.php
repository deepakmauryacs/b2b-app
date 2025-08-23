<div class="modal fade" id="getBestPriceModal" tabindex="-1" aria-labelledby="getBestPriceLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable  modal-lg">
    <div class="modal-content">
      <form id="rfqForm">
        @csrf
        <input type="hidden" name="product_name" id="modalProductName">
        <div class="modal-header" style="background: linear-gradient(to right, #0b5ed7 0%, #0d6efd66 100%);">
          <h5 class="modal-title" id="getBestPriceLabel" style="color: #ffffff;font-size: 18px;font-weight: 300;"><i class="bi bi-chat-text"></i> Get Best Price</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>

        <div class="modal-body">
          <div class="mb-3">
            <label class="form-label">Product <span class="text-danger">*</span></label>
            <input type="text" class="form-control" id="modalProductDisplay" disabled>
          </div>

          <div class="mb-3">
            <label class="form-label">Product Specification</label>
            <textarea class="form-control" name="product_specification" rows="3"></textarea>
          </div>

          <div class="mb-3">
            <label class="form-label">Quantity <span class="text-danger">*</span></label>
            <input type="text" class="form-control" name="quantity" id="rfqQuantity">
            <div class="invalid-feedback"></div>
          </div>

          <div class="mb-3">
            <label class="form-label">Measurement Unit <span class="text-danger">*</span></label>
            <div class="row" style="max-height: 120px; overflow-y: auto;padding:10px;">
            
              <div class="invalid-feedback d-block" id="unitError"></div>
              @php
                $units = config('units');
              @endphp

              @foreach ($units as $key => $value)
                <div class="col-md-4">
                 
                  <div class="form-check">
                    <input class="form-check-input" type="radio" name="measurement_unit" id="unit_{{ $key }}" value="{{ $key }}">
                    <label class="form-check-label" for="unit_{{ $key }}">
                      {{ $value }}
                    </label>
                  </div>
                </div>
              @endforeach
            </div>
          </div>
        </div>
        <div class="modal-footer">
         <button type="submit" class="btn btn-primary">Submit... </button>
        </div>

      </form>
    </div>
  </div>
</div>
