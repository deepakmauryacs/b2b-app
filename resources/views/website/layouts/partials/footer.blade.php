<!--footer start-->
<footer class="footer widget-footer ttm-bg ttm-bgimage-yes ttm-bgcolor-darkgrey ttm-textcolor-white clearfix">
    <div class="ttm-row-wrapper-bg-layer ttm-bg-layer"></div>
    <div class="first-footer">
        <div class="container">
            <div class="row">
                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-4 widget-area">
                    <div class="widget ttm-footer-cta-wrapper">
                        <h5>Join Our Newsletter Now!</h5>
                    </div>
                </div>
                <div class="col-xs-12 col-sm-12 col-md-8 col-lg-5 widget-area m-auto">
                    <div class="widget ttm-footer-cta-wrapper">
                        <form id="subscribe-form" class="newsletter-form" method="post" action="#" data-mailchimp="true">
                            <div class="mailchimp-inputbox clearfix" id="subscribe-content"> 
                                <p>
                                    <i class="fa fa-envelope-o"></i>
                                    <input type="email" name="email" placeholder="Your Email Add.." required="">
                                </p>
                                <p><input type="submit" value="SUBMIT"></p>
                            </div>
                            <div id="subscribe-msg"></div>
                        </form>
                    </div>
                </div>
                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-3 widget-area">
                    <div class="social-icons social-hover widget text-center">
                        <ul class="list-inline">
                            <li class="social-facebook"><a class="tooltip-top" href="https://www.facebook.com/prt.333/" data-tooltip="Facebook" target="_blank"><i class="fa fa-facebook" aria-hidden="true"></i></a></li>
                            <li class="social-twitter"><a class="tooltip-top" href="https://twitter.com/PreyanTechnosys" data-tooltip="Twitter" target="_blank"><i class="fa fa-twitter" aria-hidden="true"></i></a></li>
                            <li class="social-instagram"><a class="tooltip-top" href="https://www.instagram.com/preyan_technosys/" data-tooltip="instagram" target="_blank"><i class="fa fa-instagram" aria-hidden="true"></i></a></li>
                            <li class="social-linkedin"><a class="tooltip-top" href="https://www.linkedin.com/in/preyan-technosys-pvt-ltd/" data-tooltip="LinkedIn" target="_blank"><i class="fa fa-linkedin" aria-hidden="true"></i></a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="sep_holder_box">
        <span class="sep_holder"><span class="sep_line"></span></span>
    </div>
    <div class="second-footer">
        <div class="container">
            <div class="row">
               <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3 widget-area mr-auto">
                    <div class="widget widget_text pr-25 clearfix">
                        <h3 class="widget-title">About Us</h3>
                        <div class="textwidget widget-text">
                            <p class="pb-10">
                                <a href="https://www.deal24hours.com" target="_blank" rel="noopener">Deal24Hours.com</a> — A secure B2B platform connecting buyers and sellers for faster, smarter, and more transparent trade.
                            </p>
                        </div>
                    </div>
                </div>

                <div class="col-xs-12 col-sm-6 col-md-6 col-lg-3 widget-area">
                    <div class="widget widget_nav_menu clearfix">
                       <h3 class="widget-title">Our Company</h3>
                       <ul class="menu-footer-quick-links">
                        
                            <li><a href="{{ route('buyer.about') }}">About Us</a></li>
                            <li><a href="{{ route('buyer.about') }}">Privacy Policy</a></li>
                            <li><a href="{{ route('buyer.about') }}">Terms & Conditions</a></li>
                           
                        </ul>
                    </div>
                </div>
                <div class="col-xs-12 col-sm-6 col-md-6 col-lg-3 widget-area">
                    <div class="widget widget_nav_menu clearfix">
                       <h3 class="widget-title">Top Products</h3>
                       <ul class="menu-footer-quick-links">
                            <li><a href="#">Price Drops</a></li>
                            <li><a href="#">New Products</a></li>
                            <li><a href="#">Best Sales</a></li>
                            <li><a href="#">Contact Us</a></li>
                            <li><a href="#">Site Map</a></li>
                        </ul>
                    </div>
                </div>
                <div class="col-xs-12 col-sm-6 col-md-6 col-lg-3 widget-area">
                    <div class="widget contact_map clearfix">
                        <h3 class="widget-title">Global Vendors</h3>
                        <div class="footer_map mb-30 mt-5">
                            <img src="{{ asset('assets/buyer-assets/images/footer_map.png') }}" alt="">
                        </div>
                        
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="sep_holder_box">
        <span class="sep_holder"><span class="sep_line"></span></span>
    </div>
    <div class="bottom-footer-text">
        <div class="container">
            <div class="row copyright">
                <div class="col-md-12 col-lg-12 ttm-footer2-center">
                    <span>Copyright © {{ date('Y') }} <a href="https://www.deal24hours.com/">Deal24Hours.com</a></span>
                </div>
               
            </div>
        </div>
    </div>
</footer>
<!--footer end-->