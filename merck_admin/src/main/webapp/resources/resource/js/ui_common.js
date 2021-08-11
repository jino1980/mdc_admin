

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
	
	cfnLayoutPopUpCallBack($(this));
	
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
        
        console.log("## validChek.. id,type==>"+this.id+","+tempType);
        
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

        } else if(tempType == 'textarea'){
			if ( tempElement.val() == null || tempElement.val() == "" ) {
                toastr["warning"](tempElement.attr("title")+"을(를) 입력해주세요.");
                tempElement.focus();
                rtn = false;
                return rtn;
            }
		}

    });
	
	// 유효성 체크 이메일 ,휴대폰 등
	var tempValid = $(".inputValid");
    $(".inputValid").each(function(){
		var tempElement = $("#"+this.id);
        var tempType = tempElement.prop("type");
        var id = this.id;
        	id = id.toLowerCase();
        
        console.log("## check inputValid.. id,type==>"+this.id+","+tempType);
        
        if( id.indexOf("email") > -1 && !isNull(tempElement.val()) ){
			 var email = tempElement.val();
			 var regex=/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;			
			 if(regex.test(email) === false){			
			 	toastr["warning"]("잘못된 "+tempElement.attr("title")+" 형식입니다.");
	            tempElement.focus();
	            rtn = false;
	            return rtn;
			 }
		}
		if( (id.indexOf("phone") > -1 || id.indexOf("telno") > -1) && !isNull(tempElement.val()) ){
			 var phonenum = tempElement.val();
			 var regPhone = /^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})-?[0-9]{3,4}-?[0-9]{4}$/;
			 if(!regPhone.test(phonenum)){
			    toastr["warning"]("잘못된 "+tempElement.attr("title")+" 번호입니다.");
	            tempElement.focus();
	            rtn = false;
	            return rtn;
			 }
		}
	});
	
    return rtn;

}

// 문자열 -> 날짜
function parseStrToDate(str) {
	
	if( isNull(str) ) return new Date();
	
    var y = str.substr(0, 4);
    var m = str.substr(4, 2);
    var d = str.substr(6, 2);
    if( str.length  == 12 ){
        var hh= str.substr(8, 2);
        var mm= str.substr(10, 2);
        console.log("### parseStrToDate=>> hh:"+hh+" / mm:"+mm);
        console.log("### parseStrToDate=>> :"+ new Date(y,m-1,d,hh,mm) );
    	return new Date(y,m-1,d,hh,mm);
    }else{
        console.log("### parseStrToDate=>> :"+ new Date(y,m-1,d) );
    	return new Date(y,m-1,d);
	}
}	 

// 날짜 문자로 변환
function getDatetoString(date,pos,prfx) {
  var d = new Date(date);
  var s = "";
    if( pos == 4 ) s+=leadingZeros(d.getFullYear(), 4);
    if( pos == 6 ) s+=prfx+leadingZeros(d.getMonth() + 1, 2);
    if( pos == 8 ) s+=prfx+leadingZeros(d.getDate(), 2);
    if( pos == 10 ) s+=" "+leadingZeros(d.getHours(), 2);
    if( pos == 12 ) s+=":"+leadingZeros(d.getMinutes(), 2);
    if( pos == 14 ) s+=":"+leadingZeros(d.getSeconds(), 2);
    
  return s;
}
function leadingZeros(n, digits) {
  var zero = '';
  n = n.toString();

  if (n.length < digits) {
    for (i = 0; i < digits - n.length; i++)
      zero += '0';
  }
  return zero + n;
}


function gfnChkInjectionWord(obj) {
	 if (obj.length > 0) { 
		//특수문자 제거 
		var expText = /[%=><]/; 
		if (expText.test(obj) == true) {
			 alert("특수문자를 입력 할수 없습니다."); 
			 obj.value = obj.value.split(expText).join(""); 
			 return false; 
		} 
		
		//특정문자열(sql예약어의 앞뒤공백포함) 제거		
		var sqlArray = new Array( "OR", "SELECT", "INSERT", "DELETE", "UPDATE", "CREATE", "DROP", "EXEC", "UNION", "FETCH", "DECLARE", "TRUNCATE" ); 
		var regex; 
		for (var i = 0; i < sqlArray.length; i++) { 
			regex = new RegExp(sqlArray[i], "gi"); 
			if (regex.test(obj)) { 
				alert("\"" + sqlArray[i] + "\"와(과) 같은 특정문자로 검색할 수 없습니다."); 
				obj = obj.replace(regex, ""); 
				return false; 
			} 
		} 
	} 
	return true; 
}

