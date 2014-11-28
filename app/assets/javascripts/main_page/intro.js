function ShowHeight(element) {
    console.log("The height for the " + element + " is " + $(element).height() + "px." )
};

function ShowWidth(element) {
    console.log("The width for the " + element + " is " + $(element).width() + "px." )
};

function koefficent(element){
    return $(element).height()/$(window).height();
}

function setSize(element,w,  kheight, kwidth) {
    element.height(kheight * w.height()).width(kwidth * w.width());
    
}

function setCenter(element, k) {
    element.offset({left: ($(window).width() - element.width())/2,
		    top: ($(window).height() - element.height())/k });
}

function setHeightStart(element) {
    element.offset({top: ($(window).height() - element.height())/2});
}

function startPos(element) {
    element.offset({left: -2000});
}
$( document ).ready(function() {
    var eH = 200/915;
    var eW = 844/1280;
    var sH = 99/915;
    var sW = 811/1280;
    var logo = $("#logo");
    var start = $("#start");
    $(".intro-body").on("click", function (){
	window.location.href = "/index";
    });
    /*var window = $(window);
    console.log("window", window);
    console.log(window.height());*/
    
    
    console.log("eH is " + eH);
    console.log("eW is " + eW);
    console.log("window height is " + $(window).height()+ "px");
    console.log("window width is " + $(window).width()+ "px");
    
    w = $(window);
    w.resize(function(){
	setSize(logo, w, eH, eW);
	setSize(start,w, sH, sW);
	setCenter(logo, 4);
	setHeightStart(start);
	
	
    });
    ShowHeight("#logo");
    ShowHeight(window);
    ShowWidth("#logo");
    ShowWidth(window);
    console.log("window height is " + $(window).height()+ "px");
    console.log("window width is " + $(window).width()+ "px");
    logo.height(eH * w.height()).width(eW * w.width());
    console.log(koefficent("#logo"));

    
    
    ShowHeight("#logo");
    ShowWidth("#logo");
    function animateBox(logo, start){
	setHeightStart(start);
	startPos(start);
	setCenter(logo,4);
    
	

    
	$("#logo").slideUp( 4000, "easeOutElastic")
                  .slideDown(5000, "easeOutBounce", function(){
		      start.animate({left: ($(window).width() - start.width())/2 }, 4000, "easeOutBounce").fadeOut(4000).fadeIn(4000, "easeOutElastic", function(){
			  animateBox(logo,start);
		      });  
		  });
};
    animateBox(logo, start);
    /*$("#logo").slideUp(4000).slideDown(5000);*/
    
});


