

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

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//null 처리
function nvl(text,chgStr){
	if(text == null || text == undefined || text == NaN){
		return chgStr;
	}else{
		return text;
	}
};
function isNull(_val) {
	if (new String(_val).valueOf() == "undefined") {
		return true;
	}
	if (_val == null) {
		return true;
	}
	if (("x" + _val == "xNaN") && (new String(_val.length).valueOf() == "undefined")) {
		return true;
	}
	if (_val.length == 0) {
		return true;
	}

	return false;
};


/* required class 속성 NULL 체크 */
function nullCheckAll() {
    var rtn = true;
    var temp = $(".required");
    $(".required").each(function(){
        var tempElement = $("#"+this.id);
        var tempType = tempElement.prop("type");
        if (tempType == "text" || tempType == "password") {
            if ( tempElement.val() == null || tempElement.val() == "" ) {
                toastr["warning"](tempElement.attr("title")+"을(를) 입력해주세요.");
                tempElement.focus();
                rtn = false;
                return rtn;
            }
        } else if (tempType == "select-one") {
            if ( tempElement.val() == null || tempElement.val() == "" ) {
                toastr["warning"](tempElement.attr("title")+"을(를) 선택해주세요.");
                tempElement.focus();
                rtn = false;
                return rtn;
            }
        } else if (tempType == "checkbox") {
            if ( !tempElement.is(":checked") ) {
                toastr["warning"](tempElement.attr("title")+"을(를) 체크해주세요.");
                tempElement.focus();
                rtn = false;
                return rtn;
            }
        } else if (tempType == "radio") {
            if ( !tempElement.is(":checked") ) {
                toastr["warning"](tempElement.attr("title")+"을(를) 선택해주세요.");
                tempElement.focus();
                rtn = false;
                return rtn;

            }

        }

    });

    return rtn;

}