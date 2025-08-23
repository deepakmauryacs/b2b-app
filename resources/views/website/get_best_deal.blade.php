@extends('website.layouts.app')
@section('title', 'Post Buy Requirement')
@section('content')
<style>
.iti {
    width: 100% !important;
}
.invalid-feedback {
    display: none;
}
.is-invalid ~ .invalid-feedback {
    display: block;
}
</style>
<!-- Include intl-tel-input CSS -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/17.0.8/css/intlTelInput.css" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css" />

<!--site-main start-->
<!-- page-title -->
<div class="ttm-page-title-row">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <div class="d-flex justify-content-between align-items-center">
                    <div class="page-title-heading">
                        <h1 class="title">Get Best Deal</h1>
                    </div>
                    <div class="breadcrumb-wrapper">
                        <span class="mr-1"><i class="ti ti-home"></i></span>
                        <a title="Homepage" href="index.html">Home</a>
                        <span class="ttm-bread-sep">&nbsp;/&nbsp;</span>
                        <span class="ttm-textcolor-skincolor">Get Best Deal</span>
                    </div>
                </div>
            </div>
        </div>  
    </div>                    
</div><!-- page-title end-->

<div class="site-main" style="margin-top: 300px;">
    <section class="contact-section bg-layer bg-layer-equal-height clearfix">
        <div class="container">
            <div class="row g-0">
                <div class="col-lg-8 col-md-7">
                    <div class="ttm-col-bgcolor-yes ttm-bg ttm-bgcolor-grey spacing-2">
                        <div class="ttm-col-wrapper-bg-layer ttm-bg-layer"></div>
                        <div class="layer-content">
                            <div class="section-title style2">
                                <div class="title-header">
                                    <h5>Post Buy Requirement</h5>
                                    <h2 class="title">Share your requirement and start receiving the best offers—fast and hassle-free!*</h2>
                                </div>
                            </div>

                            <form id="buyReqForm" class="needs-validation" method="POST" action="{{ route('buyer.post-buy.store') }}" novalidate>
                                @csrf
                                <div class="row g-3">
                                    <!-- Product Name -->
                                    <div class="col-12">
                                        <label for="product_name" class="form-label">
                                            <i class="bi bi-box-seam me-2"></i>Product Name <span class="text-danger">*</span>
                                        </label>
                                        <input type="text" class="form-control" id="product_name" name="product_name" placeholder="Enter the product you are looking for..." required>
                                        <div class="invalid-feedback">
                                            Please enter a product name (max 255 characters).
                                        </div>
                                    </div>

                                    <!-- Mobile Number with Country Code -->
                                    <div class="col-12">
                                        <label for="mobile_number" class="form-label">
                                            <i class="bi bi-phone me-2"></i>Mobile Number <span class="text-danger">*</span>
                                        </label>
                                        <input type="tel" class="form-control" id="mobile_number" name="mobile_number" placeholder="Mobile Number" required>
                                        <input type="hidden" name="dial_code" id="dial_code">
                                        
                                    </div>

                                    <!-- Expected Date -->
                                    <div class="col-md-6">
                                        <label for="expected_date" class="form-label">
                                            <i class="bi bi-calendar me-2"></i>Expected Date <span class="text-danger">*</span>
                                        </label>
                                        <input type="text" class="form-control date-picker" id="expected_date" name="expected_date" placeholder="Expected Date" required>
                                        <div class="invalid-feedback">
                                            Please select a valid date.
                                        </div>
                                    </div>

                                    <!-- Submit Button -->
                                    <div class="col-12 text-end mt-3">
                                        <button type="submit" class="btn btn-primary">
                                            Get Best Deal
                                        </button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>

                <div class="col-lg-4 col-md-5">
                    <div class="ttm-col-bgcolor-yes ttm-bg ttm-bgcolor-skincolor spacing-3 text-white text-center d-flex flex-column justify-content-center align-items-center" style="min-height: 100%; padding: 40px 20px;">
                        <div class="ttm-col-wrapper-bg-layer ttm-bg-layer"></div>
                        <div class="layer-content py-5">
                            <i class="bi bi-lightning-charge" style="font-size: 50px;"></i>
                            <h2 class="mt-3 fw-bold" style="font-size: 28px;">#Deal24Hours</h2>
                            <blockquote class="fs-5 mt-3" style="font-style: italic; line-height: 1.6;">
                                “Why wait? Post your requirement now and get multiple best-price quotes within 24 hours from trusted sellers.”
                            </blockquote>
                            <p class="mt-3 fs-6 fst-italic">Fast • Free • Reliable</p>
                        </div>
                    </div>
                </div>
            </div><!-- row end -->
        </div>
    </section>
</div>
@endsection

@push('scripts')
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/17.0.8/js/intlTelInput.min.js"></script>

<script>
$(function(){
    // Initialize Flatpickr for date picker
    if (typeof flatpickr !== 'undefined') {
        $('#expected_date').flatpickr({
            dateFormat: 'd-m-Y',
            minDate: 'today'
        });
    }

    // Initialize intl-tel-input for mobile number
    var input = document.querySelector("#mobile_number");
    var dialCodeInput = document.querySelector("#dial_code");
    var iti = window.intlTelInput(input, {
        initialCountry: "in", // Default to India
        separateDialCode: true,
        dropdownContainer: document.body, // Ensure dropdown is not clipped
        utilsScript: "https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/17.0.8/js/utils.js"
    });

    // Update hidden dial_code field when country changes
    input.addEventListener('countrychange', function() {
        dialCodeInput.value = '+' + iti.getSelectedCountryData().dialCode;
    });

    // Set initial dial code
    dialCodeInput.value = '+' + iti.getSelectedCountryData().dialCode;

    // CSRF Token Setup
    $.ajaxSetup({
        headers: {
            'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
        }
    });

    // Form Submission with Client-Side Validation
    $('#buyReqForm').on('submit', function(e) {
        e.preventDefault();
        var form = $(this);
        var isValid = true;

        // Clear previous validation states
        form.find('.is-invalid').removeClass('is-invalid');
        form.find('.invalid-feedback').remove();

        // Validate Product Name
        var productName = $('#product_name').val().trim();
        if (!productName) {
            $('#product_name').addClass('is-invalid');
            $('#product_name').after('<div class="invalid-feedback d-block">Please enter a product name.</div>');
            toastr.error('Please enter a product name.');
            isValid = false;
        } else if (productName.length > 255) {
            $('#product_name').addClass('is-invalid');
            $('#product_name').after('<div class="invalid-feedback d-block">Product name cannot exceed 255 characters.</div>');
            toastr.error('Product name cannot exceed 255 characters.');
            isValid = false;
        }

        // Validate Mobile Number
        if (!iti.isValidNumber()) {
            $('#mobile_number').addClass('is-invalid');
            $('#mobile_number').after('<div class="invalid-feedback d-block">Please enter a valid mobile number.</div>');
            toastr.error('Please enter a valid mobile number.');
            isValid = false;
        }

        // Validate Dial Code
        var dialCode = $('#dial_code').val();
        var dialCodeRegex = /^\+\d{1,4}$/;
        if (!dialCode || !dialCodeRegex.test(dialCode)) {
            $('#mobile_number').addClass('is-invalid');
            $('#mobile_number').after('<div class="invalid-feedback d-block">Please select a valid country code.</div>');
            toastr.error('Please select a valid country code.');
            isValid = false;
        }

        // Validate Expected Date
        var expectedDate = $('#expected_date').val();
        var dateRegex = /^(0[1-9]|[12]\d|3[01])-(0[1-9]|1[0-2])-(\d{4})$/;
        if (!expectedDate) {
            $('#expected_date').addClass('is-invalid');
            $('#expected_date').after('<div class="invalid-feedback d-block">Please select a valid date.</div>');
            toastr.error('Please select a valid date.');
            isValid = false;
        } else if (!dateRegex.test(expectedDate)) {
            $('#expected_date').addClass('is-invalid');
            $('#expected_date').after('<div class="invalid-feedback d-block">Please enter a valid date in DD-MM-YYYY format.</div>');
            toastr.error('Please enter a valid date in DD-MM-YYYY format.');
            isValid = false;
        } else {
            // Ensure date is not in the past
            var today = new Date();
            today.setHours(0, 0, 0, 0);
            var [day, month, year] = expectedDate.split('-');
            var selectedDate = new Date(year, month - 1, day);
            if (selectedDate < today) {
                $('#expected_date').addClass('is-invalid');
                $('#expected_date').after('<div class="invalid-feedback d-block">Expected date cannot be in the past.</div>');
                toastr.error('Expected date cannot be in the past.');
                isValid = false;
            }
        }

        // Proceed with submission if valid
        if (isValid) {
            $.post(form.attr('action'), form.serialize())
                .done(function(res) {
                    if (res.status) {
                        toastr.success(res.message);
                        form[0].reset();
                        iti.setNumber(''); // Reset phone input
                        dialCodeInput.value = '+' + iti.getSelectedCountryData().dialCode;
                    } else {
                        toastr.error(res.message || 'An error occurred');
                    }
                })
                .fail(function(xhr) {
                    if (xhr.status === 422) {
                        $.each(xhr.responseJSON.errors, function(key, val) {
                            var inp = form.find('[name="' + key + '"]');
                            inp.addClass('is-invalid');
                            inp.after('<div class="invalid-feedback d-block">' + val[0] + '</div>');
                            toastr.error(val[0]);
                        });
                    } else {
                        toastr.error(xhr.responseJSON?.message || 'An error occurred');
                    }
                });
        }
    });
});
</script>
@endpush