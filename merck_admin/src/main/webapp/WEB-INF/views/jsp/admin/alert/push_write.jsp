<%@page import="com.merck.catalog.common.SoftLabHumUtils"%>
<%@page import="com.merck.catalog.admin.vo.TbCab001m"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<%@page import="java.util.*"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%

List<Map<String,Object>> boardPostList = new ArrayList();
List<Map<String,Object>> paramList = (List<Map<String,Object>>)request.getAttribute("boardPostList");
List<Map<String,Object>> categoryCmmnCdList = (List<Map<String,Object>>)request.getAttribute("categoryCmmnCdList");

if( null == paramList || paramList.size() == 0 ) {
	   TbCab001m vo = new TbCab001m();
	   vo.setBoardId("PUSH00000001");
	   boardPostList.add(0, SoftLabHumUtils.converVoToMap(vo));
	   //System.out.println("#### SoftLabHumUtils.converVoToMap(vo)=>>>"+SoftLabHumUtils.converVoToMap(vo));
	   
	   request.setAttribute("boardPostList", boardPostList);
	   
}else{
	   boardPostList = (List<Map<String,Object>>)request.getAttribute("boardPostList");
	   System.out.println("#### boardPostList =>>>"+boardPostList.get(0));
}

String pushBeginDate = SoftLabHumUtils.nvl( boardPostList.get(0).get("pushBeginDt") );

String pushBeginDtStr = SoftLabHumUtils.nvl( boardPostList.get(0).get("pushBeginDate") );

request.setAttribute("categoryCmmnCdList", categoryCmmnCdList);

%>
<%!

	// 문자열 포함 여부
   private boolean isMatchByStrings(String findStr , String matcher )
   {
		if( null != matcher &&  !"".equals(matcher) && matcher.indexOf(findStr) > -1 ){
			return true;
		}else{
			return false;
		}
   }
   

%>

        <!-- header -->
            <div class="header">

                <div class="info">
                    <span class="logout"><button type="button" title="로그아웃"></button></span>
                </div>
                <ul class="gnb_menu">
                    <li>
                        <a href="#" class="on" class="sel">푸시 등록</a>
                    </li>
                </ul>
            </div>
            <!-- // header -->

            <!-- content -->
			<c:forEach var="boardPost" items="${boardPostList}">
            
            <form:form commandName="pushForm" action="#">
            <input type="hidden" id="boardId" name="boardId"  value="${boardPost.boardId}"/>
            <input type="hidden" id="postId" name="postId"  value="${boardPost.postId}"/>
            <input type="hidden" id="pushRegNo" name="pushRegNo"  value="${boardPost.pushRegNo}"/>
            
            <input type="hidden" id="taskSe" name="taskSe"  value="PUSH"/>
            <input type="hidden" id="taskSeCd" name="taskSeCd"  value="NTC"/>
            
            <div class="content">
                <!-- 작성폼 -->
                <div class="tb_create">
                    <table>
                        <caption>등록</caption>
                        <colgroup>
                            <col width="160">
                            <col>
                            <col width="160">
                            <col>
                        </colgroup>
                        <tbody>
                            <tr>
                                <th scope="row">
                                    제목
                                </th>
                                <td colspan="3">
                                    <input type="text" class="required" title="제목" name="title" id="title" value="${boardPost.title}">
                                </td>
                            </tr>
                            <tr>
                                <th scope="row">
                                    카테고리
                                </th>
                                <td colspan="3">
									<ul class="inputbox">
										<li>
                                            <input type="checkbox" id="checkbox01_1" name="catgrIdGrp" onchange="chkValidCate(this);" value="" <c:if test="${empty boardPost.catgrIdGrp}">checked</c:if>><label
                                                for="checkbox01_1">전체</label>
                                        </li>

                                        	<c:set var="catgrIdGrp" value="${boardPost.catgrIdGrp}" />
                                        	<%
                                        		String catgrIdGrp = (String)pageContext.getAttribute("catgrIdGrp")+"";
                                        	
                                        		String[] catgrIdGrpArr = new String[categoryCmmnCdList.size()];
                                        		boolean[] catgrIdMathcedArr = new boolean[categoryCmmnCdList.size()];
                                        		
                                        		for(int l=0; l<categoryCmmnCdList.size(); l++){
                                        			Map m = (Map)categoryCmmnCdList.get(l);
                                        			String cmmnCdNm = (String)m.get("cmmnCdNm");
                                        			catgrIdGrpArr[l] = cmmnCdNm;
                                        			catgrIdMathcedArr[l] = isMatchByStrings(cmmnCdNm,catgrIdGrp);
                                        			
                                        			
                                        			String checked = (catgrIdMathcedArr[l]?"checked":"");
                                           %>
                                           
                                           <li>
	                                            <input type="checkbox" id="checkbox01_<%=l+2%>" name="catgrIdGrp" onClick="chkValidCate(this);" value="<%=cmmnCdNm%>" <%=checked%>>
	                                            <label for="checkbox01_<%=l+2%>"><%=cmmnCdNm%></label>
	                                        </li>
                                           
                                           <%
                                        		}
                                        		
                                        	%>
                                        	
									</ul>
                                </td>
                            </tr>
                            <tr>
                                <th scope="row">
                                    간략내용
                                </th>
                                <td colspan="3">
                                    <textarea name="cn" id="cn" title="간략내용" class="required" cols="30" rows="10">${boardPost.cn}</textarea>
                                </td>
                            </tr>
                            <tr>
                                <th scope="row">
                                    카탈로그 경로
                                </th>
                                <td>
                                    <input type="text" name="catlgUrl" id="catlgUrl" value="${boardPost.catlgUrl}">
                                </td>
                                <th scope="row">
                                    발행일
                                </th>
                                <td>
                                    <button type="button" class="tb_btn disabled" id="btnToday" onClick="javascript:fnChgRrsv(this);">현재</button><button type="button" class="tb_btn state" id="btnRrsv" onClick="javascript:fnChgRrsv(this);">예약</button>
                                    <div class="datepicker_box">
                                        <div class="tui-datepicker-input tui-datetime-input tui-has-focus">
                                            <input type="text" title="발행일" class="required" id="pushBeginDt" name="pushBeginDt" aria-label="Date-Time" value="${boardPost.pushBeginDt}">
                                            <span name="calSpan" id="calSpan" class="tui-ico-date"></span>
                                        </div>
                                        <div id="wrapper1" name="wrapper1" style="margin-top: -1px;"></div>
                                    </div>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <!-- // 작성폼 -->


                <!-- 페이징 + 버튼 -->
                <div class="paging_box">
                    <div class="btn_box">
                        <button type="button" class="btn btn_default" onClick="javascript:switchContent('/admin/alert/push_write');">신규</button>
                        <button type="button" class="btn btn_default" onClick="javascript:fnSave(0);">임시저장</button>
                        <button type="button" class="btn btn_default" onClick="javascript:fnSave(1);">등록</button>
                        <button type="button" class="btn btn_default" onClick="javascript:switchContent('/admin/alert/push_list');">목록으로</button>
                    </div>
                </div>
                <!-- // 페이징 + 버튼 -->
	
            </div>
            </form:form>
            </c:forEach>
            <!-- // content -->

    <script>
        var datepicker1 = new tui.DatePicker('#wrapper1', {
            date: parseStrToDate('<%=pushBeginDate%>'),            
            input: {
                element: '#pushBeginDt',
                format: 'yyyy-MM-dd HH:mm'
            },
            timePicker: true
        });
		
     	// 카테고리 체크
		function chkValidCate(obj){
			if( obj.id=="checkbox01_1" && obj.checked ){
				//console.log("전체 체크");
				$("input:checkbox[id='checkbox01_2']").prop("checked", false);
				$("input:checkbox[id='checkbox01_3']").prop("checked", false);
				$("input:checkbox[id='checkbox01_4']").prop("checked", false);
				$("input:checkbox[id='checkbox01_5']").prop("checked", false);
				$("input:checkbox[id='checkbox01_6']").prop("checked", false);
			}else if( obj.id!="checkbox01_1" && obj.checked ){
				//console.log("카테고리 체크");
				$("input:checkbox[id='checkbox01_1']").prop("checked", false);
			}else{
				//console.log("그외 체크");
				$("input:checkbox[id='"+obj.id+"']").prop("checked", false).trigger('change');
			}
		}
     
        function fnChgRrsv(obj){
      	  
      	  if( obj.id == "btnToday" ){

      		  datepicker1 = new tui.DatePicker('#wrapper1', {
      	            date: new Date(),            
      	            input: {
      	                element: '#pushBeginDt',
      	                format: 'yyyy-MM-dd HH:mm'
      	            },
      	          timePicker: true
      	        });
      		  
      		  $("#btnToday").prop("class","tb_btn state");
      		  $("#btnRrsv").prop("class","tb_btn disabled");
      		  //$("#pushBeginDt").prop("readOnly",true);
      		  //$("#calSpan").prop("class","");
      		  datepicker1.disable();
      		  
      	  }else{
      		  $("#pushBeginDt").val('<%=pushBeginDtStr%>');
      		  $("#btnToday").prop("class","tb_btn disabled");
      		  $("#btnRrsv").prop("class","tb_btn state");
      		  //$("#pushBeginDt").prop("readOnly",false);
      		  //$("#calSpan").prop("class","tui-ico-date");
      		  datepicker1.enable();
      	  }
        }
          
        //-- 저장 --//
        var boardId = "PUSH00000001"; // 공지사항
  		function fnSave(idx){
  			
  			var formData = $("#pushForm").serializeObject();
  			var pushBeginDt = $("#pushBeginDt").val();
  			
  			var catgrIdGrp = "";
			$('input:checkbox[name="catgrIdGrp"]').each(function() {

			      //this.checked = true; //checked 처리

			      if(this.checked && this.value != "ALL"){//checked 처리된 항목의 값
			            catgrIdGrp+=","+this.value;
			      }

			 }); 
			formData.catgrIdGrp = catgrIdGrp;
  			
  			if( isNull(pushBeginDt) == false ){
  				formData.pushBeginDt = (((((pushBeginDt.replace(/-/gi,"")).replace(/:/gi,"")).replace(/ /gi,"")).replace('PM',"")).replace('AM',""));
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
			  	    	
			  	    	if( nvl($("#postId").val(),'') == '' ) switchContent('/admin/board/viewBoardCommon/'+boardId+"/"+rs);
			  	    	
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