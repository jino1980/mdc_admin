<%@page import="com.merck.catalog.common.SoftLabHumUtils"%>
<%@page import="com.merck.catalog.admin.vo.TbSaa002d"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<%@page import="java.util.*"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%

List<Map<String,Object>> cmmnCdList = new ArrayList();
List<Map<String,Object>> paramList = (List<Map<String,Object>>)request.getAttribute("cmmnCdList");
if( null == paramList || paramList.size() == 0 ) {
	   TbSaa002d vo = new TbSaa002d();
	   vo.setCmmnCdId("CATE01");
	   vo.setCmmnCd("신규 추가");
	   cmmnCdList.add(0, SoftLabHumUtils.converVoToMap(vo));
	   request.setAttribute("cmmnCdList", cmmnCdList);
	   
}else{
	   cmmnCdList = (List<Map<String,Object>>)request.getAttribute("cmmnCdList");
	   System.out.println("#### cmmnCdList =>>>"+cmmnCdList.get(0));
}

%>
        <!-- header -->
        <style type="text/css">
        body {
			  font-size: 14px;
			}
			
			.recipe { 
			  padding: 1em;
			}
			.recipe__title {
			  margin-top: 0;
			}
			.recipe__info {
			  vertical-align: top;
			  text-align: right;
			  padding: 0 1em 0 0;
			  margin: 0 1.3em 0 0;
			  font-weight: bold;
			  color: #454545;
			  border-right: 1px dotted #EEE;
			  width: 300px;
			  float: left;
			}
			.recipe__ingredients {
			  float: left;
			}
			.recipe-table {
			  position: relative;
			  padding:  1em;
			  border: 1px solid #DDD;
			  box-shadow: 0 15px 10px -10px rgba(31, 31, 31, 0.5);
			  z-index: 10;
			}
			
			.recipe-table__cell {
			  vertical-align: top;
			  padding: 3px 5px;
			}
			.recipe__text-field {
			  margin:0;
			  padding: .45em 0.92em;
			  font-size: 1em;
			  line-height: 1.4;
			  color: #555555;
			  background-color: #FFF;
			  background-image: none;
			  border: 1px solid #CCC;
			  border-left:1px solid #CCC;
			  
			}
			.recipe-table__add-row {
			  margin-top: 0;
			  position: relative;
			  border-top: 1px solid #EEE;
			  z-index: 8;
			}
			
			.recipe-table__add-row-btn {
			  display: block;
			  cursor: pointer;
			  position: absolute;
			  right: 0;
			  left: 0;
			  width: 4em;
			  margin: 0 auto;
			  -webkit-transition: all .2s easy-in;
			  transition: all .2s easy-in;
			  text-align: center;
			  opacity: 0.5;
			  color: #fff;
			  border: 1px solid #16A085;
			  border-bottom-right-radius: 1em;
			  border-bottom-left-radius: 1em;
			  background: #16A085;
			  height: 1.5em;
			  line-height: 1.5em;
			}
			.recipe-table__add-row-btn:hover {
			  opacity: 1;
			}
			
			.recipe-table__del-row-btn {
			  cursor: pointer;
			  display: inline-block;
			  padding: .45em 0.92em;
			  font-size: 1em;
			  line-height: 1.4;
			  border: 1px solid #F39C12;
			  color: #F39C12;
			  text-decoration: none;
			  transition: all .3s;
			  text-align: center;
			  background-color: #fff;
			}
			.recipe-table__del-row-btn:hover {
			  background: #F39C12;
			  color: #fff;
			}
			
			
			.drag-handler {
			  width: 1.4em;
			  position: relative;
			  background-color: #E4E6EB;
			  background-image: linear-gradient(45deg, #E4E6EB, #E4E6EB 2px, #fff 2px, #fff 4px, #E4E6EB 4px, #E4E6EB 9px, #fff 9px, #fff 11px, #E4E6EB 11px, #E4E6EB 16px, #fff 16px, #fff 18px, #E4E6EB 18px, #E4E6EB 22px);
			  background-size: 10px 20px; 
			  cursor: move;
			  border-top: 2px solid #FFF;
			  border-bottom: 2px solid #FFF;
			}
			
			.drag-handler:active {
			  background-image: linear-gradient(45deg, #bab86c, #bab86c 2px, #fff 2px, #fff 4px, #bab86c 4px, #bab86c 9px, #fff 9px, #fff 11px, #bab86c 11px, #bab86c 16px, #fff 16px, #fff 18px, #bab86c 18px, #bab86c 22px);
			  background-size: 10px 20px; 
			}
        </style>
        <script src="${RESOURCES_PATH}/resource/js/Sortable.js"></script>
        
            <div class="header">

                <div class="info">
                    <span class="logout"><button type="button" title="로그아웃"></button></span>
                </div>
                <ul class="gnb_menu">
                    <li>
                        <a href="#" class="on" class="sel">카테고리 관리</a>
                    </li>
                </ul>
            </div>
            <!-- // header -->

            <!-- content -->

            <div class="content">
                <!-- 카테고리 리스트 -->
                

				<div class="recipe">
				  
				  <div class="recipe__info">
				    <h2 class="recipe__title"></h2>
				    <p></p>
				  </div>
				  
				  	<div class="recipe__ingredients">
				    <table cellpadding="0" cellspacing="0" border="0" class="recipe-table" id="recipeTable">
				      <tbody id="recipeTableBody">
				      
				      		<!-- 작성폼 ---------------------------------------------------------------------------------->
				         <form:form commandName="cateForm" action="#">
		                 <c:forEach var="cmmnCd" items="${cmmnCdList}" varStatus="status">
						        <tr>
						        
				                    <input type="hidden" id="cmmnCdId" name="cmmnCdId"  value="CATE01"/>
						            <input type="hidden" id="taskSe" name="taskSe"  value="CATE"/>
						            <input type="hidden" id="taskSeCd" name="taskSeCd"  value="CTE"/>
						            
						            <input type="hidden" id="cmmnCdIdNm" name="cmmnCdIdNm"  value="${cmmnCd.cmmnCdIdNm}"/>
						            <input type="hidden" id="cmmnCdAbbrNm" name="cmmnCdAbbrNm"  value="${cmmnCd.cmmnCdAbbrNm}"/>
						            <input type="hidden" id="cmmnCdSn" name="cmmnCdSn"  value="${cmmnCd.cmmnCdSn}"/>
						            <input type="hidden" id="cmmnSortSn" name="cmmnSortSn"  value="${cmmnCd.cmmnSortSn}"/>
						            <input type="hidden" id="mangItemParm01" name="mangItemParm01"  value="${cmmnCd.mangItemParm01}"/>
						            <input type="hidden" id="mangItemVal01" name="mangItemVal01"  value="${cmmnCd.mangItemVal01}"/>
						            <input type="hidden" id="mangItemParm02" name="mangItemParm02"  value="${cmmnCd.mangItemParm02}"/>
						            <input type="hidden" id="mangItemVal02" name="mangItemVal02"  value="${cmmnCd.mangItemVal02}"/>
						            <input type="hidden" id="mangItemParm03" name="mangItemParm03"  value="${cmmnCd.mangItemParm03}"/>
						            <input type="hidden" id="mangItemVal03" name="mangItemVal03"  value="${cmmnCd.mangItemVal03}"/>
						            
						          <td class="drag-handler"></td>
						          <td class="recipe-table__cell" width="70%">
						            <input type="text" id="cmmnCdNm" name="cmmnCdNm" title="카테고리명" class="recipe__text-field required" placeholder=":::카테고리명 입력:::" value="${cmmnCd.cmmnCdNm}">
						          </td>
						          <td class="recipe-table__cell">
						            <input type="text" id="cmmnCd" name="cmmnCd" class="recipe__text-field" readOnly value="${cmmnCd.cmmnCd}" placeholder="${cmmnCd.cmmnCd}">
						          </td>
						          <td class="recipe-table__cell">
						            <button class="recipe-table__del-row-btn">x</button>
						          </td>
						        </tr>
				        
	            		</c:forEach>
					    </form:form>
					    <!-- 작성폼 END-------------------------------------------------------------------------------->
					    
				      </tbody>
				    </table>
				    <div class="recipe-table__add-row">
				      <!-- <span class="recipe-table__add-row-btn">+</span> -->
				    </div>
				    
				    
				    <div class="paging_box">
	                    <div class="btn_box">
	                        <button type="button" class="btn btn_default" name"btnAdd" onClick="javascript:fnAdd();" >추가</button>
	                        <button type="button" class="btn btn_default" onClick="javascript:fnSave(1);">저장</button>
	                    </div>
	                </div>
				  </div>
				</div>
				<script id="rowTemplate" type="text/template">
    				<tr>
						
					<input type="hidden" id="cmmnCdId" name="cmmnCdId"  value="CATE01"/>
					<input type="hidden" id="taskSe" name="taskSe"  value="CATE"/>
					<input type="hidden" id="taskSeCd" name="taskSeCd"  value="CTE"/>

					<input type="hidden" id="cmmnCdIdNm" name="cmmnCdIdNm"  value="카테고리구분"/>
					<input type="hidden" id="cmmnCdAbbrNm" name="cmmnCdAbbrNm"  value=""/>
					<input type="hidden" id="cmmnCdSn" name="cmmnCdSn"  value=""/>
					<input type="hidden" id="cmmnSortSn" name="cmmnSortSn"  value=""/>
					<input type="hidden" id="mangItemParm01" name="mangItemParm01"  value=""/>
					<input type="hidden" id="mangItemVal01" name="mangItemVal01"  value=""/>
					<input type="hidden" id="mangItemParm02" name="mangItemParm02"  value=""/>
					<input type="hidden" id="mangItemVal02" name="mangItemVal02"  value=""/>
					<input type="hidden" id="mangItemParm03" name="mangItemParm03"  value=""/>
					<input type="hidden" id="mangItemVal03" name="mangItemVal03"  value=""/>

        				<td class="drag-handler"></td>
        				<td class="recipe-table__cell">
            				<input type="text" id="cmmnCdNm" name="cmmnCdNm" title="카테고리명" class="recipe__text-field required" placeholder=":::카테고리명 입력:::">
        				</td>
        				<td class="recipe-table__cell">
            				<input type="text" id="cmmnCd" name="cmmnCd" class="recipe__text-field" value="" readOnly placeholder="신규추가">
        				</td>
        				<td class="recipe-table__cell">
           					 <button class="recipe-table__del-row-btn">x</button>
        				</td>
    				</tr>
				</script>



                <!-- // 카테고리 리스트 -->
                <!-- 페이징 + 버튼 -->
                
                <!-- // 페이징 + 버튼 -->

            </div>
            <!-- // content -->


    <script>
    
	    $(document).ready(function () {
	    	  var $tableBody = $('#recipeTableBody');
	    	  var $menu = $('#menu');
	    	    
	    	  	$(document).on('click', 'button[name="btnAdd"]', function (e) { 
	    	  	//$(document).on('click', '.recipe-table__add-row-btn', function (e) {
	    	        var $el = $(e.currentTarget);
	    	        var htmlString = $('#rowTemplate').html();
	    	        $tableBody.append(htmlString);
	    	        return false;
	    	    });
	
	    	    $tableBody.on('click', '.recipe-table__del-row-btn', function (e) {
	    	        var $el = $(e.currentTarget);
	    	        var $row = $el.closest('tr');
	    	        
	    	        var isValid = fnDelValidate($row);
	    	        
	    	        if( isValid ) $row.remove();
	    	        
	    	        return false;
	    	    });
	    	  Sortable.create(
	    	        $tableBody[0],
	    	        {
	    	            animation: 150,
	    	            scroll: true,
	    	            handle: '.drag-handler',
	    	            onEnd: function () {
	    	                console.log('Sortable onEnd..');
	    	            }
	    	        }
	    	    );
	    	  
	    	});
	    	  	
	    	  	
	    	  	
		var cmmnCdId = "CATE01"; // 카테고리 공통코드
        var taskSe = "CATE";
	    	  	
     	// 추가
		function fnAdd(){
			var htmlString = $('#rowTemplate').html();
			$('#recipeTableBody').append(htmlString);
		}
     	
     	// 삭제 유효성 체크
     	function fnDelValidate(trObj){
     		
     		var currCmmnCdNM = "";
     		var currCmmnCd = "";
     		
			trObj.find('input').map(function(j, td){
		       
				//console.log("find input j=> ",j);
				//console.log("find input td=> ",td);
				//console.log("find $(this).val()=>"+$(this).val());
				
				//console.log("this=>"+$(this));
				//console.log("fnDelValidate id=>"+$(this).prop("id"));
				//console.log("fnDelValidate val=>"+$(this).val());
				
				currCmmnCd = ( $(this).prop("id") =="cmmnCd" ? $(this).val() : currCmmnCd);
				currCmmnCdNM = ( $(this).prop("id") =="cmmnCdNm" ? $(this).val() : currCmmnCdNM);
			});
			
			//alert("## currCmmnCd=>>"+currCmmnCd);
			
			// 카테고리명 체크
			if( isNull(currCmmnCd) ){
				return true;
				
			}else{
				var bRtn = false;			
				var lvParams = {
				        "cmmnCdId" : cmmnCdId
				      , "taskSe": taskSe
				      , "cmmnCdNm" : currCmmnCdNM 						       
				      , "cmmnCd" : currCmmnCd						       
				     };
				
				console.log("### fnDelValidate lvParams=>>"+JSON.stringify(lvParams));

				$("#div_load_image").show();
				$.ajax({
			  	    url: "/admin/cmmnCd/chkForUsing/"+cmmnCdId+"/"+currCmmnCd,
			  	    type: "post",
			  	    data: JSON.stringify(lvParams),
			        contentType: "application/json",
			  	    success: function(rs) {
			  	    	
			  	    	console.log("### (1) rs=>>"+rs.isUsing);
			  	    	$("#div_load_image").hide();
			  	    	
			  	    	if( rs.isUsing == "Y" ){
				  	    	toastr["warning"]("삭제 할 수 없습니다. 카탈로그에서 사용중인 카테고리구분 입니다.");
				  	    	bRtn = false;
			  	    	}else{
			  	    		bRtn = true;
			  	    		
			  	    		trObj.remove();
			  	    	}
			  	    	
			  	    },
			  	    error: function (xhr, status, error) {
			  	    	$("#div_load_image").hide();
			  	    	alert("error=>>"+error);
			  	    }
			  	  });
				
				return bRtn;
			}
			
     	}
	    
     	
		function getFormJson() { 
			var arr1 = [];
			var carr = ['cmmnCdId','taskSe','taskSeCd','cmmnCdIdNm', 'cmmnCdAbbrNm','cmmnCdSn','cmmnSortSn'
						,'mangItemParm01','mangItemVal01'
						,'mangItemParm02','mangItemVal02'
						,'mangItemParm03','mangItemVal03'
						,'cmmnCdNm' , 'cmmnCd'
						];
			var cmmnCdNmArr = "";
			$("#recipeTableBody tr").map(function(i, tr){
				var arr = {};
				$(this).find('input').map(function(j, td){
			       
					//console.log("find input j=> ",j);
					//console.log("find input td=> ",td);
					//console.log("find $(this).val()=>"+$(this).val());
					
					//console.log("this=>"+$(this));
					//console.log("this=>"+$(this).prop("id"));
					//console.log("this.val=>"+$(this).val());
					
					// 카테고리명 체크
					if( $(this).prop("id") =="cmmnCdNm" && isNull($(this).val())){
						toastr["warning"]("카테고리명을 입력하세요.");
						$(this).focus();
						arr = null;
						return false;
					}else if( $(this).prop("id") =="cmmnCdNm" && !isNull($(this).val()) ) {
						
						if( cmmnCdNmArr.indexOf( $.trim($(this).val()) ) > -1 ){
							
							toastr["warning"]("카테고리명이 중복되었습니다.");
							$(this).focus();
							arr = null;
							return false;
							
						}
						cmmnCdNmArr+="_"+($.trim($(this).val()));
						
					}
					
					arr[carr[j]] = $.trim( $(this).val() );
					
				});
				arr1.push(arr);
				
				//console.log("--------------------------------------------");
			});
			//console.log("### arr1=>>"+JSON.stringify(arr1));
			
			return JSON.parse(JSON.stringify(arr1));
		} 

		//-- 저장 --//
  		function fnSave(idx){
  			
  			var json = getFormJson();
  			console.log("## formJson=>>"+JSON.stringify(json));
			if( json == false ) return;
			
  			if( idx == 0 ){
  				fnAjaxCall(json);
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
	  						
	  						fnAjaxCall(json);
	  						
	  					}
	  				}
	  			});
  			}
  		}
  		
        function fnAjaxCall(json){
        	
        	$("#div_load_image").show();
        	$.ajax({
			  	    url: "/admin/cmmnCd/saveCmmnCd",
			  	    type: "post",
			  	    data: JSON.stringify(json),
			        contentType: "application/json",
			  	    success: function(rs) {
			  	    	//data = JSON.stringify(data);
			  	    	console.log("### saveCatalog=>>"+rs);					    	
			  	    	//grid.setData(rs);							  	    	
			  	    	toastr["success"](rs+"건 저장 되었습니다.","저장완료.");
			  	    	switchContent('/admin/cmmnCd/selectCmmnCdList/CATE/CATE01/Y');
			  	    	
			  	    },
			  	    error: function (xhr, status, error) {
			  	    	$("#div_load_image").hide();
			  	    	alert("error=>>"+error);
			  	    }
			  	  });
        }
		
		
		toastr.options = {
				  "positionClass": "toast-bottom-right",
				  "timeOut": "1500"
				};
	    
    </script>