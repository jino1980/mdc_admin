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
                        <a href="#" class="on" class="sel">공지사항</a>
                    </li>
                </ul>
            </div>
            <!-- // header -->

            <!-- content -->
            <div class="content">

                <!-- 타이틀 -->
                <div class="title_box">
                    <h2 class="h2">총 <span id="totCnt"></span>건</h2>
                    <!-- <div class="fright">
                        <a href="#none">등록일 순</a> |
                        <a href="#none">게시일 순</a>
                    </div> -->
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
                        <input type="text" id="title" >
                        <button type="button" class="btn btn_search" onClick="javascript:fnSelectListCall();">검색</button>
                    </div>
                    <!-- <div id="pagination1" class="tui-pagination paging"></div> -->
                    <div class="btn_box">
                        <button type="button" class="btn btn_default" onClick="javascript:switchContent('/admin/board/viewBoardCommon/NOTC00000001/0');">글쓰기</button>
                    </div>
                </div>
                <!-- // 페이징 + 버튼 -->



            </div>
            <!-- // content -->
			
			<script>
				$(document).ready(function(){
					
					$('#title').on('keyup', function() {
				        //$('#title').html("("+$(this).val().length+" / 100)");
				 
				        if($(this).val().length > 100) {
				            $(this).val($(this).val().substring(0, 100));
				            toastr["warning"]("검색내용 은 100자 까지 입력 가능합니다.");
				            //$('#test_cnt').html("(100 / 100)");
				        }
				    });
					
					fnSelectListCall();
				});
		
		
		        // 목록
		        var Grid = tui.Grid;
		        Grid.setLanguage('ko', {
		            display: {
		            	noData: '검색 결과가 없습니다',
						loadingData: 'Loading data.....'
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
		                    title: '제목',
		                    align: 'left',
		                    name: 'title',
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
		                    title: '게시일',
		                    align: 'center',
		                    name: 'pushBeginDate',
		                    sortingType: 'desc',
		                    sortable: true,
		                    editor: {
		                        type: 'datePicker',
		                        options: {
		                          format: 'yyyy-MM-dd HH:mm',
		                          timepicker: true
		                        }
		                      },
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
		
		        
		        var boardId = "NOTC00000001"; // 공지사항
		        var taskSe = "NOTC";
		        		        
		     	// 조회호출
				var lvParams;
				function fnSelectListCall() {
					
					
					var title =nvl($("#title").val(),'');
									  
					  
					  lvParams = {
							        "boardId" : boardId
							      , "title" : title
							      , "taskSe": taskSe
							     };
					   
					console.log("## lvParams=>"+lvParams);
						
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
					  	    	grid.setData(rs);
					  	    	$("#div_load_image").hide();
					  	    	toastr["info"](rs.length+"건 조회 되었습니다.","조회완료.");	
					  	    	
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
