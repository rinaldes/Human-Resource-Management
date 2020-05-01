/*
 *  jQueryIntroLoader - v1.6.2
 *  "simple intro loader animations"
 *  http://factory.brainleaf.eu/jqueryIntroLoader
 *
 *  Made by BRAINLEAF Communication
 *  Released Under GNU/GPL License
 *  (c)2014-2015 by BRAINLEAF Communication
 *  
 *  
 *  BugReport/Assistence: https://github.com/Gix075/jqueryIntroLoader/issues
 */
!function(a){a.introLoader=function(b,c){var d={animation:{name:"simpleLoader",options:{exitFx:"fadeOut",ease:"linear",style:"light",delayBefore:500,delayAfter:0,exitTime:300,animationTime:300,customGif:!1,customGifBgColor:!1,progbarTime:300,progbarDelayAfter:300,loaderText:"Website is Ready!",lettersDelayTime:1,preventScroll:!1,fixed:!0,stop:!0,onAfter:function(){},onBefore:function(){}}},spinJs:{}},e=this;e.settings={};var b=(a(b),b);e.init=function(){e.settings=a.extend(!0,d,c);var g={lines:this.settings.spinJs.lines,length:this.settings.spinJs.length,width:this.settings.spinJs.width,radius:this.settings.spinJs.radius,corners:this.settings.spinJs.corners,rotate:this.settings.spinJs.rotate,direction:this.settings.spinJs.direction,color:this.settings.spinJs.color,speed:this.settings.spinJs.speed,trail:this.settings.spinJs.trail,shadow:this.settings.spinJs.shadow,hwaccel:this.settings.spinJs.hwaccel,className:this.settings.spinJs.className,zIndex:this.settings.spinJs.zIndex,top:this.settings.spinJs.top,left:this.settings.spinJs.left},i=e.settings.animation.name,k=e.settings.animation.options,g=e.settings.spinJs;switch(i){case"simpleLoader":e.spinner=new Spinner(g).spin(),h(b,k,g);break;case"doubleLoader":j(b,k);break;case"lettersLoader":e.spinner=new Spinner(g).spin(),l(b,k,g);break;case"counterLoader":e.spinner=new Spinner(g).spin(),n(b,k,g);break;case"gifLoader":f(b,k);break;default:e.spinner=new Spinner(g).spin(),h(b,k,g)}},e.stop=function(){switch(e.settings.animation.name){case"simpleLoader":i();break;case"doubleLoader":k();break;case"lettersLoader":m();break;case"counterLoader":o();break;case"gifLoader":g()}},e.destroy=function(){a(b).removeData()};var f=function(b,c){c.onBefore(),p(b,c,"gifLoader");var d="";if(0!=c.customGif&&""!=c.customGif){d="background-image: url("+c.customGif+");"}else;d+=0!=c.customGif&&""!=c.customGif&&0!=c.customGifBgColor&&""!=c.customGifBgColor?"background-color:"+c.customGifBgColor+";":"";var e="";e+='<div id="introLoaderSpinner" class="gifLoaderInner" style="'+d+'">',e+="</div>",a(b).html(e),a(b).show(),c.stop===!0&&a(window).on("load",function(){g()})},g=function(){var a=e.settings.animation.options;q(a,!1)},h=function(b,c){c.onBefore(),p(b,c,"simpleLoader");var d="";d+='<div id="introLoaderSpinner" class="introLoaderInner">',d+="</div>",a(b).html(d),a(b).show();var f=document.getElementById("introLoaderSpinner");e.spinner.spin(f),c.stop===!0&&a(window).on("load",function(){i()})},i=function(){var a=e.settings.animation.options;q(a,!0)},j=function(b,c){c.onBefore(),p(b,c,"doubleLoader");var d="";d+='<div class="doubleLoaderTop"></div>',d+='<div class="doubleLoaderBottom"></div>',d+='<div class="doubleLoaderProgBar"><span></span></div>',a(b).html(d),a(b).show(),c.stop===!0&&a(window).on("load",function(){k()})},k=function(){function c(){setTimeout(function(){a(b).find(".doubleLoaderProgBar").hide(),a(b).find(".doubleLoaderTop, .doubleLoaderBottom").animate({height:0},d.exitTime,d.ease,function(){a(b).hide(),d.preventScroll===!0&&a("body").removeClass("introLoader_preventScroll")}),a(".doubleLoaderBottom").promise().done(function(){d.onAfter()})},d.progbarTime+d.progbarDelayAfter)}var d=e.settings.animation.options;setTimeout(function(){a(b).find(".doubleLoaderProgBar").find("span").animate({width:"100%"},d.progbarTime,d.ease,c())},d.delayBefore)},l=function(b,c){c.onBefore(),p(b,c,"lettersLoader");var d=r(c.loaderText,"lettersLoaderItem"),f="";f+='<div id="introLoaderSpinner" class="introLoaderInner"></div>',f+='<div id="lettersLoaderAnimation" class="lettersLoaderRow">',f+=d,f+="</div>",a(b).html(f),a(b).show();var g=document.getElementById("introLoaderSpinner");e.spinner.spin(g),c.stop===!0&&a(window).on("load",function(){m()})},m=function(){var c=e.settings.animation.options;setTimeout(function(){e.spinner.stop(),a(b).find(".lettersLoaderRow").show();var d=a(b).find(".lettersLoaderItem");d.each(function(b){var d=this;a(d).animate({opacity:1},c.animationTime*(b+c.lettersDelayTime),c.ease)}),d.promise().done(function(){c.delayBefore=c.delayAfter,q(c,!1)})},c.delayBefore)},n=function(b,c){c.onBefore(),p(b,c,"counterLoader");var d="";d+='<div class="counterLoaderBox">',d+='   <span id="counterLoader" class="counterLoader number">0</span><span class="counterLoader percent">%</span>',d+="</div>",a(b).html(d),a(b).show(),c.stop===!0&&a(window).on("load",function(){o()})},o=function(){var c=e.settings.animation.options;setTimeout(function(){a(b).find(".counterLoaderBox").fadeIn(),a(b).find(".counterLoaderBox").promise().done(function(){jQuery({Counter:0}).animate({Counter:100},{duration:c.animationTime,easing:"swing",step:function(){a("#counterLoader").text(Math.ceil(this.Counter))},done:function(){c.delayBefore=c.delayAfter,q(c,!1)}})})},c.delayBefore)},p=function(b,c,d){c.preventScroll===!0&&a("body").addClass("introLoader_preventScroll");var e="theme-"+c.style;c.fixed===!1&&(a(b).addClass("absolute"),a(b).parent().css({position:"relative",overflow:"hidden"})),a(b).addClass("introLoader "+d+" "+e)},q=function(c,d){setTimeout(function(){switch(c.exitFx){case"fadeOut":a(b).fadeOut(c.exitTime,c.ease,function(){d===!0&&a("#introLoaderSpinner").remove(),c.preventScroll===!0&&a("body").removeClass("introLoader_preventScroll"),c.onAfter()});break;case"slideUp":d===!0&&e.spinner.stop(),a(b).animate({bottom:a(window).height()},c.exitTime,c.ease,function(){a(b).hide(),a("#introLoaderSpinner").remove(),c.preventScroll===!0&&a("body").removeClass("introLoader_preventScroll"),c.onAfter()});break;case"slideDown":d===!0&&e.spinner.stop(),a(b).animate({top:a(window).height()},c.exitTime,c.ease,function(){a(b).hide(),a("#introLoaderSpinner").remove(),c.preventScroll===!0&&a("body").removeClass("introLoader_preventScroll"),c.onAfter()});break;case"slideLeft":d===!0&&e.spinner.stop(),a(b).animate({right:a(window).width(),left:"-100%"},c.exitTime,c.ease,function(){a(b).hide(),a("#introLoaderSpinner").remove(),c.preventScroll===!0&&a("body").removeClass("introLoader_preventScroll"),c.onAfter()});break;case"slideRight":d===!0&&e.spinner.stop(),a(b).animate({left:a(window).width(),right:"-100%"},c.exitTime,c.ease,function(){a(b).hide(),a("#introLoaderSpinner").remove(),c.preventScroll===!0&&a("body").removeClass("introLoader_preventScroll"),c.onAfter()});break;default:a(b).fadeOut(c.exitTime,c.ease,function(){d===!0&&a("#introLoaderSpinner").remove(),c.preventScroll===!0&&a("body").removeClass("introLoader_preventScroll"),c.onAfter()})}},c.delayBefore)},r=function(a,b){for(var c=a.split(""),d="",e=0;e<c.length;e++){var f=b;" "==c[e]&&(f=b+"-space",c[e]=" "),d+='<span class="'+f+'">'+c[e]+"</span>"}return d};e.init()},a.fn.introLoader=function(b){return this.each(function(){if(void 0==a(this).data("introLoader")){var c=new a.introLoader(this,b);a(this).data("introLoader",c)}else{a(this).removeData("introLoader");var c=new a.introLoader(this,b);a(this).data("introLoader",c)}})}}(jQuery);