/** ==========================================================================================

  Project :   Fixfellow - Tools Store Ecommerce Html Template
  Author :    Themetechmount
  Version :   Bootstrap 5.3.3
  Author URI: http://www.themetechmount.com

========================================================================================== */


/** ===============

01. Newsletter Popup
02. Fixed-header
03. Menu
04. Number rotator
05. Tab
06. Isotope
07. Slick_slider
08. EasyZoom
09. modal1
10. quantity
11. slider-range
12. menu-vertical
13. create_account 
14. payment_methods
15. Back to top 

 =============== */


(function($) {

   'use strict'

   
/*------------------------------------------------------------------------------*/
/* 01. Newsletter Popup
/*------------------------------------------------------------------------------*/
    setTimeout(function() {
        $('.newsletter_popup_wrap').addClass('st-show');
    }, 2400);

    jQuery(".newsletter_popup_wrap .close").on('click',function(){
        jQuery(".newsletter_popup_wrap").removeClass('st-show');
    });
    jQuery('.newsletter_popup_wrap .close').on('click',function(event){event.stopPropagation()});



/*------------------------------------------------------------------------------*/
/* 02. Fixed-header
/*------------------------------------------------------------------------------*/
    $(window).scroll(function(){
        if ( matchMedia( 'only screen and (min-width: 1200px)' ).matches ) 
        {
            if ($(window).scrollTop() >= 50 ) {

                $('.stickable-header').addClass('fixed-header');
            }
            else {

                $('.stickable-header').removeClass('fixed-header');
            }
        }
    });


    
/*------------------------------------------------------------------------------*/
/* 03. Menu
/*------------------------------------------------------------------------------*/
        var menu = {
        initialize: function() {
            this.Menuhover();
        },

        Menuhover : function(){
            var getNav = $("nav.menu"),
                getWindow = $(window).width(),
                getHeight = $(window).height(),
                getIn = getNav.find("ul.nav").data("in"),
                getOut = getNav.find("ul.nav").data("out");
            
                                                     
                // Enable click event
                $("nav.menu ul.nav").each(function(){
                    
                    // Dropdown Fade Toggle
                    $("a.mega-menu-link", this).on('click', function (e) {
                        e.preventDefault();
                        var t = $(this);
                        t.toggleClass('active').next('ul').toggleClass('active');
                    });   
                    

                    // Megamenu style
                    $(".megamenu-fw", this).each(function(){
                        $(".col-menu", this).each(function(){
                            $(".title", this).off("click");
                            $(".title", this).on("click", function(){
                                $(this).closest(".col-menu").find(".content").stop().toggleClass('active');
                                $(this).closest(".col-menu").toggleClass("active");
                                return false;
                                e.preventDefault();
                                
                            });

                        });
                    });  
                }); 


        },
    };

    $('.btn-show-menu-mobile').on('click', function(){
        $(this).toggleClass('is-active');
        $('.menu-mobile').slideToggle();
    });
    
    // Initialize
    $(document).ready(function(){
        menu.initialize();

    });
      

    
/*------------------------------------------------------------------------------*/
/* 04. Animation on scroll: Number rotator
/*------------------------------------------------------------------------------*/
    $("[data-appear-animation]").each(function() {
    var self      = $(this);
    var animation = self.data("appear-animation");
    var delay     = (self.data("appear-animation-delay") ? self.data("appear-animation-delay") : 0);
        
        if( $(window).width() > 959 ) {
            self.html('0');
            self.waypoint(function(direction) {
                if( !self.hasClass('completed') ){
                    var from     = self.data('from');
                    var to       = self.data('to');
                    var interval = self.data('interval');
                    self.numinate({
                        format: '%counter%',
                        from: from,
                        to: to,
                        runningInterval: 2000,
                        stepUnit: interval,
                        onComplete: function(elem) {
                            self.addClass('completed');
                        }
                    });
                }
            }, { offset:'85%' });
        } else {
            if( animation == 'animateWidth' ) {
                self.css('width', self.data("width"));
            }
        }
    });


/*------------------------------------------------------------------------------*/
/* 05. Tab
/*------------------------------------------------------------------------------*/ 
    $(document).ready(function() { 
        
        $('.content-tab').children('.content-inner').first().addClass('active');
        $('.ttm-tabs .tabs li').on('click', function(e) {  
            if (!$(this).hasClass('active')) { 
                var i = $(this).index(); 
                $('.ttm-tabs .tabs li.active').removeClass('active'); 
                $('.content-tab .active').hide().removeClass('active'); 
                $(this).addClass('active'); 
                $($('.content-tab').children('.content-inner')[i]).fadeIn(600).addClass('active');
                e.preventDefault();
            } 
        });
    });


/*------------------------------------------------------------------------------*/
/* 06. Isotope
/*------------------------------------------------------------------------------*/
    $(window).on('load', function() {

    var $container = $('#isotopeContainer');

    // filter items when filter link is clicked
    $('#filters a').on('click', function(){
      var selector = $(this).attr('data-filter');
      $container.isotope({ filter: selector });
      return false;
    });

    var $optionSets = $('#filters li'),
        $optionLinks = $optionSets.find('a');

        $optionLinks.on('click',function(){
            var $this = $(this);
            // don't proceed if already selected
            if ( $this.hasClass('selected') ) {
              return false;
            }
            var $optionSet = $this.parents('#filters');
            $optionSet.find('.selected').removeClass('selected');
            $this.addClass('selected');

            // make option object dynamically, i.e. { filter: '.my-filter-class' }
            var options = {},
                key = $optionSet.attr('data-option-key'),
                value = $this.attr('data-option-value');
            // parse 'false' as false boolean
            value = value === 'false' ? false : value;
            options[ key ] = value;
            if ( key === 'layoutMode' && typeof changeLayoutMode === 'function' ) {
              // changes in layout modes need extra logic
              changeLayoutMode( $this, options )
            } else {
              // otherwise, apply new options
              $container.isotope( options );
            }

            return false;
        });
   });


/*------------------------------------------------------------------------------*/
/* 07. Slick_slider
/*------------------------------------------------------------------------------*/

    $(".slick_slider").slick({
        speed: 1500,
        dots: false,                     
        autoplay: false,
        infinite: false,
        slidesToShow: 3,
        slidesToScroll: 3,

        responsive: [{

            breakpoint: 1000,
            settings: {
                slidesToShow: 3,
                slidesToScroll: 3
            }
        },
        {
        breakpoint: 820,
            settings: {
                slidesToShow: 2,
                slidesToScroll: 2
            }
        },
        {
            breakpoint: 500,
            settings: {
                slidesToShow: 1,
                slidesToScroll: 1
            }
       
        }]
    });

    $(".pro_slick_slider").slick({
        speed: 1500,
        dots: false,    
        arrows: false,                 
        autoplay: false,
        infinite: false,
        slidesToShow: 3,
        slidesToScroll: 3,

        responsive: [{

            breakpoint: 768,
            settings: {
                slidesToShow: 3,
                slidesToScroll: 3
            }
        },
        {
            breakpoint: 575,
            settings: {
                slidesToShow: 2,
                slidesToScroll: 2
            }
        }]
    });
    

    $(".testimonial_slick_slider").slick({
        speed: 1500,
        dots: false,                     
        autoplay: false,
        infinite: false,
        slidesToShow: 3,
        slidesToScroll: 3,

        responsive: [{

            breakpoint: 1000,
            settings: {
                slidesToShow: 1,
                slidesToScroll: 1
            }
               
        }]
    });

    /* easyzoom */
    $(".easyzoom-gallery-slider").slick({
        speed: 1000,
        arrows: false,
        dots: false,                   
        autoplay: false,
        infinite: false,
        responsive: [{

            breakpoint: 768,
            settings: {
                slidesToShow: 3,
                slidesToScroll: 1
            }
        },
        {
            breakpoint: 480,
            settings: {
                slidesToShow: 2,
                slidesToScroll: 1
            }
        }]
       
    });
     

/*------------------------------------------------------------------------------*/
/* 08. EasyZoom
/*------------------------------------------------------------------------------*/
    var $easyzoom = $('.easyzoom').easyZoom();

    // Setup thumbnails example
    var api1 = $easyzoom.filter('.easyzoom--with-thumbnails').data('easyZoom');

    $('.thumbnails').on('click', 'a', function(e) {
        var $this = $(this);

        e.preventDefault();

        // Use EasyZoom's `swap` method
        api1.swap($this.data('standard'), $this.attr('href'));
    });


    var $easyzoom2 = $('.easyzoom-model').easyZoom();

    // Setup thumbnails example
    var api2 = $easyzoom2.filter('.easyzoom--with-thumbnails').data('easyZoom');

    $('.thumbnails').on('click', 'a', function(e) {
        var $this = $(this);

        e.preventDefault();

        // Use EasyZoom's `swap` method
        api2.swap($this.data('standard'), $this.attr('href'));
    });

    // Setup toggles example
    var api3 = $easyzoom.filter('.easyzoom--with-toggle').data('easyZoom');

    $('.toggle').on('click', function() {
        var $this = $(this);

        if ($this.data("active") === true) {
            $this.text("Switch on").data("active", false);
            api3.teardown();
        } else {
            $this.text("Switch off").data("active", true);
            api3._init();
        }
    });


/*------------------------------------------------------------------------------*/
/* 09. modal1
/*------------------------------------------------------------------------------*/
    $('.js-show-modal1').on('click',function(e){
        e.preventDefault();
        $('.js-modal1').addClass('show-modal1');
    });

    $('.js-hide-modal1').on('click',function(){
        $('.js-modal1').removeClass('show-modal1');
    });
        

/*------------------------------------------------------------------------------*/
/* 10. quantity
/*------------------------------------------------------------------------------*/
    $('.quantity-button').on('click', function(){
        var numberValue= $(this).parent().find('.qty').val();

        if($(this).text()=="+") {
            var newVal=parseFloat(numberValue) + 1;
        }else{
            if(numberValue > 0){
                var newVal = parseFloat(numberValue) -1;
            }else{
                newVal = 0;
            }
        }

        $(this).parent().find('.qty').val(newVal);
    });


/*------------------------------------------------------------------------------*/
/* 11. slider-range
/*------------------------------------------------------------------------------*/
    $(function () {
        $("#slider-range").slider({
            range: true,
            orientation: "horizontal",
            min: 0,
            max: 999,
            values: [0, 780],

            slide: function (event, ui) {
                if ( "$" + ui.values[0] =="$" + ui.values[1]) {
                    return false;
                }
              
                $("#min_price").val("$" + ui.values[0]);
                $("#max_price").val("$" + ui.values[1]);
            }
        });

        $("#min_price").val("$" + $("#slider-range").slider("values", 0));
        $("#max_price").val("$" + $("#slider-range").slider("values", 1));

    });


/*------------------------------------------------------------------------------*/
/* 12. menu-vertical
/*------------------------------------------------------------------------------*/

     $('.menu-vertical > li.parent-plus > a, .menu-vertical > li.parent > a').on('click', function(e){
        if ( 0 < $(this).next(".plus-menu, .megamenu").length ) {
          e.preventDefault();
        }
        if ( 0 == $(this).next(".plus-menu, .megamenu").length ) {
          return;
        }
        if ( $(this).hasClass('open') ) {
          $(this).removeClass('open').next(".plus-menu, .megamenu").slideUp(300);
          return;
        }
        $(this).parents(".menu-vertical").find("> li.parent-plus > a, .menu-vertical > li.parent > a").removeClass('open');
        $(this).parents(".menu-vertical").find(".plus-menu, .megamenu").not(":hidden").slideUp(300);
        $(this).addClass('open').next(".plus-menu, .megamenu").slideDown(300);
    });


    $(".header").each(function(){  
        $(".cat_menu_container > a.cat_menu", this).on("click", function(e){

            e.preventDefault();
            e.stopPropagation();

            $(".header .cat_menu_list").toggleClass("on");
            $(this).toggleClass("on-cat_menu");

            $(document).on('click', function closeMenu (e){

                if($('.header .cat_menu_list').has(e.target).length === 0){
                    $('.header .cat_menu_list').removeClass('on');
                } else {
                    $(document).on('click', closeMenu);
                }
            });

            $(".close-side").on("click", function(e){
                e.preventDefault();
                $('.header .cat_menu_list').removeClass('on');
            });  

        });
    });


/*------------------------------------------------------------------------------*/
/* 13. create_account
/*------------------------------------------------------------------------------*/
    $("#create_account :checkbox").on('click dblclick', function(evt) {
        console.log(evt.type);
        if ($(this).is(":checked")) {
            $('.collapse').slideDown('fast');
        } else {
            $('.collapse').slideUp('fast');
        }
    });


/*------------------------------------------------------------------------------*/
/* 14. payment_methods
/*------------------------------------------------------------------------------*/
    $(".payment-detail").hide();
    $(':input[type="radio"]').on('change', function() {
        $(".payment-detail").slideUp();
        $(this).parent('label').next('div').slideToggle(this.checked);
    });

/*------------------------------------------------------------------------------*/
/* 15. Back to top
/*------------------------------------------------------------------------------*/

// ===== Scroll to Top ==== 
jQuery('#totop').hide();

jQuery(window).scroll(function() {
    "use strict";
    if (jQuery(this).scrollTop() >= 100) {        // If page is scrolled more than 50px
        jQuery('#totop').fadeIn(200);    // Fade in the arrow
        jQuery('#totop').addClass('top-visible');
    } else {
        jQuery('#totop').fadeOut(200);   // Else fade out the arrow
        jQuery('#totop').removeClass('top-visible');
    }
});

jQuery('#totop').on('click', function() {      // When arrow is clicked
    jQuery('body,html').animate({
        scrollTop : 0                       // Scroll to top of body
    }, 500);
    return false;
});

   
 $(function() {

    });

})(jQuery);