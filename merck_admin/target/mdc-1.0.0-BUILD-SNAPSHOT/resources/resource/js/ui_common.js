

// layout
$(document).ready(function() {
	conSize();
});


$(window).on("load", function() {
 	conSize();
});


$(window).on("resize", function() {
	conSize();
});


function conSize(){
	$(".wrap").removeAttr("style");
	var docH = $(document).height();
	$(".wrap").css("height", docH);
};


//lnb_tab
$(document).on("click", ".lnb_tab a", function(){
	$(".lnb_tab a").removeClass("on");
	$(this).addClass("on");
	conSize();
});


// gnb_menu
$(document).on("click", ".gnb_menu a", function(){
	$(".gnb_menu a").removeClass("on");
	$(this).addClass("on");
});


// lnb_menu
$(document).on("click", ".lnb_menu a", function(){
	var menu = $(this).hasClass("on");
	if (menu == true){
		$(this).removeClass("on").next(".lnb_menu_depth").hide();
	} else {
		$(this).addClass("on").next(".lnb_menu_depth").show();
	}
	conSize();
});


// lnb_menu_depth
$(document).on("click", ".lnb_menu_depth a", function(){
	$(".lnb_menu_depth a").removeClass("on");
	$(this).addClass("on");
	conSize();
});


// layerPopup open
$(document).on("click", ".popup_open", function(){
	var layer = $(this).attr("data-name") || $(this).attr("href");
	var layerName = layer.replace("#", "");

	$(this).addClass('current');
	$("#" + layerName).css("display", "block");
	$("#" + layerName).find();
	$("#" + layerName).prepend("<span class='st' tabindex='0'></span>").append("<span class='ed' tabindex='0'></span>");
	$(".pop_head > h1").focus();
	$("html, body").css("overflow", "hidden");

	var popSizeH = $("#" + layerName).find(".popup_wrap").outerHeight();
	$("#" + layerName).find(".popup_wrap").css({"margin-top": - (popSizeH / 2)});
});

// layerPopup close
$(document).on("click", ".popup_close", function(){
	var focus = $(this).parents(".layer_popup").attr("id");
	$(this).parents(".layer_popup").css("display", "none");
	$(".current").focus();
	$(".st, .ed").remove();
	$(".current").removeClass('current');
	$("html, body").css("overflow", "");
});


// layerPopup focus
$(document).on("focusin", ".ed", function(){$(".st").focus();});
$(document).on("focusin", ".st", function(){$(".pop_head").focus();});
