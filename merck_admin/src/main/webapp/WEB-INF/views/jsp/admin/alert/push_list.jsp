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
						<a href="#" class="on" class="sel">푸시 리스트</a>
					</li>
				</ul>
			</div>
			<!-- // header -->

			<!-- content -->
			<div class="content">

				<!-- 타이틀 -->
				<div class="title_box">
					<h1 class="h1">검색조건</h1>
				</div>
				<!-- // 타이틀 -->


				<!-- 검색 -->
				<div class="tb_search">
					<table>
						<caption>검색</caption>
						<colgroup>
							<col width="200" />
							<col width="" />
							<col width="200" />
							<col width="" />
						</colgroup>
						<tbody>
							<tr>
								<th scope="row">발송일</th>
								<td>
								<div class="datepicker_box">
									<div class="tui-datepicker-input tui-datetime-input tui-has-focus">
					                <input type="text" id="pushBeginDt" name="pushBeginDt" aria-label="Date-Time">
					                <span class="tui-ico-date"></span>
					              </div>
					              <div id="wrapper1" style="margin-top: -1px;"></div>
					            </div>
									~
								<div class="datepicker_box">
									<div class="tui-datepicker-input tui-datetime-input tui-has-focus">
					                <input type="text" id="pushEndDt" name="pushEndDt" aria-label="Date-Time">
					                <span class="tui-ico-date"></span>
					              </div>
					              <div id="wrapper2" style="margin-top: -1px;"></div>
					            </div>
								</td>
                                <th scope="row">검색내용</th>
                                <td>
                                    <input type="text" id="title" name="title" class="w350">
                                </td>
							</tr>
						</tbody>
					</table>
				</div>
				<!-- // 검색 -->
				
				<div class="btn_box alright">
					<button type="button" name="cn" class="btn btn_default" onClick="javascript:fnSelectListCall();">검색</button>
				</div>

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
					<!-- <div id="pagination1" class="tui-pagination paging"></div> -->
                    <div class="btn_box">
                        <button type="button" class="btn btn_default" onClick="javascript:switchContent('/admin/board/viewBoardCommon/PUSH00000001/PUSH');">글쓰기</button>
                    </div>
				</div>
				<!-- // 페이징 + 버튼 -->



			</div>
			<!-- // content -->

	<script>
	$(document).ready(function(){
		fnSelectListCall();
		
		$('#title').on('keyup', function() {
	        //$('#title').html("("+$(this).val().length+" / 100)");
	 
	        if($(this).val().length > 100) {
	            $(this).val($(this).val().substring(0, 100));
	            toastr["warning"]("검색내용 은 100자 까지 입력 가능합니다.");
	            //$('#test_cnt').html("(100 / 100)");
	        }
	    });
	});
	
			var today = new Date();
			var datepicker1 = new tui.DatePicker('#wrapper1', {
		        date: new Date(today.getFullYear(), today.getMonth()-1, today.getDate()),
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
                    title: '푸시 제목',
                    align: 'left',
                    name: 'titleSimple',
                },
                {
                    title: '등록일',
                    align: 'center',
                    name: 'regDte',
                    sortingType: 'desc',
                    sortable: true,
                    width: 100
                },
                {
                    title: '발송일',
                    align: 'center',
                    name: 'pushBeginDate',
                    sortingType: 'desc',
                    sortable: true,
                    width: 150
                },
                {
                    title: '수정',
                    align: 'center',
                    name: 'type05',
                    width: 80,
                    formatter: function (value, rowData) {
                        var btnCy = 'blue';
						value = '수정';
						return '<button type="button" id="'+rowData.postId+'" class="tb_btn '+ btnCy +'" onClick=fnModify(this,"'+rowData.pushRegNo+'") >' + value + '</button>';
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
						return '<button type="button" id="'+rowData.postId+'" class="tb_btn '+ btnCy +'" onClick=fnDel(this,"'+rowData.pushRegNo+'") >' + value + '</button>';
                    }
                }
            ]
        });
		
		var gridData = null;
		grid.setData(gridData);

        
        var boardId = "PUSH00000001"; // 공지사항
        var taskSe = "PUSH";

     	// 조회호출
		var lvParams;
		function fnSelectListCall() {
			
			
			var title =nvl($("#title").val(),'');
			var pushBeginDt =nvl($("#pushBeginDt").val(),'');
			var pushEndDt =nvl($("#pushEndDt").val(),'');
			
			  lvParams = {
					        "boardId" : boardId
					      , "taskSe": taskSe
					      , "title" : title
					      , "pushBeginDt" : (((((pushBeginDt.replace(/-/gi,"")).replace(/:/gi,"")).replace(/ /gi,"")).replace('PM',"")).replace('AM',""))
					      , "pushEndDt" : (((((pushEndDt.replace(/-/gi,"")).replace(/:/gi,"")).replace(/ /gi,"")).replace('PM',"")).replace('AM',""))
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
		
		//수정
		function fnModify(obj){
			console.log( obj.id );
			switchContent("/admin/board/viewBoardCommon/"+boardId+"/"+obj.id );
		}
		
		//삭제
		function fnDel(obj,pushRegNo){
			
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
						lvParams.pushRegNo = pushRegNo;
						gvSessionParams = lvParams;
						
						console.log( JSON.stringify(lvParams) );
											
						$.ajax({
					  	    url: "/admin/board/deleteBoardCommon/"+boardId+"/"+obj.id,
					  	    type: "post",
					  	    data: JSON.stringify(lvParams),
					        contentType: "application/json",
					  	    success: function(rs) {
					  	    	//data = JSON.stringify(data);
					  	    	console.log(JSON.stringify(rs));					    	
					  	    	//grid.setData(rs);
					  	    	var rsCnt = JSON.stringify(rs);
					  	    	toastr["success"](rsCnt+"건 삭제 되었습니다.","삭제완료.");
					  	    	fnSelectListCall();
					  	    },
					  	    error: function (xhr, status, error) {
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