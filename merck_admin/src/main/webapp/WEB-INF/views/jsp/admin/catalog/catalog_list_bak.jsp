<%@page import="org.springframework.context.ApplicationContext"%>
<%@page import="org.springframework.context.support.ClassPathXmlApplicationContext"%>
<%@page import="org.apache.catalina.Context"%>
<%@page import="org.springframework.web.context.*"%>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="com.merck.catalog.admin.service.CmmnCdService"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<%@page import="java.util.*"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%

ServletContext servletContext = this.getServletContext();
WebApplicationContext wac = WebApplicationContextUtils.getRequiredWebApplicationContext(servletContext);
CmmnCdService cmmnCdSvc = (CmmnCdService)wac.getBean("cmmnCdService");

HashMap map = new HashMap();
List<Map<String, Object>> cateList = (List<Map<String, Object>>)cmmnCdSvc.selectCmmnCdList(map);


%>
        <!-- header -->
			<div class="header">

				<div class="info">
					<span class="logout"><button type="button" title="로그아웃"></button></span>
				</div>
				<ul class="gnb_menu">
					<li>
						<a href="#" class="on" class="sel">카탈로그 목록</a>
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
						</colgroup>
						<tbody>
							<tr>
								<th scope="row">카테고리</th>
								<td>
									<ul class="inputbox">
										<c:forEach var="category" items="${cateList}" varStatus="status">
										<li>
											<input type="checkbox" id="checkbox01_${status.count}" name="checkbox01" onClick="chkValidCate(this);" value="${cateList.cmmnCdNm}"><label
												for="checkbox01_1">전체</label>
										</li>
										</c:forEach>
										<!-- 
										
										<li>
											<input type="checkbox" id="checkbox01_1" name="checkbox01" onClick="chkValidCate(this);" value="ALL"><label
												for="checkbox01_1">전체</label>
										</li>
										<li>
											<input type="checkbox" id="checkbox01_2" name="checkbox01" onClick="chkValidCate(this);" value="생명과학"><label
												for="checkbox01_2">생명과학</label>
										</li>
										<li>
											<input type="checkbox" id="checkbox01_3" name="checkbox01" onClick="chkValidCate(this);" value="화학"><label
												for="checkbox01_3">화학</label>
										</li>
										<li>
											<input type="checkbox" id="checkbox01_4" name="checkbox01" onClick="chkValidCate(this);" value="재료과학"><label
												for="checkbox01_4">재료과학</label>
										</li>
										<li>
											<input type="checkbox" id="checkbox01_5" name="checkbox01" onClick="chkValidCate(this);" value="QA/QC"><label
												for="checkbox01_5">QA/QC</label>
										</li>
										<li>
											<input type="checkbox" id="checkbox01_6" name="checkbox01" onClick="chkValidCate(this);" value="기타"><label
												for="checkbox01_6">기타</label>
										</li>
										
										 -->
									</ul>
								</td>
							</tr>
							<tr>
								<th scope="row">정렬기준</th>
								<td>
									<ul class="inputbox">
										<li>
											<input type="radio" id="radio01_1" name="radio01" value="UPDT_DT"><label
												for="radio01_1">최신순</label>
										</li>
										<li>
											<input type="radio" id="radio01_2" name="radio01" value="CATGR_ID_GRP"><label
												for="radio01_2">카테고리순</label>
										</li>
										<li>
											<input type="radio" id="radio01_3" name="radio01" value="DOWNLD_CNT"><label
												for="radio01_3">다운로드순</label>
										</li>
										<li>
											<input type="radio" id="radio01_4" name="radio01" value="LIKE_CNT"><label
												for="radio01_4">좋아요순</label>
										</li>
									</ul>
								</td>
							</tr>
							<tr>
								<th scope="row">등록일</th>
								<td>
									<div class="datepicker_box">
										<div class="tui-datepicker-input tui-datetime-input tui-has-focus">
											<input type="text" id="datepicker-input1" aria-label="Date-Time">
											<span class="tui-ico-date"></span>
										</div>
										<div id="divBeginDte" style="margin-top: -1px;"></div>
									</div>
									~
									<div class="datepicker_box">
										<div class="tui-datepicker-input tui-datetime-input tui-has-focus">
											<input type="text" id="datepicker-input2" aria-label="Date-Time">
											<span class="tui-ico-date"></span>
										</div>
										<div id="divEndDte" style="margin-top: -1px;"></div>
									</div>
								</td>
							</tr>
							<tr>
								<th scope="row">검색내용</th>
								<td>
									<input type="text" id="detlCn" name="detlCn">
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<!-- // 검색 -->
				
				<div class="btn_box alright">
					<button type="button" class="btn btn_default" onClick="javascript:fnSelectListCall()">검색</button>
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
					<div id="pagination1" class="tui-pagination paging"></div>
				</div>
				<!-- // 페이징 + 버튼 -->



			</div>
			<!-- // content -->
			
			<script>
				$(document).ready(function(){
					fnSelectListCall();
				});
			
				var beginDate = new Date();
				beginDate.setDate(beginDate.getDate() - 7);
				
				var datepicker1 = new tui.DatePicker('#divBeginDte', {
					date: beginDate,
		            input: {
		                element: '#datepicker-input1',
		                format: 'yyyy-MM-dd'
		            }
				});
		
				var datepicker2 = new tui.DatePicker('#divEndDte', {
					date: new Date(),
		            input: {
		                element: '#datepicker-input2',
		                format: 'yyyy-MM-dd'
		            }
				});
		
		
				// 목록
				var Grid = tui.Grid;
				Grid.setLanguage('ko', {
					display: {
						noData: '검색 결과가 없습니다',
						loadingData: 'Loading data.....',
				        resizeHandleGuide: 'You can change the width of the column by mouse drag, ' +
				                             'and initialize the width by double-clicking.'
					},
					net: {
				         confirmCreate: 'Are you sure you want to create {{count}} data?',
				         confirmUpdate: 'Are you sure you want to update {{count}} data?',
				         confirmDelete: 'Are you sure you want to delete {{count}} data?',
				         confirmModify: 'Are you sure you want to modify {{count}} data?',
				         noDataToCreate: 'No data to create.',
				         noDataToUpdate: 'No data to update.',
				         noDataToDelete: 'No data to delete.',
				         noDataToModify: 'No data to modify.',
				         failResponse: 'An error occurred while requesting data.\nPlease try again.'
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
							title: '카테고리',
							align: 'left',
							name: 'catgrIdGrp',
							width: 200
						},
						{
							title: '카탈로그명',
							align: 'left',
							name: 'catlgNm'
						},
						{
							title: '날짜',
							align: 'center',
							name: 'regDte',
							sortingType: 'desc',
		                    sortable: true,
							width: 100
						},
						{
							title: '다운로드 수',
							align: 'center',
							name: 'downldCnt',
							sortingType: 'desc',
		                    sortable: true,
							width: 100
						},
						{
							title: '좋아요 수',
							align: 'center',
							name: 'likeCnt',
							sortingType: 'desc',
		                    sortable: true,
							width: 100
						},
						{
							title: '수정',
							align: 'center',
							name: 'type07',
							width: 80,
							formatter: function(value, rowData) {
								var btnCy = 'blue';
								value = '수정';
								return '<button type="button" id="'+rowData.catlgId+'" class="tb_btn '+ btnCy +'" onClick="javascript:fnModify(this);">' + value + '</button>';
							}
						},
						{
							title: '삭제',
							align: 'center',
							name: 'type08',
							width: 80,
							formatter: function(value, rowData) {
								var btnCy = 'red';
								value = '삭제';
								return '<button type="button" id="'+rowData.catlgId+'" class="tb_btn '+ btnCy +'" onClick="javascript:fnDel(this);">' + value + '</button>';
							}
						}
					]
				});
		
				
				//var gridData = [{"langSeCd":"EN","regDte":"2021.07.25","catlgId":"CATLG00001","catlgFileGrpId":"CAA00001","updtUsrId":"SOFTLAB","detlCn":"등록된 이미지를 보여주며 첫번째가 표지 나머지 이미지는 관련 이미지로 보여줌\u000b이미지 상단에 X표 아이콘은 삭제기능클릭하면 이미지를 추가 할수 있음\u000b이미지가 추가 되면 빈 화면은 옆으로 자동으로 이동해서 연속으로 추가할 수 있음카테고리 선택 \u000b- 다중선택 가능- 등록된 카테고리는 모두 나옴\u000b검색어(키워드)\u000b- 키워드를 입력하고 엔터, 연속으로 등록가능\u000b- X표 누르면 키워드 삭제버전정보가 필요한지전환문의 이메일 문의- 등록된 담당자 불러와서 선택카달로그파일 PDF 찾아서 등록","registUsrId":"SOFTLAB","simplCn":"화면 설명\\n- 카달로그 등록화면으로 수정화면과 동일 하며 수정화면은 입력된 내용을 수정할 수 있도록 처리\\n- 이미지 등록 프로세서를 최대한 간편하게 처리하여 사용자의 편의성을 높임\\n- 검색어(키워드) 또한 엔터기만 치면 검색어를 입력할수 있게 하여 커서의 이동 없이 처리 하여 사용자 편의성을 높임","likeCnt":999,"imgFileGrpId":"CAA00001","catgrIdGrp":",화학,재료과학","verInfo":"Merck Catalog App v1.0","catlgNm":"Analyte Quarterly vol.2 2019","telMangUsrId":"M0001","downldCnt":1024,"emailMangUsrId":"F0001","issueDte":"20210722","useYn":"Y","updtDt":1627150807273,"rn":1,"keywdValGrp":",키워드1,키워드2,키워드3"}];
				var gridData = null;
				grid.setData(gridData);
				
		
				// 페이징
				/* var Pagination = tui.Pagination;
		
				var pagination1 = new tui.Pagination('pagination1', {
					totalItems: 500,
					itemsPerPage: 10,
					visiblePages: 10
				}); */
				
				// 카테고리 체크
				$("input:checkbox[id='checkbox01_1']").prop("checked", true);				
				function chkValidCate(obj){
					if( obj.id=="checkbox01_1" && obj.checked ){
						$("input:checkbox[id='checkbox01_2']").prop("checked", false);
						$("input:checkbox[id='checkbox01_3']").prop("checked", false);
						$("input:checkbox[id='checkbox01_4']").prop("checked", false);
						$("input:checkbox[id='checkbox01_5']").prop("checked", false);
						$("input:checkbox[id='checkbox01_6']").prop("checked", false);
					}else if( obj.id!="checkbox01_1" && obj.checked ){
						$("input:checkbox[id='checkbox01_1']").prop("checked", false);
					}else{
						$("input:checkbox[id='checkbox01_1']").prop("checked", true);
					}
				}
				
				// 정렬기준
				$("input:radio[id='radio01_1']").prop("checked", true);				
				function chkValidSort(obj){
					if( obj.checked ){
						$("input:checkbox[id='radio01_1']").prop("checked", (obj.id=='radio01_1'?true:false));
						$("input:checkbox[id='radio01_2']").prop("checked", (obj.id=='radio01_2'?true:false));
						$("input:checkbox[id='radio01_3']").prop("checked", (obj.id=='radio01_3'?true:false));
						$("input:checkbox[id='radio01_4']").prop("checked", (obj.id=='radio01_4'?true:false));
					}
				}
				
				// 조회호출
				var lvParams;
				function fnSelectListCall() {
					
					var beginDte =nvl($("#datepicker-input1").val(),'');
					var endDte =nvl($("#datepicker-input2").val(),'');
					var catgrIdGrp = "";
					$('input:checkbox[name="checkbox01"]').each(function() {

					      //this.checked = true; //checked 처리

					      if(this.checked && this.value != "ALL"){//checked 처리된 항목의 값
					            catgrIdGrp+=","+this.value;
					      }

					 }); 
					var sortId = "";
					$('input:radio[name="radio01"]').each(function() {
					      if(this.checked ){//checked 처리된 항목의 값
					    	  sortId = this.value;
					      }

					 }); 
										
					  console.log("beginDte=>>"+beginDte);					  
					  console.log("endDte=>>"+endDte);
					  console.log("catgrIdGrp=>>"+catgrIdGrp);
					  console.log("detlCn=>>"+ $("#detlCn").val());
					  console.log("sortId=>>"+ sortId);
					  
					  
					  lvParams = {
							        "beginDte" : beginDte.replace(/-/gi,"")
							      , "endDte" : endDte.replace(/-/gi,"")
							      , "catgrIdGrp" : catgrIdGrp
							      , "sortId" : sortId
							      , "detlCn" : nvl($("#detlCn").val(),'')
							     };
					   
					
					  $("#div_load_image").show();
					  	$.ajax({
					  	    url: "/admin/catalog/selectCatalogList",
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
					
					switchContent("/admin/catalog/viewCatalog/"+obj.id);
					return;
					lvParams.catlgId = obj.id;
					gvSessionParams = lvParams;
					
					console.log( JSON.stringify(lvParams) );
					//alert( "작업중:::"+JSON.stringify(lvParams));
					
					$.ajax({
				  	    url: "/admin/catalog/viewCatalog",
				  	    type: "post",
				  	    data: JSON.stringify(lvParams),
				        contentType: "application/json",
				  	    success: function(rs) {
				  	    	//data = JSON.stringify(data);
				  	    	console.log(JSON.stringify(rs));					    	
				  	    	//var rsCnt = JSON.stringify(rs);
				  	    	//alert("["+rsCnt"]건 삭제 되었습니다.");
				  	    	
				  	    },
				  	    error: function (xhr, status, error) {
				  	    	alert("error=>>"+error);
				  	    }
				  	  });
				}
				
				//삭제
				function fnDel(obj){
					
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
								
								console.log( obj.id );
								lvParams.catlgId = obj.id;
								gvSessionParams = lvParams;
								
								console.log( JSON.stringify(lvParams) );
													
								$.ajax({
							  	    url: "/admin/catalog/deleteCatalog",
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
						  "positionClass": "toast-bottom-right"
					     ,"timeOut": "1500"
						};
				
			</script>