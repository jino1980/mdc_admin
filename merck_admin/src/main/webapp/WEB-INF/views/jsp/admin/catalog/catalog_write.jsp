<%@page import="com.merck.catalog.common.SoftLabHumUtils"%>
<%@page import="com.merck.catalog.admin.vo.TbCaa001m"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<%@page import="java.util.*"%>
<%
	
	System.out.println("#### CATALOG_WRITE JSP...");

   List<Map<String,Object>> catalogList = new ArrayList();
   List<Map<String,Object>> paramList = (List<Map<String,Object>>)request.getAttribute("catalogList");
   if( null == paramList || paramList.size() == 0 ) {
	   TbCaa001m vo = new TbCaa001m();
	   catalogList.add(0, SoftLabHumUtils.converVoToMap(vo));
	   System.out.println("#### SoftLabHumUtils.converVoToMap(vo)=>>>"+SoftLabHumUtils.converVoToMap(vo));
	   
	   request.setAttribute("catalogList", catalogList);
	   
   }else{
	   catalogList = (List<Map<String,Object>>)request.getAttribute("catalogList");
	   System.out.println("#### catalogList =>>>"+catalogList.get(0));
   }
   
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
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
        <!-- header -->
        <script src="${RESOURCES_PATH}/resource/js/fileUtil.js"></script>
            <div class="header">

                <div class="info">
                    <span class="logout"><button type="button" title="로그아웃"></button></span>
                </div>
                <ul class="gnb_menu">
                    <li>
                        <a href="#" class="on" class="sel">카탈로그 등록</a>
                    </li>
                </ul>
            </div>
            <!-- // header -->

            <!-- content -->
            <c:forEach var="catalog" items="${catalogList}">
            
            <form:form commandName="catalogForm" action="#">
            <input type="hidden" id="catlgId" name="catlgId"  value="${catalog.catlgId}"/>
            
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
                                    카탈로그 명
                                </th>
                                <td colspan="3">
                                    <input type="text" name="catlgNm" id="catlgNm" value="${catalog.catlgNm}">
                                </td>
                            </tr>
                            <tr>
                                <th scope="row">
                                    이미지등록
                                </th>
                                <td colspan="3">
                                    <div class="file_wrap">

                                        <ul class="img_create_list">
                                            <li>
                                                <div class="file_wrap">
                                                    <div class="dragAndDropDiv filebox2" id="fileDiv1" onClick="javascript:fileUtil.fn.selectFiles('fileDiv1');">
                                                        <input type="hidden" id="fileId" name="fileId"  value="0"/>
    
                                                        <!-- 썸네일 정보 -->
                                                        <div class="thumnail_txt_info">
                                                            <span class="color_red">[필수]</span><br>
                                                            <span>대표 이미지</span><br>
                                                            <span>사이즈표기</span><br>
                                                        </div>
    
                                                        <!-- 썸네일 이미지 -->
                                                        <!-- <div class="thumnail_img">
                                                            <img src="../resource/images/list_type03_img03.jpg" alt="">
                                                        </div> -->
                                                    </div>
                                                </div>
                                            </li>
                                             
                                            <li>
                                                <div class="file_wrap">
                                                    <div class="dragAndDropDiv filebox2" id="fileDiv2" onClick="javascript:fileUtil.fn.selectFiles('fileDiv2');">
                                                        <input type="hidden" id="fileId" name="fileId"  value="0"/>
    
                                                        <!-- 썸네일 정보 -->
                                                        <div class="thumnail_txt_info">
                                                            <span>추가 이미지1</span><br>
                                                            <span>사이즈표기</span><br>
                                                        </div>
    
                                                        <!-- 썸네일 이미지 -->
                                                        <!-- <div class="thumnail_img">
                                                            <img src="../resource/images/list_type03_img03.jpg" alt="">
                                                            <button type="button" class="thumnail_del">삭제</button>
                                                        </div> -->
                                                    </div>
                                                </div>
                                            </li>
                                            <li>
                                                <div class="file_wrap">
                                                    <div class="dragAndDropDiv filebox2" id="fileDiv3" onClick="javascript:fileUtil.fn.selectFiles('fileDiv3');">
                                                        <input type="hidden" id="fileId" name="fileId"  value="0"/>
    
                                                        <!-- 썸네일 정보 -->
                                                        <div class="thumnail_txt_info">
                                                            <span>추가 이미지2</span><br>
                                                            <span>사이즈표기</span><br>
                                                        </div>
    
                                                        <!-- 썸네일 이미지 -->
                                                        <!-- <div class="thumnail_img">
                                                            <img src="../resource/images/list_type03_img03.jpg" alt="">
                                                        </div> -->
                                                    </div>
                                                </div>
                                            </li>
                                            <li>
                                                <div class="file_wrap">
                                                    <div class="dragAndDropDiv filebox2" id="fileDiv4" onClick="javascript:fileUtil.fn.selectFiles('fileDiv4');">
                                                        <input type="hidden" id="fileId" name="fileId"  value="0"/>
    
                                                        <!-- 썸네일 정보 -->
                                                        <div class="thumnail_txt_info">
                                                            <span>추가 이미지3</span><br>
                                                            <span>사이즈표기</span><br>
                                                        </div>
    
                                                        <!-- 썸네일 이미지 -->
                                                        <!-- <div class="thumnail_img">
                                                            <img src="../resource/images/list_type03_img03.jpg" alt="">
                                                        </div> -->
                                                    </div>
                                                </div>
                                            </li>
                                            <li>
                                                <div class="file_wrap">
                                                    <div class="dragAndDropDiv filebox2" id="fileDiv5" onClick="javascript:fileUtil.fn.selectFiles('fileDiv5');">
                                                        <input type="hidden" id="fileId" name="fileId"  value="0"/>
    
                                                        <!-- 썸네일 정보 -->
                                                        <div class="thumnail_txt_info">
                                                            <span>추가 이미지4</span><br>
                                                            <span>사이즈표기</span><br>
                                                        </div>
    
                                                        <!-- 썸네일 이미지 -->
                                                        <!-- <div class="thumnail_img">
                                                            <img src="../resource/images/list_type03_img03.jpg" alt="">
                                                        </div> -->
                                                    </div>
                                                </div>
                                            </li>
                                        </ul>
                                        <ul class="bullet mark mt5">
                                            <li>이미지는 JPG/PNG/GIF 형식의 파일로 3MB이하로 등록이 가능합니다.</li>
                                        </ul>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th scope="row">
                                    카테고리
                                </th>
                                <td colspan="3">
                                    <ul class="inputbox">
                                        <li>
                                            <input type="checkbox" id="checkbox01_1" name="catgrIdGrp" onClick="chkValidCate(this);" value="" <c:if test="${empty catalog.catgrIdGrp}">checked</c:if>><label
                                                for="checkbox01_1">전체</label>
                                        </li>
                                        <li>
                                        	<c:set var="catgrIdGrp" value="${catalog.catgrIdGrp}" />
                                        	<%
                                        		String catgrIdGrp = (String)pageContext.getAttribute("catgrIdGrp")+"";
                                        		String[] catgrIdGrpArr = {",생명과학",",화학",",재료과학",",QA/QC",",기타",",추가.."};
                                        		boolean[] catgrIdMathcedArr = {false,false,false,false,false,false};
                                        		
                                        		for(int i=0; i<catgrIdGrpArr.length; i++){ 
                                        			catgrIdMathcedArr[i] = isMatchByStrings(catgrIdGrpArr[i],catgrIdGrp);
                                        		}
                                        		
                                        		pageContext.setAttribute("catgrIdMathcedArr", catgrIdMathcedArr);
                                        		
                                        	%>

											
                                            <input type="checkbox" id="checkbox01_2" name="catgrIdGrp" onClick="chkValidCate(this);" value="생명과학" <c:if test="${catgrIdMathcedArr[0]}">checked</c:if>><label
                                                for="checkbox01_2">생명과학</label>
                                        </li>
                                        <li>
                                            <input type="checkbox" id="checkbox01_3" name="catgrIdGrp" onClick="chkValidCate(this);" value="화학" <c:if test="${catgrIdMathcedArr[1]}">checked</c:if>><label
                                                for="checkbox01_3">화학</label>
                                        </li>
                                        <li>
                                            <input type="checkbox" id="checkbox01_4" name="catgrIdGrp" onClick="chkValidCate(this);" value="재료과학" <c:if test="${catgrIdMathcedArr[2]}">checked</c:if>><label
                                                for="checkbox01_4">재료과학</label>
                                        </li>
                                        <li>
                                            <input type="checkbox" id="checkbox01_5" name="catgrIdGrp" onClick="chkValidCate(this);" value="QA/QC" <c:if test="${catgrIdMathcedArr[3]}">checked</c:if>><label
                                                for="checkbox01_5">QA/QC</label>
                                        </li>
                                        <li>
                                            <input type="checkbox" id="checkbox01_6" name="catgrIdGrp" onClick="chkValidCate(this);" value="기타" <c:if test="${catgrIdMathcedArr[4]}">checked</c:if>><label
                                                for="checkbox01_6">기타</label>
                                        </li>
                                    </ul>
                                </td>
                            </tr>
                            <tr>
                                <th scope="row">
                                    검색어
                                </th>
                                <td colspan="3">
                                	<c:set var="keywdValGrp" value="${catalog.keywdValGrp}" />
                                	<%
                                	
                                   		String keywdValGrp = (String)pageContext.getAttribute("keywdValGrp")+"";
                                   		String[] keywdValGrpArr = keywdValGrp.split(",");
                                   		
                                   		String keywdValGrpHTML = "";
                                   		String tagArrObj = "";
                                   		for(int i=1; i<keywdValGrpArr.length; i++){ 
                                   			keywdValGrpHTML += "<li style='float:left;'>"+keywdValGrpArr[i]+"<span class='del-btn' idx='"+(i-1)+"'> X&nbsp;&nbsp;&nbsp;&nbsp</span></li>";
                                   			tagArrObj += (i==1?"":",")+ i+":'"+keywdValGrpArr[i]+"'";
                                   		}
                                   		
                                   		System.out.println("### tagArrObj =>>"+tagArrObj);
                                   		
                                   		pageContext.setAttribute("keywdValGrpCnt", (keywdValGrpArr.length>0?keywdValGrpArr.length-1:0) );
                                   		pageContext.setAttribute("keywdValGrpHTML", keywdValGrpHTML);
                                   		pageContext.setAttribute("tagArrObj", tagArrObj);
                                   		
                                   	%>
                                	<div class="tr_hashTag_area">
							           <div class="form-group">
							                <input type="hidden" value="" name="tag" id="rdTag" />
							            </div>
							        
							             <ul id="tag-list">${keywdValGrpHTML}</ul></br>
							                        
							            <div class="form-group">
							            	<input type="text" id="tag" size="7" placeholder="엔터로 해시태그를 등록해주세요." style="width: 300px;"/>
							           </div>
							           
									</div>
                                    <input type="hidden" name="keywdValGrp" id="keywdValGrp" value="${catalog.keywdValGrp}">
                                </td>
                            </tr>
                            <tr>
                                <th scope="row">
                                    간략내용
                                </th>
                                <td colspan="3">
                                    <textarea name="simplCn" id="simplCn" cols="30" rows="10">${catalog.simplCn}</textarea>
                                </td>
                            </tr>
                            <tr>
                                <th scope="row">
                                    상세내용
                                </th>
                                <td colspan="3">
                                    <textarea name="detlCn" id="detlCn" cols="30" rows="10">${catalog.detlCn}</textarea>
                                </td>
                            </tr>
                            <tr>
                                <th scope="row">
                                    버전정보
                                </th>
                                <td>
                                    <input type="text" name="verInfo" id="verInfo" value="${catalog.verInfo}">
                                </td>
                                <th scope="row">
                                    언어선택
                                </th>
                                <td>
                                    <ul class="inputbox">
                                        <li>
                                            <input type="radio" id="radio01_1" name="langSeCd" <c:if test="${catalog.langSeCd eq 'KO'}">checked</c:if>><label
                                                for="radio01_1">한국어</label>
                                        </li>
                                        <li>
                                            <input type="radio" id="radio01_2" name="langSeCd" <c:if test="${catalog.langSeCd eq 'EN'}">checked</c:if>><label
                                                for="radio01_2">영어</label>
                                        </li>
                                    </ul>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    전화문의
                                </th>
                                <td>
                                    <select name="telMangUsr" id="telMangUsr">
                                        <option value="0">--선택하세요--</option>
                                        <option <c:if test="${catalog.telMangUsrId eq 'M0001'}">selected</c:if> value="">씨그마알드리치 (031-329-9000)</option>
                                    </select>
                                </td>
                                <th>
                                    이메일문의
                                </th>
                                <td>
                                    <select name="emailMangUsr" id="emailMangUsr">
                                    	<option value="0">--선택하세요--</option>
                                        <option <c:if test="${catalog.emailMangUsrId eq 'M0001'}">selected</c:if> value="">씨그마알드리치 (sakr@naver.com)</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    파일 업로드
                                </th>
                                <td colspan="3">
                                    <input type="file">
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <!-- // 작성폼 -->


                <!-- 페이징 + 버튼 -->
                <div class="paging_box">
                    <div class="btn_box">
                        <button type="button" class="btn btn_default" onClick="javascript:switchContent('/admin/catalog/catalog_write');">신규</button>
                        <button type="button" class="btn btn_default" onClick="javascript:fnSave(0);">임시저장</button>
                        <button type="button" class="btn btn_default" onClick="javascript:fnSave(1);">등록</button>
                        <button type="button" class="btn btn_default" onClick="javascript:switchContent('/admin/catalog/catalog_list');">목록으로</button>
                    </div>
                </div>
                <!-- // 페이징 + 버튼 -->

            </div>
            </form:form>
            </c:forEach> 
            <!-- // content -->
			
			<script>
				$(document).ready( function() {
			        //해당 DIV 사이즈 조정
			        var bodyDivHeight = $('#whole_div').height();
			        $('#left_div').css("height",bodyDivHeight+"px");
			 
			        //alert(bodyDivHeight);
			        //alert($('#left_div').height());
			        
			        //$("#left_div").removeClass("lnb_wrap");
			        //$("#left_div").addClass("lnb_wrap");
			        
			        //class="lnb_wrap"
			      });
				
				
				var tag = {${tagArrObj}};
		        var counter = ${keywdValGrpCnt};
				
		        $("#tag").on("keypress", function (e) {
		            var self = $(this);

		            //엔터나 스페이스바 눌렀을때 실행
		            if (e.key === "Enter" || e.keyCode == 32) {

		                var tagValue = self.val(); // 값 가져오기

		                // 해시태그 값 없으면 실행X
		                if ($.trim(tagValue) != "") {

		                    // 같은 태그가 있는지 검사한다. 있다면 해당값이 array 로 return 된다.
		                    var result = Object.values(tag).filter(function (word) {
		                        return word === tagValue;
		                    })
		                
		                    // 해시태그가 중복되었는지 확인
		                    if (result.length == 0) { 
		                        $("#tag-list").append("<li style='float:left;'>"+tagValue+"<span class='del-btn' idx='"+counter+"'> X&nbsp;&nbsp;&nbsp;&nbsp</span></li>");
		                        addTag(tagValue);
		                        self.val("");
		                    } else {
		                    	toastr["warning"]("입력한 키워드가 존재합니다.");
		                    }
		                }
		                e.preventDefault(); // SpaceBar 시 빈공간이 생기지 않도록 방지
		            }
		        });

		        // 삭제 버튼 
		        // 인덱스 검사 후 삭제
		        $(document).on("click", ".del-btn", function (e) {
		            var index = $(this).attr("idx");
		            tag[index] = "";
		            $(this).parent().remove();
		        });
		        
		        // 입력한 값을 태그로 생성한다.
		        function addTag (value) {
		            tag[counter] = value;
		            counter++; // del-btn 의 고유 id 가 된다.
		        }

		        // tag 안에 있는 값을 array type 으로 만들어서 넘긴다.
		        function marginTag () {
		            return Object.values(tag).filter(function (word) {
		                return word !== "";
		            });
		        }
		        
		     	// 카테고리 체크
				//$("input:checkbox[id='checkbox01_1']").prop("checked", true);				
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
		        
				
				fileUtil.fileConfig.push({
					fileId : "",
					fileCheckNum : 1,
					fileCheckType : 1,  //1==isImage , 2==isVideo , 3==isDoc 4==AllFile
					delButtonYn : "Y",		//삭제버튼 유무
					addButtonYn : "Y",		//첨부버튼 유무
					targetId : "fileDiv1",
					screenId : "SAMPLE",
					viewYn : "Y"
				});
			
				fileUtil.fileConfig.push({
					fileId : "",
					fileCheckNum : 1,
					fileCheckType : 4,  //1==isImage , 2==isVideo , 3==isDoc 4==AllFile
					delButtonYn : "Y",		//삭제버튼 유무
					addButtonYn : "Y",		//첨부버튼 유무
					targetId : "fileDiv2",
					screenId : "SAMPLE",
					viewYn : "Y"
				});
			
				fileUtil.fileConfig.push({
					fileId : "",
					fileCheckNum : 1,
					fileCheckType : 4,  //1==isImage , 2==isVideo , 3==isDoc 4==AllFile
					delButtonYn : "Y",		//삭제버튼 유무
					addButtonYn : "Y",		//첨부버튼 유무
					targetId : "fileDiv3",
					screenId : "SAMPLE",
					viewYn : "Y"
				});
			
				fileUtil.fileConfig.push({
					fileId : "",
					fileCheckNum : 1,
					fileCheckType : 4,  //1==isImage , 2==isVideo , 3==isDoc 4==AllFile
					delButtonYn : "Y",		//삭제버튼 유무
					addButtonYn : "Y",		//첨부버튼 유무
					targetId : "fileDiv4",
					screenId : "SAMPLE",
					viewYn : "Y"
				});
			
				fileUtil.fileConfig.push({
					fileId : "",
					fileCheckNum : 10,
					fileCheckType : 4,  //1==isImage , 2==isVideo , 3==isDoc 4==AllFile
					delButtonYn : "Y",		//삭제버튼 유무
					addButtonYn : "Y",		//첨부버튼 유무
					targetId : "fileDiv5",
					screenId : "SAMPLE",
					viewYn : "Y"
				});
				
				fileUtil.init();
				
				//-- 저장 --//
				function fnSave(i){
					
					
					var formData = $("#catalogForm").serializeObject();
					
					var keyWdArr = "";
					for(var x=1; x<=counter; x++){
						keyWdArr += ","+tag[x];
					}
					formData.keywdValGrp = keyWdArr;
					alert(formData.keywdValGrp);
					console.log("## formJson=>>"+JSON.stringify(formData));
					
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
								
								var catgrIdGrp = "";
								$('input:checkbox[name="catgrIdGrp"]').each(function() {

								      //this.checked = true; //checked 처리

								      if(this.checked && this.value != "ALL"){//checked 처리된 항목의 값
								            catgrIdGrp+=","+this.value;
								      }

								 }); 
								formData.catgrIdGrp = catgrIdGrp;
								
								console.log( JSON.stringify(formData) );
													
								$.ajax({
							  	    url: "/admin/catalog/saveCatalog",
							  	    type: "post",
							  	    data: JSON.stringify(formData),
							        contentType: "application/json",
							  	    success: function(rs) {
							  	    	//data = JSON.stringify(data);
							  	    	console.log(JSON.stringify(rs));					    	
							  	    	//grid.setData(rs);
							  	    	var rsCnt = JSON.stringify(rs);
							  	    	toastr["success"](rsCnt+"건 저장 되었습니다.","저장완료.");
							  	    	
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
						};
				
			    </script>
