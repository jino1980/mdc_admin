<%@page import="com.merck.catalog.common.SoftLabHumUtils"%>
<%@page import="com.merck.catalog.admin.vo.TbCab001m"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<%@page import="java.util.*"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%

List<Map<String,Object>> boardPostList = new ArrayList();
List<Map<String,Object>> paramList = (List<Map<String,Object>>)request.getAttribute("boardPostList");
if( null == paramList || paramList.size() == 0 ) {
	   TbCab001m vo = new TbCab001m();
	   vo.setBoardId("POPP00000001");
	   boardPostList.add(0, SoftLabHumUtils.converVoToMap(vo));
	   //System.out.println("#### SoftLabHumUtils.converVoToMap(vo)=>>>"+SoftLabHumUtils.converVoToMap(vo));
	   
	   request.setAttribute("boardPostList", boardPostList);
	   
}else{
	   boardPostList = (List<Map<String,Object>>)request.getAttribute("boardPostList");
	   System.out.println("#### boardPostList =>>>"+boardPostList.get(0));
}

%>
        <!-- header -->
            <div class="header">

                <div class="info">
                    <span class="logout"><button type="button" title="로그아웃"></button></span>
                </div>
                <ul class="gnb_menu">
                    <li>
                        <a href="#" class="on" class="sel">팝업 등록</a>
                    </li>
                </ul>
            </div>
            <!-- // header -->

            <!-- content -->
			<c:forEach var="boardPost" items="${boardPostList}">
            
            <form:form commandName="poppForm" action="#">
            <input type="hidden" id="boardId" name="boardId"  value="${boardPost.boardId}"/>
            <input type="hidden" id="postId" name="postId"  value="${boardPost.postId}"/>
            <input type="hidden" id="pushRegNo" name="pushRegNo"  value="${boardPost.pushRegNo}"/>
            
            <input type="hidden" id="taskSe" name="taskSe"  value="POPP"/>
            <input type="hidden" id="taskSeCd" name="taskSeCd"  value="NTC"/>
            
            
            <div class="content">
                <!-- 작성폼 -->
                <div class="tb_create">
                    <table>
                        <caption>등록</caption>
                        <colgroup>
                            <col width="160">
                            <col>
                        </colgroup>
                        <tbody>
                            <tr>
                                <th scope="row">
                                    제목<span id="titleLen"> (${fn:length(boardPost.title)}/50)</span>
                                </th>
                                <td>
                                    <input type="text" class="required" title="제목" name="title" id="title" value="${boardPost.title}">
                                </td>
                            </tr>
                            <tr>
                                <th scope="row">
                                    기간
                                </th>
                                <td>
                                    <div class="datepicker_box">
                                        <div class="tui-datepicker-input tui-datetime-input tui-has-focus">
					                		<input type="text" class="required" title="기간[시작일]" id="pushBeginDt" name="pushBeginDt" aria-label="Date-Time">
					                		<span class="tui-ico-date"></span>
					              		</div>
					              		<div id="wrapper1" style="margin-top: -1px;"></div>
                                    </div>
                                    ~
                                    <div class="datepicker_box">
                                        <div class="tui-datepicker-input tui-datetime-input tui-has-focus">
					                		<input type="text" class="required" title="기간[종료일]" id="pushEndDt" name="pushEndDt" aria-label="Date-Time">
					                		<span class="tui-ico-date"></span>
					              		</div>
					              		<div id="wrapper2" style="margin-top: -1px;"></div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th scope="row">
                                    내용<span id="cnLen"> (${fn:length(boardPost.cn)}/1000)</span>
                                </th>
                                <td>
                                    <textarea name="cn" id="cn" title="내용" class="required" cols="30" rows="10">${boardPost.cn}</textarea>
                                </td>
                            </tr>
                            <tr>
                                <th scope="row">
                                    바로가기
                                </th>
                                <td>
                                    <input type="text" name="catlgUrl" id="catlgUrl" value="${boardPost.catlgUrl}">
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <!-- // 작성폼 -->


                <!-- 페이징 + 버튼 -->
                <div class="paging_box">
                    <div class="btn_box">
                        <button type="button" class="btn btn_default" onClick="javascript:switchContent('/admin/alert/popp_write');">신규</button>
                        <button type="button" class="btn btn_default" onClick="javascript:fnSave(0);">임시저장</button>
                        <button type="button" data-name="popup01" class="btn btn_default popup_open">미리보기</button>
                        <button type="button" class="btn btn_default" onClick="javascript:fnSave(1);">등록</button>
                        <button type="button" class="btn btn_default" onClick="javascript:switchContent('/admin/alert/popp_list');">목록으로</button>
                    </div>
                </div>
                <!-- // 페이징 + 버튼 -->

            </div>
            </form:form>
            </c:forEach>
            <!-- // content -->

    <!-- 레이어 팝업 -->
    <div class="layer_popup" id="popup01" style="display: none;">
        <div class="popup_wrap type01">
            <div class="pop_head">
                <h1 tabindex="0" id="poppTitle">새로운 카탈로그가 등록이 되었습니다.</h1>
                <button type="button" class="popup_close" title="닫기"></button>
            </div>
            <div class="pop_cont">
                <div class="pop_cont_wrap">
                    <!-- 팝업 내용 -->
                    <pre class="pop_text" id="poppCn">2021년 일자 기준으로 카달로그가 등록이 되었습니다.
많은 이용해 주시고 아래 바로가기 링크로 이동하시면 해당 카달로그를 보실수 있습니다.</pre>
                    <!-- // 팝업 내용 -->
                    <!-- 카탈로그 바로가기 -->
                    <a href="#none" class="go_catalogue" id="poppUrl" target="_blank">
                        👉👉 바로가기 클릭 </a>
                    <!-- // 카탈로그 바로가기 -->
                </div>

                <!-- 오늘 하루 보지 않기 -->
                <div class="not_today_wrapper">
                    <ul class="inputbox">
                        <li>
                            <input type="checkbox" id="not_today" name="not_today"><label for="not_today">오늘 하루 보지
                                않기</label>
                        </li>
                    </ul>
                </div>
                <!-- // 오늘 하루 보지 않기 -->
            </div>
        </div>
    </div>
    <!-- // 레이어 팝업 -->

    <script>
    	
	    $(document).ready( function() {
	        
	        $("#div_load_image").hide();
	        //$('#progress').hide();
	        
	        $('#title').on('keyup', function() {
		        $('#titleLen').html("("+$(this).val().length+" / 50)");
		 
		        if($(this).val().length > 50) {
		            $(this).val($(this).val().substring(0, 50));
		            toastr["warning"]("제목 은(는) 50자 까지 입력 가능합니다.");
		            //$('#test_cnt').html("(100 / 100)");
		        }
		    });
	        $('#cn').on('keyup', function() {
		        $('#cnLen').html("("+$(this).val().length+" / 1000)");
		 
		        if($(this).val().length > 1000) {
		            $(this).val($(this).val().substring(0, 1000));
		            toastr["warning"]("내용 은(는) 1000자 까지 입력 가능합니다.");
		            //$('#test_cnt').html("(100 / 100)");
		        }
		    });
	        $('#catlgUrl').on('keyup', function() {		        
		 
		        if($(this).val().length > 100) {
		            $(this).val($(this).val().substring(0, 100));
		            toastr["warning"]("바로가기 은(는) 100자 까지 입력 가능합니다.");
		            //$('#test_cnt').html("(100 / 100)");
		        }
		        
		        if (!(event.keyCode >=37 && event.keyCode<=40)) {
	        		var inputVal=$(this).val(); 
	        		$(this).val(inputVal.replace(/[^a-z0-9@_.\-=:/&?]/gi,'')); 
	        	} 
		    });
	        
	      });
    
    	
        $(document).on("click", ".popup_open", function () {
        	var pTitle = $("#title").val();
        	var pCn = $("#cn").val();
        	var pUrl = $("#catlgUrl").val();
        	
        	$("#poppTitle").text(pTitle);
        	$("#poppCn").text(pCn);
        	if( isNull(pUrl) == false ){
        		$("#poppUrl").prop("href",pUrl);
        		$("#poppUrl").text('👉👉 바로가기 클릭');
        	}else{
        		$("#poppUrl").text('');
        	}
        	
            grid.refreshLayout();
        });

        // div 팝업 후처리
        function cfnLayoutPopUpCallBack(){
        	return;
        }
        
        var today = new Date();
		var datepicker1 = new tui.DatePicker('#wrapper1', {
	        date: today,
	        input: {
	          element: '#pushBeginDt',
	          format: 'yyyy-MM-dd HH:mm A'
	        },
	        timePicker: true
	      });

		var datepicker2 = new tui.DatePicker('#wrapper2', {
	        date:  new Date(today.getFullYear(), today.getMonth(), today.getDate()+7),
	        input: {
	          element: '#pushEndDt',
	          format: 'yyyy-MM-dd HH:mm A'
	        },
	        timePicker: true
	      });

		
		
		//-- 저장 --//
        var boardId = "POPP00000001"; // 공지사항
  		function fnSave(idx){
  			
  			var formData = $("#poppForm").serializeObject();
  			var pushBeginDt = $("#pushBeginDt").val();
  			var pushEndDt = $("#pushEndDt").val();
  			
  			if( isNull(pushBeginDt) == false ){
  				formData.pushBeginDt = (((((pushBeginDt.replace(/-/gi,"")).replace(/:/gi,"")).replace(/ /gi,"")).replace('PM',"")).replace('AM',""));
  				formData.pushEndDt = (((((pushEndDt.replace(/-/gi,"")).replace(/:/gi,"")).replace(/ /gi,"")).replace('PM',"")).replace('AM',""));
  			}
  			
  			console.log("## formJson=>>"+JSON.stringify(formData));
  			
  			// 필수체크
  			if(nullCheckAll() == false) return;
  			
  			if( idx == 0 ){
  				fnAjaxCall(formData);
  			}else{
  			
	  			$.prompt("<h2>저장 하시겠습니까?</h2>", {
	  				focus : 1,
	  				buttons: { "네": true, "아니오": false },
	  				top : "40%",
	  				promptspeed : "fast",
	  				submit: function(e,v,m,f){
	  					// use e.preventDefault() to prevent closing when needed or return false.
	  					//e.preventDefault();
	  					console.log("Value clicked was: "+ v);
	  					if( v ){
	  						
	  						fnAjaxCall(formData);
	  						
	  					}
	  				}
	  			});
  			}
  		}
  		
        function fnAjaxCall(formData){
        	$("#div_load_image").show();
        	$.ajax({
			  	    url: "/admin/board/saveBoardCommon",
			  	    type: "post",
			  	    data: JSON.stringify(formData),
			        contentType: "application/json",
			  	    success: function(rs) {
			  	    	//data = JSON.stringify(data);
			  	    	console.log("### saveCatalog=>>"+rs);					    	
			  	    	//grid.setData(rs);							  	    	
			  	    	toastr["success"]("1건 저장 되었습니다.","저장완료.");
			  	    	$("#div_load_image").hide();
			  	    	switchContent('/admin/board/viewBoardCommon/'+boardId+"/"+rs);
			  	    	
			  	    },
			  	    error: function (xhr, status, error) {
			  	    	$("#div_load_image").hide();
			  	    	alert("error=>>"+error);
			  	    }
			  	  });
        }
        
  		toastr.options = {
  				  "positionClass": "toast-bottom-right"
  			     ,"timeOut": "1500"
  				};
    </script>