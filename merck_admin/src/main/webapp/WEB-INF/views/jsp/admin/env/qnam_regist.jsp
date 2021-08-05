<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<%@page import="java.util.*"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
        <!-- header -->
            <div class="header">

                <div class="info">
                    <span class="logout"><button type="button" title="로그아웃"></button></span>
                </div>
                <ul class="gnb_menu">
                    <li>
                        <a href="#" class="on" class="sel">문의 담당자 관리</a>
                    </li>
                </ul>
            </div>
            <!-- // header -->

            <!-- content -->

            <div class="content">
                <!-- 타이틀 -->
                <div class="title_box">
                    <h2 class="h2">총 <span id="totCnt"></span>건</h2>
                </div>
                <!-- // 타이틀 -->

                <!-- 리스트 -->
                <div class="tb_list">
                    <div id="grid"></div>
                </div>
                <!-- // 리스트 -->


                <!-- 페이징 + 버튼 -->
                <div class="paging_box">
                    <div class="btn_box left">
                        <input type="text" id="searchMangUsrNm" name="searchMangUsrNm">
                        <button type="button" name="cn" class="btn btn_default" onClick="javascript:fnSelectListCall();">검색</button>
                    </div>
                    <div class="btn_box">
                        <button type="button" id="btnRegist" data-name="popup01" class="btn btn_default popup_open" >등록</button>
                    </div>
                </div>
                <!-- // 페이징 + 버튼 -->

            </div>
            <!-- // content -->


    <!-- 레이어 팝업 -->
    <div class="layer_popup" id="popup01" style="display: none;">
        <div class="popup_wrap type01">
            <div class="pop_head">
                <h1 tabindex="0">문의 담당자 등록</h1>
                <button type="button" class="popup_close" id="btnClose" title="닫기" onClick="fnRegInit(-1);"></button>
            </div>
            <div class="pop_cont">
                <div class="pop_cont_wrap"style="padding-bottom: 0;">

                    <!-- 작성폼 -->
                    <form id="qnamForm" action="#" method="post">
                    <input type="hidden" id="boardId" name="boardId"  value="QNAM00000001"/>
		            <input type="hidden" id="postId" name="postId"  value=""/>
		            <input type="hidden" id="mangRegNo" name="mangRegNo"  value=""/>
		            
		            <input type="hidden" id="taskSe" name="taskSe"  value="QNAM"/>
		            <input type="hidden" id="taskSeCd" name="taskSeCd"  value="QNA"/>
            
            
                    <div class="tb_create">
                        <table>
                            <caption>등록</caption>
                            <colgroup>
                                <col width="120">
                                <col>
                            </colgroup>
                            <tbody>
                                <tr>
                                    <th scope="row">
                                        부서명
                                    </th>
                                    <td>
                                        <input type="text" class="required" title="부서명" name="mangDeptNm" id="mangDeptNm">
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row">
                                        이름
                                    </th>
                                    <td>
                                        <input type="text" class="required" title="이름" name="mangUsrNm" id="mangUsrNm">
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row">
                                        이메일
                                    </th>
                                    <td>
                                        <input type="text" class="inputValid" title="이메일" name="emailAddr" id="emailAddr">
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row">
                                        회사전화
                                    </th>
                                    <td>
                                        <input type="text" class="inputValid" title="회사전화" name="compTelNo" id="compTelNo">
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row">
                                        핸드폰
                                    </th>
                                    <td>
                                        <input type="text" class="inputValid" title="핸드폰"  name="phoneNo" id="phoneNo">
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    </form>
                    <!-- // 작성폼 -->
                </div>
                <div class="btn_box">
                    <button type="button" class="btn btn_default" onClick="javascript:fnSave(1);">등록</button>
                    <button type="button" class="btn btn_default" onClick="javascript:fnRegInit(0);">취소</button>
                </div>
            </div>
        </div>
    </div>
    <!-- // 레이어 팝업 -->

    <script>
	    $(document).ready(function(){
			fnSelectListCall();
		});
    
        // 목록
        var Grid = tui.Grid;
        Grid.setLanguage('ko', {
            display: {
                noData: '검색 결과가 없습니다'
            }
        });

        var grid = new tui.Grid({
        	el: $('#grid'),
            data: gridData,
            scrollX: false,
            scrollY: true,
            rowHeaders: ['rowNum'],
            header: {
                height: 35
            },
            minRowHeight: 30,
            bodyHeight: 455,
            columns: [
                {
                    title: '부서명',
                    align: 'center',
                    name: 'mangDeptNm',
                    sortingType: 'desc',
                    sortable: true,
                },
                {
                    title: '이름',
                    align: 'center',
                    name: 'mangUsrNm',
                    sortingType: 'desc',
                    sortable: true,
                },
                {
                    title: '이메일',
                    align: 'center',
                    name: 'emailAddr',
                },
                {
                    title: '회사전화',
                    align: 'center',
                    name: 'compTelNo',
                },
                {
                    title: '핸드폰',
                    align: 'center',
                    name: 'phoneNo',
                },
                {
                    title: '수정',
                    align: 'center',
                    name: 'type05',
                    width: 80,
                    formatter: function (value, rowData) {
                        var btnCy = 'blue';
						value = '수정';
						return '<button type="button" id="'+rowData.postId+'" class="tb_btn '+ btnCy +'" onClick=fnModify(this,"'+rowData.mangRegNo+'")>' + value + '</button>';
                    }
                },
                {
                    title: '삭제',
                    align: 'center',
                    name: 'type06',
                    width: 80,
                    formatter: function (value, rowData) {
                    	var btnCy = 'red';
						value = '삭제';
						return '<button type="button" id="'+rowData.postId+'" class="tb_btn '+ btnCy +'" onClick=fnDel(this,"'+rowData.mangRegNo+'") >' + value + '</button>';
                    }
                }
            ]
        });

        var gridData = null;
		grid.setData(gridData);

        
        var boardId = "QNAM00000001"; // 공지사항
        var taskSe = "QNAM";

     	// 조회호출
		var lvParams;
		function fnSelectListCall() {
			
			
			var mangUsrNm =nvl($("#searchMangUsrNm").val(),'');
			
			  lvParams = {
					        "boardId" : boardId
					      , "taskSe": taskSe
					      , "title" : mangUsrNm
					     };
			   
				console.log("## lvParams=>"+JSON.stringify(lvParams));
				$("#div_load_image").show();
			  	$.ajax({
			  	    url: "/admin/board/selectBoardCommonList",
			  	    type: "post",
			  	    data: JSON.stringify(lvParams),
			        contentType: "application/json",
			  	    success: function(rs) {
			  	    	//data = JSON.stringify(data);
			  	    	console.log(JSON.stringify(rs));
			  	    	$("#totCnt").html(rs.length);
			  	    	toastr["info"](rs.length+"건 조회 되었습니다.","조회완료.");	
			  	    	grid.setData(rs);
			  	    	$("#div_load_image").hide();
			  	    },
			  	    error: function (xhr, status, error) {
			  	    	$("#div_load_image").hide();
			  	    	alert("error=>>"+error);
			  	    }
			  	  });
			  
		}
		
		//-- 저장 --//
  		function fnSave(idx){
  			
  			var formData = $("#qnamForm").serializeObject();
  				formData.title = formData.mangUsrNm;
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
			  	    	fnRegInit(0);
			  	    	fnSelectListCall();
			  	    	
			  	    },
			  	    error: function (xhr, status, error) {
			  	    	$("#div_load_image").hide();
			  	    	alert("error=>>"+error);
			  	    }
			  	  });
        }
		
        // 신규세팅
        function fnRegInit(idx){
        	
        	$("#mangDeptNm").val("");
  	    	$("#mangUsrNm").val("");
  	    	$("#emailAddr").val("");
  	    	$("#compTelNo").val("");
  	    	$("#phoneNo").val("");
  	    	
  	    	$("#postId").val("");
  	    	$("#mangRegNo").val("");
  	    	
  	    	if( idx == 0 ) $('#btnClose').trigger('click');
  	    	
  	    	return true;
        }
        
		//수정
		function fnModify(obj,mangRegNo){
			
			lvParams.boardId = boardId;
			lvParams.postId = obj.id;
			lvParams.mangRegNo = mangRegNo;
			
			console.log( JSON.stringify(lvParams) );
			
			$("#div_load_image").show();
			$.ajax({
		  	    url: "/admin/board/viewQnaMangRegNo/"+boardId+"/"+obj.id,
		  	    type: "post",
		  	    data: JSON.stringify(lvParams),
		        contentType: "application/json",
		  	    success: function(rs) {
		  	    	//data = JSON.stringify(data);
		  	    	console.log(JSON.stringify(rs));
		  	    	$("#div_load_image").hide();
		  	    	//grid.setData(rs);
		  	    	$("#mangDeptNm").val(rs.mangDeptNm);
		  	    	$("#mangUsrNm").val(rs.mangUsrNm);
		  	    	$("#emailAddr").val(rs.emailAddr);
		  	    	$("#compTelNo").val(rs.compTelNo);
		  	    	$("#phoneNo").val(rs.phoneNo);
		  	    	
		  	    	$("#postId").val(rs.postId);
		  	    	$("#mangRegNo").val(rs.mangRegNo);
		  	    	
		  	    	$("#btnRegist").trigger("click");
		  	    },
		  	    error: function (xhr, status, error) {
		  	    	$("#div_load_image").hide();
		  	    	alert("error=>>"+error);
		  	    }
		  	  });
			
			//switchContent("/admin/board/viewBoardCommon/"+boardId+"/"+obj.id );
		}
		
		//삭제
		function fnDel(obj,mangRegNo){
			
			$.prompt("<h2>삭제하시겠습니까?</h2>", {
				focus : 1,
				buttons: { "네": true, "아니오": false },
				top : "40%",
				promptspeed : "fast",
				submit: function(e,v,m,f){
					// use e.preventDefault() to prevent closing when needed or return false.
					//e.preventDefault();
					console.log("Value clicked was: "+ v);
					if( v ){
						
						lvParams.boardId = boardId;
						lvParams.postId = obj.id;
						lvParams.mangRegNo = mangRegNo;
						gvSessionParams = lvParams;
						
						console.log( JSON.stringify(lvParams) );
						$("#div_load_image").show();
						$.ajax({
					  	    url: "/admin/board/deleteBoardCommon/"+boardId+"/"+obj.id,
					  	    type: "post",
					  	    data: JSON.stringify(lvParams),
					        contentType: "application/json",
					  	    success: function(rs) {
					  	    	//data = JSON.stringify(data);
					  	    	console.log(JSON.stringify(rs));					
					  	    	$("#div_load_image").hide();
					  	    	//grid.setData(rs);
					  	    	var rsCnt = JSON.stringify(rs);
					  	    	toastr["success"](rsCnt+"건 삭제 되었습니다.","삭제완료.");
					  	    	fnSelectListCall();
					  	    },
					  	    error: function (xhr, status, error) {
					  	    	$("#div_load_image").hide();
					  	    	alert("error=>>"+error);
					  	    }
					  	  });
						
					}
				}
			});
		}
		
		toastr.options = {
				  "positionClass": "toast-bottom-right",
				  "timeOut": "1500"
				};
    </script>