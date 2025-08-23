// rfq-modal.js

(function ($) {
    'use strict';

    // You need a global config object or window variable to hold Laravel route URLs
    // Example: window.rfqConfig = { submitUrl: '/route/url/here' };

    // Delegate event after products loaded
    $(document).on('click', '.open-rfq-modal', function (e) {
        e.preventDefault();

        if (!window.isAuthenticated) {
            // Redirect to login page if not logged in
            window.location.href = window.loginUrl;
            return;
        }
    
        const name = $(this).data('name');
        $('#modalProductName').val(name);
        $('#modalProductDisplay').val(name);
        $('#getBestPriceModal').modal('show');
    });

    
    // Submit rfq Form
    $('#rfqForm').on('submit', function (e) {
        e.preventDefault();

        // Remove previous errors
        $('#rfqForm .form-control, #rfqForm .form-check-input').removeClass('is-invalid');
        $('#rfqForm .invalid-feedback').text('');
        $('#unitError').text('');

        let valid = true;
        const quantity = $('#rfqQuantity').val().trim();
        const selectedUnit = $('input[name="measurement_unit"]:checked').val();

        // Validate Quantity
        if (quantity === '') {
            $('#rfqQuantity').addClass('is-invalid');
            $('#rfqQuantity').siblings('.invalid-feedback').text('Quantity is required.');
            valid = false;
        } else if (isNaN(quantity)) {
            $('#rfqQuantity').addClass('is-invalid');
            $('#rfqQuantity').siblings('.invalid-feedback').text('Please enter a valid number.');
            valid = false;
        }

        // Validate Measurement Unit
        if (!selectedUnit) {
            $('#unitError').text('Please select a measurement unit.');
            valid = false;
        }

        // If not valid, show toast message
        if (!valid) {
            showToast('Please fill all required fields correctly.', 'danger');
            return;
        }

        let form = $(this)[0];
        let formData = new FormData(form);

        // Get the submit button
        const $submitBtn = $(this).find('button[type="submit"]');

        // Disable and show spinner
        $submitBtn.prop('disabled', true).html(`
            <span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> Submitting...
        `);

        // Ajax submit
        $.ajax({
            url: window.rfqConfig.submitUrl,
            method: 'POST',
            data: formData,
            processData: false,
            contentType: false,
            success: function (res) {
                if (res.success) {
                    $('#getBestPriceModal').modal('hide');
                    $('#rfqForm')[0].reset();
                    $('#successModal').modal('show');
                } else {
                    showToast('Error submitting RFQ. Please try again.', 'danger');
                }
            },
            error: function () {
                showToast('Something went wrong. Try again.', 'danger');
            },
            complete: function () {
                // Re-enable button and restore text after request finishes
                $submitBtn.prop('disabled', false).html('Submit...');
            }
        });
    });


    function showToast(message, type = 'success') {
        const toastEl = $('#rfqToast');
        const toastMsg = $('#rfqToastMessage');

        toastMsg.text(message);
        toastEl.removeClass('bg-success bg-danger bg-warning').addClass('bg-' + type);

        const toast = new bootstrap.Toast(toastEl[0]);
        toast.show();
    }

})(jQuery);
