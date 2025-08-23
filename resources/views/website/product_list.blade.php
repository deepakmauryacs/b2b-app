@extends('website.layouts.app')
@section('title', 'Products')
@section('content')
@push('styles')
<link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
@endpush

@push('scripts')
<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
@endpush
<!-- page-title -->
<div class="ttm-page-title-row">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <div class="d-flex justify-content-between align-items-center">
                    <div class="page-title-heading">
                        <h1 class="title">Product </h1>
                    </div>
                    <div class="breadcrumb-wrapper">
                        <span class="mr-1"><i class="ti ti-home"></i></span>
                        <a title="Homepage" href="index.html">Home</a>
                        <span class="ttm-bread-sep">&nbsp;/&nbsp;</span>
                        <span class="ttm-textcolor-skincolor">Product List</span>
                    </div>
                </div>
            </div>
        </div>  
    </div>                    
</div>
<!-- page-title end-->
<section class="py-5">
    <div class="container">
        <div class="row mb-5">
            <div class="col-md-12">
                                        <!-- Sorting Dropdown -->
                        <div class="row mb-4">
                            <div class="col-md-3">
                                <select class="form-select" id="input-sort" name="sort-type" aria-label="Sort products">
                                    <option value="">Sort by:</option>
                                    <option value="1">Name (A - Z)</option>
                                    <option value="2">Name (Z - A)</option>
                                </select>
                            </div>
                        </div>

                        <div class="row" id="productContainer">
                            <!-- Placeholder skeleton loading -->
                            <div class="col-md-3 col-sm-6 mb-4 placeholder-container">
                                <div class="card h-100 border shadow-sm placeholder-glow">
                                    <div class="placeholder" style="height:180px; background-color:#e9ecef;"></div>
                                    <div class="card-body text-center">
                                        <h6 class="card-title mb-3 placeholder col-8 mx-auto" style="height:24px;"></h6>
                                        <div class="d-grid gap-2">
                                            <button class="btn btn-outline-primary btn-sm disabled placeholder col-12" style="height:38px;"></button>
                                            <button class="btn btn-primary btn-sm disabled placeholder col-12" style="height:38px;"></button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3 col-sm-6 mb-4 placeholder-container">
                                <div class="card h-100 border shadow-sm placeholder-glow">
                                    <div class="placeholder" style="height:180px; background-color:#e9ecef;"></div>
                                    <div class="card-body text-center">
                                        <h6 class="card-title mb-3 placeholder col-8 mx-auto" style="height:24px;"></h6>
                                        <div class="d-grid gap-2">
                                            <button class="btn btn-outline-primary btn-sm disabled placeholder col-12" style="height:38px;"></button>
                                            <button class="btn btn-primary btn-sm disabled placeholder col-12" style="height:38px;"></button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3 col-sm-6 mb-4 placeholder-container">
                                <div class="card h-100 border shadow-sm placeholder-glow">
                                    <div class="placeholder" style="height:180px; background-color:#e9ecef;"></div>
                                    <div class="card-body text-center">
                                        <h6 class="card-title mb-3 placeholder col-8 mx-auto" style="height:24px;"></h6>
                                        <div class="d-grid gap-2">
                                            <button class="btn btn-outline-primary btn-sm disabled placeholder col-12" style="height:38px;"></button>
                                            <button class="btn btn-primary btn-sm disabled placeholder col-12" style="height:38px;"></button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3 col-sm-6 mb-4 placeholder-container">
                                <div class="card h-100 border shadow-sm placeholder-glow">
                                    <div class="placeholder" style="height:180px; background-color:#e9ecef;"></div>
                                    <div class="card-body text-center">
                                        <h6 class="card-title mb-3 placeholder col-8 mx-auto" style="height:24px;"></h6>
                                        <div class="d-grid gap-2">
                                            <button class="btn btn-outline-primary btn-sm disabled placeholder col-12" style="height:38px;"></button>
                                            <button class="btn btn-primary btn-sm disabled placeholder col-12" style="height:38px;"></button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="text-center mt-3">
                            <button id="loadMoreBtn" class="btn btn-outline-primary">Load More</button>
                        </div>
                    
            </div>
        </div>
    </div>
</section>

<x-get-best-price-modal />
<x-success-modal />
<x-toast-container />


@endsection

@push('scripts')
<script>
$(document).ready(function () {
    let page = 1;
    let currentSort = '';
    let isLoading = false;

    // Initial load
    loadProducts(page, currentSort);

    // Load more button click handler
    $('#loadMoreBtn').on('click', function () {
        if (!isLoading) {
            page++;
            loadProducts(page, currentSort);
        }
    });

    // Sort dropdown change handler
    $('#input-sort').on('change', function () {
        currentSort = $(this).val();
        page = 1;
        $('#productContainer').empty(); // Clear current products
        loadProducts(page, currentSort);
    });

    function loadProducts(pg, sort) {
        isLoading = true;
        const $btn = $('#loadMoreBtn');
        $btn.prop('disabled', true).html('<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> Loading...');

        $.ajax({
            url: '{{ route('buyer.products.list') }}',
            method: 'GET',
            data: {
                page: pg,
                sort: sort
            },
            success: function (res) {
                if (res.status) {
                    // Remove placeholder elements (only on first load)
                    if (pg === 1) {
                        $('.placeholder-container').remove();
                    }

                    appendProducts(res.products);

                    if (res.has_more) {
                        $btn.prop('disabled', false).html('Load More');
                    } else {
                        $btn.hide();
                    }
                } else {
                    $btn.hide();
                }
                isLoading = false;
            },
            error: function (err) {
                if (err.status === 422) {
                    alert(err.responseJSON.message);
                }
                $btn.prop('disabled', false).html('Load More');
                isLoading = false;
            }
        });
    }

    function appendProducts(list) {
    const $container = $('#productContainer');

    list.forEach(function (prod) {
        const imageSection = prod.product_image
            ? `<div class="position-relative" style="height:180px; overflow:hidden;">
                    <img src="${prod.product_image}" class="card-img-top h-100 object-fit-cover" alt="${prod.product_name}">
               </div>`
            : `<div class="d-flex align-items-center justify-content-center border-bottom" style="height:180px;background-color: #e7f2ff;margin: 20px;">
                    <span class="fw-bold text-muted">${prod.product_name}</span>
               </div>`;

        // Button logic:
        let rfqBtn;
        if (prod.added_to_rfq) {
            rfqBtn = `<button class="btn btn-primary btn-sm add-rfq-card" data-name="${prod.product_name}" disabled>
                        <i class="bi bi-check2-square"></i> Added to RFQ
                      </button>`;
        } else {
            rfqBtn = `<button class="btn btn-primary btn-sm add-rfq-card" data-name="${prod.product_name}">
                        <i class="bi bi-plus-square"></i> Add to RFQ
                      </button>`;
        }

        const html = `<div class="col-md-3 col-sm-6 mb-4">
                        <div class="card h-100 border shadow-sm">
                            ${imageSection}
                            <div class="card-body text-center">
                                <h6 class="card-title mb-3">${prod.product_name}</h6>
                                <div class="d-grid gap-2">
                                    <button class="btn btn-outline-primary btn-sm open-rfq-modal" data-name="${prod.product_name}">
                                        <i class="bi bi-chat-text"></i> Get Best Price
                                    </button>
                                    ${rfqBtn}
                                </div>
                            </div>
                        </div>
                    </div>`;
        $container.append(html);
    });
}

});

$(document).on('click', '.add-rfq-card', function () {
    const $btn = $(this);
    const productName = $btn.data('name');

    // Disable instantly for optimistic UI
    $btn.prop('disabled', true)
        .html('<i class="bi bi-check2-square"></i> Added to RFQ');

    $.ajax({
        url: '{{ route("buyer.rfqcart.add") }}',
        method: 'POST',
        data: {
            product_name: productName,
            _token: '{{ csrf_token() }}',
        },
        success: function (res) {
            if (!res.status) {
                $btn.prop('disabled', false)
                    .removeClass('btn-success').addClass('btn-primary')
                    .html('<i class="bi bi-plus-square"></i> Add to RFQ');
                showToast('error', 'Failed to add product to RFQ cart');
            } else {
                showToast('success', res.message ?? 'Added to RFQ cart');
            }
        },
        error: function (err) {
            $btn.prop('disabled', false)
                .removeClass('btn-success').addClass('btn-primary')
                .html('<i class="bi bi-plus-square"></i> Add to RFQ');

            if (err.status === 401) {
                showToast('error', 'Please login to add product to RFQ cart');
            } else if (err.status === 422) {
                showToast('error', err.responseJSON.message);
            } else {
                showToast('error', 'Something went wrong!');
            }
        }
    });
});

window.showToast = function(type, message) {
    // type: 'success', 'error', etc.
    let bgClass = type === 'success' ? 'bg-success' : 'bg-danger';
    let toastId = 'customToast';
    let container = document.getElementById('toastContainer');
    if (!container) {
        container = document.createElement('div');
        container.id = 'toastContainer';
        container.style.position = 'fixed';
        container.style.top = '1rem';
        container.style.right = '1rem';
        container.style.zIndex = 1060;
        document.body.appendChild(container);
    }
    let toast = document.createElement('div');
    toast.className = `toast align-items-center text-white ${bgClass} border-0`;
    toast.role = "alert";
    toast.style.minWidth = "250px"
    toast.style.marginBottom = "5px";     // <-- add this line;
    toast.innerHTML = `
        <div class="d-flex">
            <div class="toast-body">${message}</div>
            <button type="button" class="me-2 m-auto btn-close btn-close-white" data-bs-dismiss="toast" aria-label="Close"></button>
        </div>
    `;
    container.appendChild(toast);
    let bsToast = new bootstrap.Toast(toast, { delay: 3000 });
    bsToast.show();
    toast.addEventListener('hidden.bs.toast', function() {
        toast.remove();
    });
};



window.rfqConfig = {
        submitUrl: "{{ route('buyer.rfq.submit') }}"
};
</script>
<script src="{{ asset('assets/buyer-assets/js/rfq-modal.js') }}"></script>
@endpush