
/*------------------------------------------------------------------------------*/
/*  Home_Page Slider
/*------------------------------------------------------------------------------*/
var revapi51,
tpj=jQuery;


/* header classicinfo (homepage -1 )*/

 tpj(document).ready(function() {
  if(tpj("#rev_slider_5_1").revolution == undefined){
      revslider_showDoubleJqueryError("#rev_slider_5_1");
    }else{
      revapi51 = tpj("#rev_slider_5_1").show().revolution({
        sliderType:"standard",
        sliderLayout: 'fullwidth',
        autoHeight: 'on',
        maxHeight: '647px',
        fullWidth: 'on',
        dottedOverlay:"none",
        delay:6000,
        navigation: {
          keyboardNavigation:"off",
          keyboard_direction: "horizontal",
          mouseScrollNavigation:"off",
          mouseScrollReverse:"default",
          onHoverStop:"off",
          touch:{
            touchenabled:"on",
            swipe_threshold: 75,
            swipe_min_touches: 1,
            swipe_direction: "horizontal",
            drag_block_vertical: false
          }
          ,
          arrows: {
            style:"zeus",
            enable:true,
            hide_under:991,
            hide_onleave:true,
            tmp:'',
            left: {
              h_align:"left",
              v_align:"center",
              h_offset:20,
              v_offset:0
            },
            right: {
              h_align:"right",
              v_align:"center",
              h_offset:20,
              v_offset:0
            }
          }
        },
        responsiveLevels:[1240,1024,777,480],
        visibilityLevels:[1240,1024,777,480],
        gridwidth:[1270,1180,750,580],
        gridheight:[647,647,452,380],
        lazyType: "smart",
        parallax: {
            type: "scroll",
            origo: "enterpoint",
            speed: 400,
            levels: [5,10,15,20,25,30,35,40,45,50],
        },
        shadow:0,
        spinner:"off",
        stopLoop:"off",
        stopAfterLoops:-1,
        stopAtSlide:-1,
        shuffle:"off",
        autoHeight:"off",
        disableProgressBar:"on",
        hideThumbsOnMobile:"off",
        hideSliderAtLimit:0,
        hideCaptionAtLimit:0,
        hideAllCaptionAtLilmit:0,
        debugMode:false,
        fallbacks: {
            simplifyAll:"off",
            nextSlideOnWindowFocus:"off",
            disableFocusListener:false,
        }
      });
    }
  });
 

/* homepage -2 */
 tpj(document).ready(function() {
  if(tpj("#rev_slider_5_2").revolution == undefined){
      revslider_showDoubleJqueryError("#rev_slider_5_2");
    }else{
      revapi41 = tpj("#rev_slider_5_2").show().revolution({
        sliderType:"standard",
        sliderLayout: 'fullwidth',
        autoHeight: 'on',
        maxHeight: '661px',
        fullWidth: 'on',
        dottedOverlay:"none",
        delay:6000,
        navigation: {
          keyboardNavigation:"off",
          keyboard_direction: "horizontal",
          mouseScrollNavigation:"off",
          mouseScrollReverse:"default",
          onHoverStop:"off",
          touch:{
            touchenabled:"on",
            swipe_threshold: 75,
            swipe_min_touches: 1,
            swipe_direction: "horizontal",
            drag_block_vertical: false
          }
          ,
          arrows: {
            style:"zeus",
            enable:true,
            hide_under:991,
            hide_onleave:true,
             tmp:'',
            left: {
              h_align:"left",
              v_align:"center",
              h_offset:20,
              v_offset:0
            },
            right: {
              h_align:"right",
              v_align:"center",
              h_offset:20,
              v_offset:0
            }
          }
        },
         viewPort: {
            enable:true,
            outof:"pause",
            visible_area:"100%",
            presize:false
        },
        responsiveLevels:[1240,1024,777,480],
        visibilityLevels:[1240,1024,777,480],
        gridwidth:[1270,1000,777,580],
        gridheight:[661,650,480,420],
        lazyType:"none",
        parallax: {
            type:"mouse",
            origo:"slidercenter",
            speed:2000,
            levels:[2,3,4,5,6,7,12,16,10,50,46,47,48,49,50,55],
            type:"mouse",
        },
        shadow:0,
        spinner:"off",
        stopLoop:"off",
        stopAfterLoops:-1,
        stopAtSlide:-1,
        shuffle:"off",
        autoHeight:"off",
        disableProgressBar:"on",
        hideThumbsOnMobile:"off",
        hideSliderAtLimit:0,
        hideCaptionAtLimit:0,
        hideAllCaptionAtLilmit:0,
        debugMode:false,
        fallbacks: {
            simplifyAll:"off",
            nextSlideOnWindowFocus:"off",
            disableFocusListener:false,
        }
      });
    }
  });
 

/* homepage - 3 */
 tpj(document).ready(function() {
  if(tpj("#rev_slider_5_3").revolution == undefined){
      revslider_showDoubleJqueryError("#rev_slider_5_3");
    }else{
      revapi41 = tpj("#rev_slider_5_3").show().revolution({
        sliderType:"standard",
        sliderLayout: 'fullwidth',
        autoHeight: 'on',
        maxHeight: '650px',
        fullWidth: 'on',
        dottedOverlay:"none",
        delay:6000,
        navigation: {
          keyboardNavigation:"off",
          keyboard_direction: "horizontal",
          mouseScrollNavigation:"off",
          mouseScrollReverse:"default",
          onHoverStop:"off",
          touch:{
            touchenabled:"on",
            swipe_threshold: 75,
            swipe_min_touches: 1,
            swipe_direction: "horizontal",
            drag_block_vertical: false
          }
          ,
          arrows: {
            style:"zeus",
            enable:true,
            hide_under:991,
            hide_onleave:true,
            tmp:'',
            left: {
              h_align:"left",
              v_align:"center",
              h_offset:20,
              v_offset:0
            },
            right: {
              h_align:"right",
              v_align:"center",
              h_offset:20,
              v_offset:0
            }
          }
        },
         viewPort: {
            enable:true,
            outof:"pause",
            visible_area:"100%",
            presize:false
        },
        responsiveLevels:[1240,1024,777,480],
        visibilityLevels:[1240,1024,777,480],
        gridwidth:[1270,1180,800,580],
        gridheight: [650,560,440,350], 
        lazyType:"none",
        parallax: {
            type:"mouse",
            origo:"slidercenter",
            speed:2000,
            levels:[2,3,4,5,6,7,12,16,10,50,46,47,48,49,50,55],
            type:"mouse",
        },
        shadow:0,
        spinner:"off",
        stopLoop:"off",
        stopAfterLoops:-1,
        stopAtSlide:-1,
        shuffle:"off",
        autoHeight:"off",
        disableProgressBar:"on",
        hideThumbsOnMobile:"off",
        hideSliderAtLimit:0,
        hideCaptionAtLimit:0,
        hideAllCaptionAtLilmit:0,
        debugMode:false,
        fallbacks: {
            simplifyAll:"off",
            nextSlideOnWindowFocus:"off",
            disableFocusListener:false,
        }
      });
    }
  }); 
