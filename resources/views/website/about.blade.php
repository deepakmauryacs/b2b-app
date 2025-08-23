@extends('website.layouts.app')

@section('title', 'About Us')

@push('styles')
<style>
    .icon-list li {
        padding-left: 1.5rem;
        position: relative;
        margin-bottom: 0.75rem;
    }
    .icon-list li::before {
        content: "✔";
        position: absolute;
        left: 0;
        color: #0d6efd;
        font-weight: bold;
    }
</style>
@endpush

@section('content')

<!-- Page Title / Breadcrumb -->
<div class="ttm-page-title-row">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <div class="d-flex justify-content-between align-items-center">
                    <div class="page-title-heading">
                        <h1 class="title">About Us</h1>
                    </div>
                    <div class="breadcrumb-wrapper">
                        <span class="mr-1"><i class="ti ti-home"></i></span>
                        <a title="Homepage" href="{{ route('buyer.index') }}">Home</a>
                        <span class="ttm-bread-sep">&nbsp;/&nbsp;</span>
                        <span class="ttm-textcolor-skincolor">About Us</span>
                    </div>
                </div>
            </div>
        </div>  
    </div>                    
</div>

<!-- Who We Are -->
<section class="py-5">
    <div class="container">
        <h2 class="section-heading">Welcome to Deal24Hours</h2>
        <p class="section-subheading">
            A leading B2B marketplace built to simplify and accelerate procurement for businesses of all sizes.
        </p>

        <p class="mt-4">
            Deal24Hours.com bridges the gap between buyers and vendors by offering a transparent, tech-driven platform for RFQs, live auctions, and seamless product sourcing.
        </p>
        <p class="mt-3">
            Our mission is to digitize procurement with trust, speed, and smart tools that bring the right buyers and sellers together.
        </p>
        <p class="mt-3">
            Whether you're a small business or a large enterprise, Deal24Hours adapts to your needs with powerful tools and real-time collaboration.
        </p>
        <p class="mt-3">
            We empower vendors by giving them access to thousands of active buyers across various industries and geographies.
        </p>
        <p class="mt-3">
            Our platform supports categories like industrial machinery, electronics, office supplies, safety equipment, and more.
        </p>
        <p class="mt-3">
            With advanced filters, analytics, and messaging, we eliminate procurement friction and support smarter decisions.
        </p>
        <p class="mt-3">
            Secure login for buyers and vendors ensures visibility over RFQs, live auctions, and negotiations.
        </p>
        <p class="mt-3">
            All users are verified through internal KYC for credibility and reduced risk.
        </p>
        <p class="mt-3">
            We're building a procurement ecosystem where time, cost, and trust are equally prioritized.
        </p>
        <p class="mt-3">
            Our support team is available 24/7 to assist with onboarding, tech support, or dispute resolution.
        </p>
        <p class="mt-3">
            Deal24Hours is always evolving to stay ahead through feedback, innovation, and insights.
        </p>
        <p class="mt-3">
            Join us and experience the future of B2B procurement — efficient, connected, and result-driven.
        </p>
        <p class="mt-3 fw-bold">
            Together, let’s transform how businesses buy, sell, and grow.
        </p>
    </div>
</section>

<!-- Global Presence -->
<section class="bg-light py-5">
    <div class="container">
        <h3 class="section-heading">Our Global Presence</h3>
        <div class="row mt-4">
            @php
                $countries = ['🇺🇸 USA', '🇬🇧 UK', '🇮🇳 India', '🇩🇪 Germany', '🇨🇳 China', '🇦🇺 Australia', '🇧🇷 Brazil', '🌍 And More...'];
            @endphp
            @foreach ($countries as $country)
                <div class="col-6 col-md-3 mb-3">{{ $country }}</div>
            @endforeach
        </div>
    </div>
</section>

<!-- Most Important Features -->
<section class="py-5">
    <div class="container">
        <h3 class="section-heading">Most Important Features</h3>
        <ul class="icon-list list-unstyled mt-4">
            <li>Transparent procurement with verified vendors</li>
            <li>Digital RFQ submission and response tracking</li>
            <li>Live auctions for instant, competitive pricing</li>
            <li>Schedule RFQs and automate procurement cycles</li>
            <li>Secure buyer-vendor messaging and negotiation logs</li>
            <li>Multi-product RFQs and bulk upload options</li>
            <li>Insightful analytics and vendor performance metrics</li>
        </ul>
    </div>
</section>

<!-- RFQ Generation -->
<!-- <section class="py-5">
    <div class="container">
        <h3 class="section-heading">RFQ Generation</h3>
        <p class="section-subheading">Create and dispatch Requests for Quotation to multiple vendors in minutes.</p>

        <p class="mt-4">
            Our intuitive RFQ Generation system allows buyers to define product needs, set quantity requirements, attach specs, and send RFQs to verified vendors effortlessly. Track responses, compare quotes, and make smarter purchasing decisions from a single dashboard.
        </p>

        <div class="mt-4">
            <h5 class="fw-bold">Features Include:</h5>
            <ul class="icon-list list-unstyled">
                <li>Easy RFQ creation form with multi-product support</li>
                <li>Bulk RFQ upload for large procurement needs</li>
                <li>Auto-matching with suitable vendors</li>
                <li>Real-time response tracking and alerts</li>
            </ul>
        </div>
    </div>
</section> -->

<!-- RFQ Scheduling -->
<!-- <section class="py-5">
    <div class="container">
        <h3 class="section-heading">RFQ Scheduling</h3>
        <p class="section-subheading">Plan and automate your procurement workflows with ease.</p>

        <p class="mt-4">
            Buyers can schedule RFQs in advance, ensuring vendors receive timely notifications and respond promptly. This feature helps in organizing procurement cycles with clarity and structure.
        </p>

        <div class="mt-4">
            <h5 class="fw-bold">Benefits of RFQ Scheduling:</h5>
            <ul class="icon-list list-unstyled">
                <li>Plan ahead with scheduled postings</li>
                <li>Get notified responses on time</li>
                <li>Enhance vendor participation</li>
                <li>Better pricing & quote comparison</li>
            </ul>
        </div>
    </div>
</section> -->

<!-- Live Auctions -->
<!-- <section class="bg-light py-5">
    <div class="container">
        <h3 class="section-heading">Live Auctions</h3>
        <p class="section-subheading">Empowering buyers with real-time competitive pricing from trusted vendors.</p>

        <p class="mt-4">
            With our <strong>Live Auction</strong> system, buyers can post RFQs and receive the best prices from multiple vendors instantly. Vendors compete in real-time, helping you make quicker and more cost-effective decisions.
        </p>

        <div class="mt-4">
            <h5 class="fw-bold">Key Advantages:</h5>
            <ul class="icon-list list-unstyled">
                <li>Transparent & real-time bidding</li>
                <li>Global vendor participation</li>
                <li>Faster decision making</li>
                <li>Cost savings through competition</li>
            </ul>
        </div>
    </div>
</section> -->

@endsection

@push('scripts')
{{-- Page-specific JS if needed --}}
@endpush
