<%@page import="org.slf4j.Logger"%>
<%@page import="org.slf4j.LoggerFactory"%>
<%@page import="com.merck.catalog.common.SoftLabHumUtils"%>
<%@page import="com.merck.catalog.admin.vo.TbCab002d"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<%@page import="java.util.*"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
final Logger logger = LoggerFactory.getLogger(this.getClass());
final String  BOARD_ID = "HELP00000001"; // 도움말 게시판

List<Map<String,Object>> boardPostList = new ArrayList();
List<Map<String,Object>> paramList = (List<Map<String,Object>>)request.getAttribute("boardPostList");
List<Map<String,Object>> imgGrpList = (List<Map<String,Object>>)request.getAttribute("imgGrpList");

if( null == paramList || paramList.size() == 0 ) {
	   TbCab002d vo = new TbCab002d();
	   vo.setBoardId(BOARD_ID);
	   boardPostList.add(0, SoftLabHumUtils.converVoToMap(vo));
	   imgGrpList = new ArrayList();
	   
	   logger.debug("#### SoftLabHumUtils.converVoToMap(vo)=>>>"+SoftLabHumUtils.converVoToMap(vo));
	   
}else{
	   boardPostList = (List<Map<String,Object>>)request.getAttribute("boardPostList");
	   logger.debug("#### boardPostList =>>>"+boardPostList.get(0));
}

String pushBeginDate = SoftLabHumUtils.nvl( boardPostList.get(0).get("pushBeginDt") );
String pushBeginDtStr = SoftLabHumUtils.nvl( boardPostList.get(0).get("pushBeginDate") );

String imgFileGrpId = "";
if( imgGrpList.size() > 0 ){
	imgFileGrpId = SoftLabHumUtils.nvl( ((Map<String,Object>)imgGrpList.get(0)).get("imgFileGrpId") );
}

request.setAttribute("boardPostList", boardPostList);
request.setAttribute("imgGrpList", imgGrpList);
request.setAttribute("imgFileGrpId", imgFileGrpId);
request.setAttribute("BOARD_ID", BOARD_ID);

%>
        <!-- header -->
            <div class="header">

                <div class="info">
                    <span class="logout"><button type="button" title="로그아웃"></button></span>
                </div>
                <ul class="gnb_menu">
                    <li>
                        <a href="#" class="on" class="sel">도움말 관리</a>
                    </li>
                </ul>
            </div>
            <!-- // header -->

            <!-- content -->
            <div class="content">
                <!-- 타이틀 -->
                <div class="title_box">
                    <h2 class="h2">총 <span id="totCnt"><%=imgGrpList.size()%></span>건</h2>
                </div>
                <!-- // 타이틀 -->

                <!-- 리스트 -->
                <div class="help_list">
                    <ul id="wrap_help_img">
                        
                    	<c:forEach var="boardPost" items="${boardPostList}">
			            <form:form commandName="helpForm" action="#">
			            <input type="hidden" id="boardId" name="boardId"  value="${BOARD_ID}"/>
			            <input type="hidden" id="postId" name="postId"  value="${boardPost.postId}"/>
			            
			            <input type="hidden" id="taskSe" name="taskSe"  value="HELP"/>
			            <input type="hidden" id="taskSeCd" name="taskSeCd"  value="HLP"/>
		                
		                
		                <div id="divHelpImgs">

                        
				                        <!-- 
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
							});
				                        
				            -->
					        <c:forEach var="imgs" items="${imgGrpList}" varStatus="stat">
	                        <li id="img_id_${stat.count}">
					        <input type="file" id="upload_img_id_${stat.count}" name="uploadFiles" style="display:none" onChange="handleImgFileSelect(${stat.count},this.files);" />
	                        <div id="div_${stat.count}" class="dynamicDiv">
	                            <a href="#none" data-name="popup01" id="popup_${stat.count}" class="popup_open">
	                                <img id="helpImg${stat.count}" class="helpImg" src="${imgs.filePath}${imgs.fileNm}.${imgs.fileExt}" data-file='${imgs.fileNm}' width=150 height=200 />
	                            </a>
	                            <div class="btn_box">
	                                <button type="button" class="tb_btn blue" onClick="modify(${stat.count});">수정</button>
	                                <button type="button" class="tb_btn red" onClick="del(${stat.count},'${imgs.imgFileId}');">삭제</button>
	                            </div>
	                        </div>
	                        </li>
	                        </c:forEach>
	            		</div>
                                    
                        </form:form>
            			</c:forEach>
            			
            			<li class="add_file">
		                	<button onClick="addImg();")></button>
		                </li>
                    </ul>
            		
                </div>
                <!-- // 리스트 -->

				<!-- 페이징 + 버튼 -->
                <div class="paging_box">
                    <div class="btn_box">
                        <button type="button" class="btn btn_default" onClick="javascript:fnSave(0);">임시저장</button>
                        <button type="button" class="btn btn_default" onClick="javascript:fnSave(1);">등록</button>
                    </div>
                </div>
                <!-- // 페이징 + 버튼 -->
            </div>
            
            <!-- // content -->

		    <!-- 레이어 팝업 -->
		    <div class="layer_popup" id="popup01" style="display: none;">
		        <div class="popup_wrap type01">
		            <div class="pop_head">
		                <h1 tabindex="0">이미지 미리보기</h1>
		                <button type="button" class="popup_close" title="닫기"></button>
		            </div>
		            <div class="pop_cont">
		                <div class="pop_cont_wrap" style="padding-bottom: 20px; text-align: center;">
		                    <!-- 이미지 -->
		                    <img id="caroselImgView" width=300 height=400 src="http://placehold.it/300x400" />
		                    <!-- // 이미지 -->
		                    <a href="#none" class="prev_btn" onClick="prevImgView(this);"></a>
		                    <a href="#none" class="next_btn" onClick="nextImgView(this);"></a>
		                </div>
		            </div>
		        </div>
		    </div>
		    <!-- // 레이어 팝업 -->
			
			<form id="IMG_FILE_FORM" method="post" enctype="multipart/form-data" action="">
	            <input type="file" id="FILE_TAG" name="FILE_TAG" style="display:none">
	            <input type="file" id="FILE_TAG2" name="FILE_TAG2" style="display:none">
	        </form>
    <script>
    	$(document).ready( function() {
	        //class="lnb_wrap"
	        // $("a[id^='img_id_']").each(function() {
	        //$("input[id^='upload_img_id_']").on("change", handleImgFileSelect);
	        //$('input[type="file"]').on("change", handleImgFileSelect);
    		/*$('input[type="file"]').change(function(e) {
    			alert(1111);
    			console.log("### FILE SELECTING...");
    			alert( $(this).prop('id') );
    			handleImgFileSelect(e);
    	      // alert('The file name is : "' + fileName);
    	      });*/    	
    	});
    	
	    var dragDivId = "";
    	$(document).on('dragenter', '.dynamicDiv', function() {
    		  console.log("동적 추가된 div태그 '"+$(this).attr("id")+"'이 dragenter  되었습니다.");
    		  dragDivId = $(this).attr("id");
    		  
    		  $(this).addClass('drag-over');
    		  
    		}).on("dragleave", function(e) { //드래그 요소가 나갔을때
        	$(this).removeClass('drag-over');
        	}).on("dragover", function(e) {
        	e.stopPropagation();
        	e.preventDefault();
        	}).on('drop', function(e) { //드래그한 항목을 떨어뜨렸을때
        	e.preventDefault();
        	$(this).removeClass('drag-over');
        		
        		var idx = dragDivId.replace("div_","");
        		console.log("동적 추가된 div태그 ('"+dragDivId+"') , idx("+idx+") , handleImgFileSelect 호출전.");
        		handleImgFileSelect(idx,e.originalEvent.dataTransfer.files); 
	                
	            });
	        
    	
	        
    	var imgFileIdx = <%=imgGrpList.size()%>;    	
    	var delImgFileIdx = 0;
    	
    	 var sel_del_files = []; // 이미지파일 삭제 배열
         var img_files_arr = {};
    	
    	// 이미지 파일 핸들러
        function handleImgFileSelect(imgIdx,files) {
			
            // 이미지 정보들을 초기화
            //sel_files = [];
            //$(".imgs_wrap").empty();
			
            //var files;
            var filesArr;
            	
        	//files = e.target.files;
            filesArr = Array.prototype.slice.call(files);
            console.log("### object IDx => "+imgIdx);
            console.log("### filesArr(try) => "+filesArr);

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
                
                var reader = new FileReader();
                reader.onload = function(e) {
                	
                	var imgObj = $("#helpImg"+imgIdx);
                	imgObj.prop("src",e.target.result );
                	imgObj.prop("data-file",f.name );
                	//<img id='helpImg"+imgFileIdx+"' src='${RESOURCES_PATH}/resource/images/150x200.png' width=150 height=200 />";
                	
                	eval("img_files_arr.helpImg"+imgIdx+" = f;");
			        console.log( "### img_files_arr.helpImg"+imgIdx+" = f =>>"+ f.name );
                }
                reader.readAsDataURL(f);
                
            });
            
            //console.log( "### 2222 imgs_wrap DRAWING COMPLETE. =>>"+$(".imgs_wrap").html() );
            console.log( "###  DRAWING COMPLETE.." );
        }
    	
    	// 추가
    	function addImg(){
    		imgFileIdx += 1;
    		
    		//alert("### 이미지 추가 후 처리 ");
    		var html    = "<li id=img_id_"+imgFileIdx+">";
    		    html    +="<input type='file' id='upload_img_id_"+imgFileIdx+"' name='uploadFiles' style='display:none' onChange='handleImgFileSelect("+imgFileIdx+",this.files);' />";
    		    html    +="<div id='div_"+imgFileIdx+"' class='dynamicDiv'>";
    			html    +="<a href='#none' data-name='popup01' id='popup_"+imgFileIdx+"' class='popup_open'>";
    			html    +="      <img id='helpImg"+imgFileIdx+"' class='helpImg' src='${RESOURCES_PATH}/resource/images/150x200.png' width=150 height=200 data-file='150x200' />";
    			html    +="  </a>";
    			html    +="  <div class='btn_box'>";
    			html    +="      <button type='button' class='tb_btn blue' onClick='modify("+imgFileIdx+");'>수정</button>";
    			html    +="      <button type='button' class='tb_btn red' onClick='del("+imgFileIdx+",null);'>삭제</button>";
    			html    +="  </div>";
    			html    +="</div>";
    			html    +="</li>";
    		$("#divHelpImgs").append(html);
    		
    		$("#totCnt").html(imgFileIdx);
    	}
    	
    	var currImgId;
    	function cfnLayoutPopUpCallBack(obj){
			console.log("### cfnLayoutPopUpCallBack=>>"+obj.children('img').prop('id'));
			//console.log("### childern=>>"+ obj.children('img').prop('src'));
			
			$("#caroselImgView").prop("src",obj.children('img').prop('src'));
			currImgId = obj.children('img').prop('id');
		}
    	
    	function prevImgView(obj){
    		console.log("### prevImgView currImgId =>>"+currImgId);
    		
    		var prevImgSrc;
    		var thisTagId;
    		$("img[class='helpImg']").each(function() {
                
    			var tagId = $(this).prop('id');
        		var imgSrc = $(this).prop('src');
				//console.log("@@@ imgSrc =>>"+imgSrc);
        		//console.log("@@@ prevImgView tagId =>>"+tagId);
				if( tagId == currImgId ){
					return false ;
				}
				prevImgSrc = imgSrc;
				thisTagId = tagId;
    		});
    		
    		currImgId = thisTagId;
    		$("#caroselImgView").prop("src",prevImgSrc);
    	}
    	
		function nextImgView(obj){
			console.log("### nextImgView currImgId =>>"+currImgId);
    		
    		var nextImgSrc;
    		var thisTagId;
    		var bfTagId;
    		var bool = true;
    		
    		$("img[class='helpImg']").each(function() {
                
        		var tagId = $(this).prop('id');
        		var imgSrc = $(this).prop('src');
				//console.log("@@@ imgSrc =>>"+imgSrc);
        		
				//console.log("@@@@@ nextImgView tagId =>>"+tagId);
				if( bfTagId == currImgId ){
					nextImgSrc = imgSrc;
					thisTagId = tagId;
					return false;
				}
				bfTagId = tagId;
				
    		});
    		
    		currImgId = thisTagId;
    		$("#caroselImgView").prop("src",nextImgSrc);
		}
		
		
		function modify(imgIdx){
			//alert("img change =>"+imgIdx);
			$("#upload_img_id_"+imgIdx).click();
		}
		function del(imgIdx,fileId){
			//alert("### imgIdx delete =>"+imgIdx);		
			
			//var removeFile = sel_files.splice(index, 1);
            if(!isNull(fileId)) sel_del_files[delImgFileIdx++] = fileId;

            $("#img_id_"+imgIdx).remove(); 
            console.log("@@@ removed file");		            
            //console.log("@@@ after img html =>>> "+$("#divHelpImgs").html());
            
            
            imgFileIdx -= 1;
    		$("#totCnt").html(imgFileIdx);
		}
		
		
		// 이미지 저장
		function submitImgFileAction(postId) {
        	//alert( newCatlgId );

		   var form = $('#IMG_FILE_FORM')[0];
           var formData = new FormData(form);
           var imgFileAttchCnt = 0;
           //alert("TEST.. "+img_files_arr.img_id_0);
           //console.log("@@@ img div html =>>> "+$("#dragDivImg").html());
           
           
        	$("a[class='popup_open']").each(function() {
                imgFileAttchCnt += 1;
        		
        		var tagId = $(this).children('.helpImg').prop('id');
        		var imgSrc = $(this).children('.helpImg').prop('src');
				console.log("@@@ imgSrc =>>"+imgSrc);
        		
        		if( imgSrc.indexOf("/resources") > -1 ) return true; // 이미저장 된 파일 pass
        		
				console.log("@@@ this.id =>>"+$(this).children('.helpImg').prop('id'));
				var f;
				eval("f = img_files_arr."+tagId+";");
				//alert(" looppp... file =>"+f);
				
	            if(imgFileAttchCnt > 20){
            		alert("파일첨부는 최대 20개 까지 가능합니다.");
            		return false;
            	}
	            
	            var maxSize = (3 * 1024 * 1024) * 10 ; // 30 MB
            	var fileSize = f.size;
            	if(fileSize > maxSize){
            		alert("첨부파일 총 사이즈는 30 MB 이내로 등록 가능합니다.");
            		return false;
            	}
                
            	console.log("## fileFormData append {} , {} => ",name,f.name);		  
                
                formData.append("uploadFiles",f);
	            
			  });
        	
            console.log("IMG 업로드 파일 갯수 : "+imgFileAttchCnt);
            console.log("IMG 파일 삭제 갯수 : "+sel_del_files.length);
            
            if( imgFileAttchCnt == 0 && sel_del_files.length == 0 ) return true;
        	
            formData.append( "taskSe" , "HELP");
            formData.append( "taskSeCd" , "HLP");
            formData.append( "attchType" , "IMG");
            formData.append( "boardId" , boardId);
            formData.append( "postId" , postId);
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
	            	    toastr["success"]((imgFileAttchCnt+sel_del_files.length)+"건 업로드 되었습니다.","이미지 파일 업로드 완료.");
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
		
		//-- 저장 --//
	      var boardId = "${BOARD_ID}"; // 도움말
			function fnSave(idx){
				
				
				var formData = $("#helpForm").serializeObject();
				formData.title = "도움말 관리_"+boardId;
				
				console.log("## formJson=>>"+JSON.stringify(formData));
				
				if( idx == 0 ) {
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
			  	    	
			  	    	console.log("### FILE UPLOAD PROCESS START ");
			  	    	
			  	    	var isImgFileUp = submitImgFileAction(rs);
			  	    	
			  	    	console.log( "@@@ isImgFileUp complete... =>>"+isImgFileUp );
			  	    								  	    	
			  	    	if(isImgFileUp ){
				  	    	toastr["success"]("도움말 저장 되었습니다.","저장완료.");
				  	    	switchContent('/admin/board/viewBoardCommon/${BOARD_ID}/'+rs);
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