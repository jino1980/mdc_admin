	<%@page import="com.merck.catalog.common.SoftLabHumUtils"%>
<%@page import="com.merck.catalog.admin.vo.TbCaa001m"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<%@page import="java.util.*"%>
<%
	
	//System.out.println("#### CATALOG_WRITE JSP...");

   List<Map<String,Object>> catalogList = new ArrayList();
   List<Map<String,Object>> paramList = (List<Map<String,Object>>)request.getAttribute("catalogList");
   List<Map<String,Object>> categoryCmmnCdList = (List<Map<String,Object>>)request.getAttribute("categoryCmmnCdList");
   
   List<Map<String,Object>> qnaManagerListTel = (List<Map<String,Object>>)request.getAttribute("qnaManagerList");
   List<Map<String,Object>> qnaManagerListEmail = (List<Map<String,Object>>)request.getAttribute("qnaManagerList");
   
   List<Map<String,Object>> imgGrpList = (List<Map<String,Object>>)request.getAttribute("imgGrpList");
   List<Map<String,Object>> catalogGrpList = (List<Map<String,Object>>)request.getAttribute("catalogGrpList");
   
   if( null == paramList || paramList.size() == 0 ) {
	   TbCaa001m vo = new TbCaa001m();
	   catalogList.add(0, SoftLabHumUtils.converVoToMap(vo));
	   //System.out.println("#### SoftLabHumUtils.converVoToMap(vo)=>>>"+SoftLabHumUtils.converVoToMap(vo));
	   
	   request.setAttribute("catalogList", catalogList);
	   
   }else{
	   catalogList = (List<Map<String,Object>>)request.getAttribute("catalogList");
	   System.out.println("#### catalogList =>>>"+catalogList.get(0));
   }
   
   String imgFileGrpId = "";
   String catlgFileGrpId = "";
		   
   if( imgGrpList.size() > 0 )     imgFileGrpId = SoftLabHumUtils.nvl( ((Map<String,Object>)imgGrpList.get(0)).get("imgFileGrpId") );
   if( catalogGrpList.size() > 0 ) catlgFileGrpId = SoftLabHumUtils.nvl( ((Map<String,Object>)catalogGrpList.get(0)).get("catlgFileGrpId") );
   
   request.setAttribute("categoryCmmnCdList", categoryCmmnCdList);
   
   request.setAttribute("qnaManagerListTel", qnaManagerListTel);
   request.setAttribute("qnaManagerListEmail", qnaManagerListEmail);
   
   request.setAttribute("imgGrpList", imgGrpList);
   request.setAttribute("catalogGrpList", catalogGrpList);   
   request.setAttribute("imgFileGrpId", imgFileGrpId);
   request.setAttribute("catlgFileGrpId", catlgFileGrpId);
   
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
                                                       
                                                       <!-- 첨부파일(이미지파일만 업로드가능) -->
														<div class="input_wrap">
												            <input type="file" id="input_imgs" multiple/>
												        </div>
														<!-- 이미지 미리보기 영역 -->
														<div id="dragDiv" class="imgs_wrap">
														
																<c:forEach var="imgs" items="${imgGrpList}" varStatus="stat">
					                                        	
																<a href="javascript:void(0);" onclick="deleteImageAction('${stat.count}','${imgs.imgFileId}')" id="img_id_${stat.count}"><img src="${imgs.filePath}${imgs.fileNm}.${imgs.fileExt}" data-file='${imgs.fileNm}' class='selProductFile' title='Click to remove'></a>
													            
																</c:forEach>
													    </div>
                                                </div>
                                            </li>
                                        </ul>
                                        <ul class="bullet mark mt5">
                                            <li><b>첫번째 이미지는 <span class="color_red">대표이미지로</span> 등록됩니다.</b> (이미지는 JPG/PNG/GIF 형식의 파일로 3MB이하로 등록이 가능합니다.)</li>
                                        </ul>
                                        <!-- Bootstrap Progress bar -->
									    <div id="progress" class="progress" >
									      <div id="progressBar" class="progress-bar progress-bar-success" role="progressbar"
									        aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width: 0%">0%</div>
									    </div>
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
                                            <input type="checkbox" id="checkbox01_1" name="catgrIdGrp" onchange="chkValidCate(this);" value="" <c:if test="${empty catalog.catgrIdGrp}">checked</c:if>><label
                                                for="checkbox01_1">전체</label>
                                        </li>
                                        
                                        	<c:set var="catgrIdGrp" value="${catalog.catgrIdGrp}" />
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
                                    검색어
                                </th>
                                <td colspan="3">
                                	<c:set var="keywdValGrp" value="${catalog.keywdValGrp}" />
                                	<%
                                	
                                   		String keywdValGrp = (String)pageContext.getAttribute("keywdValGrp")+"";
                                   		String[] keywdValGrpArr = keywdValGrp.split(",");
                                   		
                                   		String keywdValGrpHTML = "";
                                   		String tagArrObj = "";
                                   		for(int i=1; (null!=keywdValGrpArr && i< keywdValGrpArr.length ); i++){ 
                                   			keywdValGrpHTML += "<li style='float:left;'>"+keywdValGrpArr[i]+"<span class='del-btn' idx='"+(i)+"'> X&nbsp;&nbsp;&nbsp;&nbsp</span></li>";
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
							            	<input type="text" id="tag" size="7" placeholder="엔터로 키워드를 등록해주세요." style="width: 300px;"/>
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
                                            <input type="radio" id="langSeCd" name="langSeCd" value="KR" checked <c:if test="${catalog.langSeCd eq 'KR'}">checked</c:if>><label
                                                for="radio01_1">한국어</label>
                                        </li>
                                        <li>
                                            <input type="radio" id="langSeCd" name="langSeCd" value="EN" <c:if test="${catalog.langSeCd eq 'EN'}">checked</c:if>><label
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
                                    <select name="telMangUsrId" id="telMangUsrId">
                                        <option value="">--선택하세요--</option>
                                        <c:forEach var="qnaManagerTel" items="${qnaManagerListTel}">
                                        <option <c:if test="${catalog.telMangUsrId eq qnaManagerTel.mangRegNo}">selected</c:if> value="${qnaManagerTel.mangRegNo}">${qnaManagerTel.mangUsrNm} (${qnaManagerTel.compTelNo})</option>
                                        </c:forEach>
                                    </select>
                                </td>
                                <th>
                                    이메일문의
                                </th>
                                <td>
                                    <select name="emailMangUsrId" id="emailMangUsrId">
                                    	<option value="">--선택하세요--</option>
                                        <c:forEach var="qnaManagerEmail" items="${qnaManagerListEmail}">
                                        <option <c:if test="${catalog.telMangUsrId eq qnaManagerEmail.mangRegNo}">selected</c:if> value="${qnaManagerEmail.mangRegNo}">${qnaManagerEmail.mangUsrNm} (${qnaManagerEmail.emailAddr})</option>
                                        </c:forEach>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    파일 업로드
                                </th>
                                <td colspan="3"><b>파일 업로드시 <span class="color_red">PDF 파일만</span> 선택 할 수 있습니다.</b>
                                    <!-- 첨부파일(PDF만 업로드가능) -->
									<div class="input_wrap">
							            <input type="file" id="input_pdfs" multiple accept=".pdf" />
							        </div>
									<!-- pdf file 영역 -->
									<ul class="inputbox">
									<div id="dragDiv" class="pdf_wrap">
											
											<c:forEach var="pdfs" items="${catalogGrpList}" varStatus="stat">
                                        		<li>                                        	
												<div id="pdf_id_${stat.count}"><a href="javascript:void(0);" onclick="deletePdfFileAction('${stat.count}','${pdfs.catlgFileId}')"><img src="${RESOURCES_PATH}/resource/images/remove_ico.png" width=16 height=16 ></a>  <a href="./file/download/CAA/${catalog.catlgId}/${pdfs.catlgFileId}" target="_self"> ${pdfs.fileNm}</a></div>
								            	</li>
											</c:forEach>
											
								    </div>
								    </ul>
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
			
			<form id="IMG_FILE_FORM" method="post" enctype="multipart/form-data" action="">
	            <input type="file" id="FILE_TAG" name="FILE_TAG" style="display:none">
	            <input type="file" id="FILE_TAG2" name="FILE_TAG2" style="display:none">
	        </form>
	        
	        <form id="PDF_FILE_FORM" method="post" enctype="multipart/form-data" action="">
	            <input type="file" id="FILE_TAG" name="FILE_TAG" style="display:none">
	            <input type="file" id="FILE_TAG2" name="FILE_TAG2" style="display:none">
	        </form>

			<script>
			
				$(document).ready( function() {
			        //class="lnb_wrap"
			        $("#input_imgs").on("change", handleImgFileSelect);
			        $("#input_pdfs").on("change", handlePdfFileSelect);
			        
			        $("#div_load_image").hide();
			        $('#progress').hide();
			      });
				
		        /*** 파일 처리 ************************************************/
			    // 이미지 정보들을 담을 배열
			    var fileIdx = <%=imgGrpList.size()%>;
			    var pdfFileIdx = <%=catalogGrpList.size()%>;
		        var sel_files = []; // 이미지파일 배열
		        var pdf_files = []; //카달로그 파일 배열
		        
		        var sel_del_files = []; // 이미지파일 삭제 배열
		        var pdf_del_files = []; //카달로그 파일 삭제 배열
		        
		        var $drop = $("#dragDiv");
		        $drop.on("dragenter", function(e) { //드래그 요소가 들어왔을떄
		        	$(this).addClass('drag-over');
		        	}).on("dragleave", function(e) { //드래그 요소가 나갔을때
		        	$(this).removeClass('drag-over');
		        	}).on("dragover", function(e) {
		        	e.stopPropagation();
		        	e.preventDefault();
		        	}).on('drop', function(e) { //드래그한 항목을 떨어뜨렸을때
		        	e.preventDefault();
		        	$(this).removeClass('drag-over');
		        		//handleImgFileSelect(e);
		        		
						// 이미지 정보들을 초기화
			            //sel_files = [];
			            //$(".imgs_wrap").empty();
						
			            var files;
			            var filesArr;
			            	
			            	files = e.originalEvent.dataTransfer.files; //드래그&드랍 항목
			            	filesArr = Array.prototype.slice.call(files);
				            console.log("### filesArr(catch) => "+filesArr);
			            
			            filesArr.forEach(function(f) {
			                if(!f.type.match("image.*")) {
			                    toastr["warning"]("확장자는 이미지 확장자만 가능합니다.");
			                    return;
			                }
							
			                var maxSize = 3 * 1024 * 1024; // 3MB
			            	var fileSize = f.size;
			            	if(fileSize > maxSize){
			            		toastr["warning"]("첨부파일 사이즈는 3MB 이내로 등록 가능합니다.");
			            		//f.val("");
			            		return false;
			            	}
			            	
			                sel_files.push(f);
			
			                var reader = new FileReader();
			                reader.onload = function(e) {
			                    var html = "<a href=\"javascript:void(0);\" onclick=\"deleteImageAction("+fileIdx+",'')\" id=\"img_id_"+fileIdx+"\"><img src=\"" + e.target.result + "\" data-file='"+f.name+"' class='selProductFile' title='Click to remove'></a>";
			                    $(".imgs_wrap").append(html);
			                    fileIdx++;
			
			                }
			                reader.readAsDataURL(f);
			                
			            });
		        		
		        	});
				
		        // 이미지 파일 핸들러
		        function handleImgFileSelect(e) {
		
		            // 이미지 정보들을 초기화
		            //sel_files = [];
		            //$(".imgs_wrap").empty();
					
		            var files;
		            var filesArr;
		            	
	            	files = e.target.files;
		            filesArr = Array.prototype.slice.call(files);
		            console.log("### filesArr(try) => "+filesArr);
		
		            var index = 0;
		            filesArr.forEach(function(f) {
		                if(!f.type.match("image.*")) {
		                	toastr["warning"]("확장자는 이미지 확장자만 가능합니다.");
		                    return false;
		                }
						
		                var maxSize = 3 * 1024 * 1024; // 3MB
		            	var fileSize = f.size;
		            	if(fileSize > maxSize){
		            		toastr["warning"]("첨부파일 사이즈는 3MB 이내로 등록 가능합니다.");
		            		//f.val("");
		            		return false;
		            	}
		                
		                sel_files.push(f);
		
		                var reader = new FileReader();
		                reader.onload = function(e) {
		                	var html = "<a href=\"javascript:void(0);\" onclick=\"deleteImageAction("+fileIdx+",'')\" id=\"img_id_"+fileIdx+"\"><img src=\"" + e.target.result + "\" data-file='"+f.name+"' class='selProductFile' title='Click to remove'></a>";
		                    $(".imgs_wrap").append(html);
		                    fileIdx++;
		
		                }
		                reader.readAsDataURL(f);
		                
		            });
		        }
		     	// 카달로그 파일 핸들러
		        function handlePdfFileSelect(e) {
		
		            // 이미지 정보들을 초기화
		            //sel_files = [];
		            //$(".imgs_wrap").empty();
					
		            var files;
		            var filesArr;
		            	
	            	files = e.target.files;
		            filesArr = Array.prototype.slice.call(files);
		            console.log("### pdf filesArr(try) => "+filesArr);
		
		            var index = 0;
		            filesArr.forEach(function(f) {
		                
		                var maxSize = 10 * 1024 * 1024; // 10MB
		            	var fileSize = f.size;
		            	if(fileSize > maxSize){
		            		toastr["warning"]("첨부파일 당 사이즈는 10MB 이내로 등록 가능합니다.");
		            		//f.val("");
		            		return false;
		            	}
		                
		                pdf_files.push(f);
		
		                var reader = new FileReader();
		                reader.onload = function(e) {
		                	var html = "<li>";
		                	    html+= "<div id=\"pdf_id_"+pdfFileIdx+"\"><a href=\"javascript:void(0);\" onclick=\"deletePdfFileAction("+pdfFileIdx+",'')\"><img src='${RESOURCES_PATH}/resource/images/remove_ico.png' width=16 height=16 title='Click to remove'></a> "+f.name+"</div>";
		                	    html+= "</li>"
		                	    ;
		                    $(".pdf_wrap").append(html);
		                    pdfFileIdx++;
		
		                }
		                reader.readAsDataURL(f);
		                
		            });
		        }
				
		     	var delImgFileIdx = 0;
		        function deleteImageAction(index,fileId) {
		            console.log("index : "+index);
		            console.log("sel length : "+sel_files.length);
		
		            sel_files.splice(index, 1);
		            if(!isNull(fileId)) sel_del_files[delImgFileIdx++] = fileId;
		            
		            var img_id = "#img_id_"+index;
		            //console.log("## before img remove .. =>>"+$(img_id).html())
		            $(img_id).remove(); 
		        }
		        
		        var delPdfFileIdx = 0;
		        function deletePdfFileAction(index,fileId) {
		            console.log("index : "+index);
		            console.log("pdf length : "+pdf_files.length);
		
		            pdf_files.splice(index, 1);
		            if(!isNull(fileId)) pdf_del_files[delPdfFileIdx++] = fileId;
		            
		            var pdf_id = "#pdf_id_"+index;
		            //console.log("## before img remove .. =>>"+$(img_id).html())
		            $(pdf_id).remove(); 
		        }
		        
		        		
		        function submitImgFileAction(newCatlgId) {
		        	//alert( newCatlgId );
		            console.log("IMG 업로드 파일 갯수 : "+sel_files.length);
		            console.log("IMG 파일 삭제 갯수 : "+sel_del_files.length);
		            //alert($('form')[0].id);alert($('form')[1].id);
		           var form = $('#IMG_FILE_FORM')[0];
		           var formData = new FormData(form);
		            
		            if(sel_files.length > 10){
	            		alert("파일첨부는 최대 10개 까지 가능합니다.");
	            		//f.val("");
	            		return false;
	            	}
		            
		            var fArr = {};
		            for(var i=0, len=sel_files.length; i<len; i++) {
		                var name = "image_"+i;
		                
		                var f = sel_files[i];
		                var maxSize = (3 * 1024 * 1024) * 10 ; // 30 MB
		            	var fileSize = f.size;
		            	if(fileSize > maxSize){
		            		alert["warning"]("첨부파일 총 사이즈는 30 MB 이내로 등록 가능합니다.");
		            		return false;
		            	}
		                console.log("## fileFormData append {} , {} => ",name,f.name);
		                //fArr  += '"'+name+'" : '"'+f+'"';		                
		                //eval('fArr.'+name+' = '+f);
		                formData.append("uploadFiles",f);
		            }		            
		            //fileFormData.uploadFiles = fArr;
		            //formData.append( "image_count" , sel_files.length);
		            formData.append( "taskSe" , "CATA");
		            formData.append( "taskSeCd" , "CAA");
		            formData.append( "attchType" , "IMG");
		            formData.append( "catlgId" , newCatlgId);
		            formData.append( "fileGrpId" , "<%=imgFileGrpId%>");
		            formData.append( "imgFileGrpId" , "<%=imgFileGrpId%>");
		            formData.append( "delFileIds" , (sel_del_files.length>0?sel_del_files:""));
		            
		            //console.log("## fileFormData => {} " , formData);
		            console.log("## fileFormData JSON =>  " , JSON.stringify(formData));
		            
			         // Ajax call for file uploaling
			         $("#div_load_image").show();
			            var ajaxReq = $.ajax({
			              url : '/file/upload/multi',			              
			              processData: false,
                          contentType: false,
                          data: formData,
                          type: 'POST',
                          async: false,
			    	      
			              success: function(rs) {
					  	    	//data = JSON.stringify(data);
					  	    	//console.log("### upload done! =>>"+rs);				alert( rs );	    	
					  	    	//grid.setData(rs);							  	    	
					  	    	toastr["success"]((sel_files.length+sel_del_files.length)+"건 업로드 되었습니다.","이미지 파일 업로드 완료.");
					  	    	$("#div_load_image").hide();
					  	    	return true;
					  	    },
					  	    error: function (xhr, status, error) {
					  	    	$("#div_load_image").hide();
					  	    	alert("error=>>"+error);
					  	    	
					  	    	return false;
					  	    }
			            });
			            
			            return true;
		
		        }
		        
		        // 카달로그 저장
		        function submitPdfFileAction(newCatlgId) {
		        	//alert( newCatlgId );
		            console.log("## PDF 업로드 파일 갯수 : "+pdf_files.length);
		            console.log("## PDF 파일 삭제 갯수 : "+pdf_del_files.length);
		            //alert($('form')[0].id);alert($('form')[1].id);
		           var form = $('#PDF_FILE_FORM')[0];
		           var formData = new FormData(form);
		            
		            if(pdf_files.length > 10){
	            		alert("파일첨부는 최대 10개 까지 가능합니다.");
	            		//f.val("");
	            		return false;
	            	}
		            
		            var fArr = {};
		            for(var i=0, len=pdf_files.length; i<len; i++) {
		                var name = "image_"+i;
		                
		                var f = pdf_files[i];
		                var maxSize = (3 * 1024 * 1024) * 10 ; // 30 MB
		            	var fileSize = f.size;
		            	if(fileSize > maxSize){
		            		alert("첨부파일 총 사이즈는 30 MB 이내로 등록 가능합니다.");
		            		return false;
		            	}
		                console.log("## fileFormData append {} , {} => ",name,f.name);
		                //fArr  += '"'+name+'" : '"'+f+'"';		                
		                //eval('fArr.'+name+' = '+f);
		                formData.append("uploadFiles",f);
		            }		            
		            
		            formData.append( "taskSe" , "CATA");
		            formData.append( "taskSeCd" , "CAA");
		            formData.append( "attchType" , "PDF");
		            formData.append( "catlgId" , newCatlgId);
		            formData.append( "fileGrpId" , "<%=catlgFileGrpId%>");
		            formData.append( "catlgFileGrpId" , "<%=catlgFileGrpId%>");
		            formData.append( "delFileIds" ,  (pdf_del_files.length>0?pdf_del_files:""));
		            
		            //console.log("## fileFormData => {} " , formData);
		            console.log("## PDF fileFormData JSON =>  " , JSON.stringify(formData));
		            
			         // Ajax call for file uploaling
			         $("#div_load_image").show();
			            var ajaxReq = $.ajax({
			              url : '/file/upload/multi',			              
			              processData: false,
                          contentType: false,
                          data: formData,
                          type: 'POST',
                          async: false,
                          
			              success: function(rs) {
					  	    	
			            	    toastr["success"]((pdf_files.length+pdf_del_files.length)+"건 업로드 되었습니다.","카달로그 PDF 파일 업로드 완료.");
					  	    	$("#div_load_image").hide();
					  	    	
					  	    	return true;
					  	    },
					  	    error: function (xhr, status, error) {
					  	    	$("#div_load_image").hide();
					  	    	alert("error=>>"+error);
					  	    	
					  	    	return false;
					  	    }
			            });
			            
			            return true;
		
		        }
			    /*** 파일 처리 ************************************************/			        
			        
				
				var tag = {${tagArrObj}};
		        var counter = ${keywdValGrpCnt};
				console.log("#tag=>>"+tag);
				console.log("#counter=>>"+counter);
				
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
		                        $("#tag-list").append("<li style='float:left;'>"+tagValue+"<span class='del-btn' idx='"+(++counter)+"'> X&nbsp;&nbsp;&nbsp;&nbsp</span></li>");
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
		            console.log("#addTag=>> tag["+counter+"] = '"+value+"'");
		            //++counter; // del-btn 의 고유 id 가 된다.
		        }

		        // tag 안에 있는 값을 array type 으로 만들어서 넘긴다.
		        function marginTag () {
		            return Object.values(tag).filter(function (word) {
		                return word !== "";
		            });
		        }
		        
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
		        
								
				//-- 저장 --//
				function fnSave(idx){
					
					$("#div_load_image").show();
					var formData = $("#catalogForm").serializeObject();
					
					var keyWdArr = "";
					for(var x=1; x<=counter; x++){
						if( nvl(tag[x],'') != '' ) keyWdArr += ","+tag[x];
					}
					formData.keywdValGrp = keyWdArr;
					//alert(formData.keywdValGrp);
					console.log("## formJson=>>"+JSON.stringify(formData));
					
					// 필수체크
					if( nullCheckAll() == false) return false;
					
					if( idx==0 ){
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
					var catgrIdGrp = "";
					$('input:checkbox[name="catgrIdGrp"]').each(function() {

					      //this.checked = true; //checked 처리

					      if(this.checked && this.value != "ALL"){//checked 처리된 항목의 값
					            catgrIdGrp+=","+this.value;
					      }

					 }); 
					formData.catgrIdGrp = catgrIdGrp;
					
					console.log( JSON.stringify(formData) );
					
					$("#div_load_image").show();
					$.ajax({
				  	    url: "/admin/catalog/saveCatalog",
				  	    type: "post",
				  	    data: JSON.stringify(formData),
				        contentType: "application/json",
				  	    success: function(rs) {
				  	    	console.log("### saveCatalog=>>"+rs);					    	
				  	    	
				  	    	var isImgFileUp = false;
				  	    	var isPdfFileUp = false;
				  	    	//alert("### sel_files length =>"+sel_files.length);
				  	    	console.log("### FILE UPLOAD PROCESS START sel_files =>>"+sel_files.length);
				  	    	console.log("### FILE UPLOAD PROCESS START sel_del_files =>>"+sel_del_files.length);
				  	    	console.log("### FILE UPLOAD PROCESS START pdf_files =>>"+pdf_files.length);
				  	    	console.log("### FILE UPLOAD PROCESS START pdf_del_files =>>"+pdf_del_files.length);
				  	    	
				  	    	if(sel_files.length > 0 || sel_del_files.length > 0 ){
				  	    		isImgFileUp = submitImgFileAction(rs);
				  	    	}else{
				  	    		isImgFileUp = true;
				  	    	}
				  	    	if(pdf_files.length > 0 || pdf_del_files.length > 0 ){
				  	    		isPdfFileUp = submitPdfFileAction(rs);
				  	    	}else{
				  	    		isPdfFileUp = true;
				  	    	}
				  	    	
				  	    	console.log( "@@@ isImgFileUp complete... =>>"+isImgFileUp );
				  	    	console.log( "@@@ isPdfFileUp complete... =>>"+isPdfFileUp );
				  	    								  	    	
				  	    	if(isImgFileUp && isPdfFileUp){
					  	    	toastr["success"]("카달로그 내용이 저장 되었습니다.","카달로그 저장완료.");
				  	    		switchContent('/admin/catalog/viewCatalog/'+rs);
				  	    	}
				  	    	$("#div_load_image").hide();
											  	    	
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
