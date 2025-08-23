<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <title>@yield('title', 'Fixfellow - Tools Store Ecommerce')</title>

    <!-- favicon icon -->
    <link rel="shortcut icon" href="{{ asset('assets/buyer-assets/images/favicon.ico') }}" />

    <!-- CSS -->
    <link rel="stylesheet" type="text/css" href="{{ asset('assets/buyer-assets/css/bootstrap.min.css') }}"/>
    <link rel="stylesheet" type="text/css" href="{{ asset('assets/buyer-assets/css/animate.css') }}"/>
    <link rel="stylesheet" type="text/css" href="{{ asset('assets/buyer-assets/css/font-awesome.css') }}"/>
    <link rel="stylesheet" type="text/css" href="{{ asset('assets/buyer-assets/css/themify-icons.css') }}"/>
    <link rel="stylesheet" type="text/css" href="{{ asset('assets/buyer-assets/css/slick.css') }}">
    <link rel="stylesheet" type="text/css" href="{{ asset('assets/buyer-assets/css/slick-theme.css') }}">
    <link rel="stylesheet" type="text/css" href="{{ asset('assets/buyer-assets/revolution/css/layers.css') }}">
    <link rel="stylesheet" type="text/css" href="{{ asset('assets/buyer-assets/revolution/css/settings.css') }}">
    <link rel="stylesheet" type="text/css" href="{{ asset('assets/buyer-assets/css/magnific-popup.css') }}"/>
    <link rel="stylesheet" type="text/css" href="{{ asset('assets/buyer-assets/css/megamenu.css') }}">
    <link rel="stylesheet" type="text/css" href="{{ asset('assets/buyer-assets/css/shortcodes.css') }}"/>
    <link rel="stylesheet" type="text/css" href="{{ asset('assets/buyer-assets/css/main.css') }}"/>
    <link rel="stylesheet" type="text/css" href="{{ asset('assets/buyer-assets/css/responsive.css') }}"/>

    <script src="{{ asset('assets/buyer-assets/js/jquery-3.7.1.min.js') }}"></script>

    <link href='https://fonts.googleapis.com/css?family=DM Sans' rel='stylesheet'>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
    <style>
      body {
         font-family: 'DM Sans';
      }
    </style>

    @stack('styles')
</head>

<body>
    <!--page start-->
    <div class="page">
        @include('website.layouts.partials.header')

        @yield('content')

        @include('website.layouts.partials.footer')

        <!--back-to-top start-->
        <a id="totop" href="#top">
            <i class="fa fa-angle-up"></i>
        </a>
        <!--back-to-top end-->
    </div><!-- page end -->

    <!-- Javascript -->
    
    <script src="{{ asset('assets/buyer-assets/js/jquery-migrate-3.4.1.min.js') }}"></script>
    <script src="{{ asset('assets/buyer-assets/js/bootstrap.bundle.min.js') }}"></script> 
    <script src="{{ asset('assets/buyer-assets/js/tether.min.js') }}"></script> 
    <script src="{{ asset('assets/buyer-assets/js/jquery.easing.js') }}"></script>    
    <script src="{{ asset('assets/buyer-assets/js/jquery-waypoints.js') }}"></script>    
    <script src="{{ asset('assets/buyer-assets/js/jquery-validate.js') }}"></script> 
    <script src="{{ asset('assets/buyer-assets/js/numinate.min.js') }}"></script>
    <script src="{{ asset('assets/buyer-assets/js/slick.js') }}"></script>
    
    <script src="{{ asset('assets/buyer-assets/js/price_range_script.js') }}"></script>
    <script src="{{ asset('assets/buyer-assets/js/easyzoom.js') }}"></script>
    <script src="{{ asset('assets/buyer-assets/js/main.js') }}"></script>

    
  

   
    <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
   <script>
     window.isAuthenticated = @json(auth()->check());
     window.loginUrl = "{{ route('login') }}"; // login route URL (adjust if named differently)
    </script>
    @stack('scripts')
</body>
</html>