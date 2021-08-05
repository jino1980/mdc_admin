<%@page import="com.merck.catalog.common.SoftLabHumUtils"%>
<%@page import="com.merck.catalog.admin.vo.TbCab001m"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<%@page import="java.util.*"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%

final String  BOARD_ID = "NOTC00000001"; // 공지게시판

List<Map<String,Object>> boardPostList = new ArrayList();
List<Map<String,Object>> paramList = (List<Map<String,Object>>)request.getAttribute("boardPostList");
List<Map<String,Object>> imgGrpList = (List<Map<String,Object>>)request.getAttribute("imgGrpList");

if( null == paramList || paramList.size() == 0 ) {
	   TbCab001m vo = new TbCab001m();
	   vo.setBoardId(BOARD_ID);
	   boardPostList.add(0, SoftLabHumUtils.converVoToMap(vo));
	   System.out.println("#### SoftLabHumUtils.converVoToMap(vo)=>>>"+SoftLabHumUtils.converVoToMap(vo));
	   
}else{
	   boardPostList = (List<Map<String,Object>>)request.getAttribute("boardPostList");
	   System.out.println("#### boardPostList =>>>"+boardPostList.get(0));
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
                        <a href="#" class="on" class="sel">공지사항 등록</a>
                    </li>
                </ul>
            </div>
            <!-- // header -->

            <!-- content -->
			<c:forEach var="boardPost" items="${boardPostList}">

            <form:form commandName="notcForm" action="#">
            <input type="hidden" id="boardId" name="boardId"  value="${BOARD_ID}"/>
            <input type="hidden" id="postId" name="postId"  value="${boardPost.postId}"/>
            <input type="hidden" id="pushRegNo" name="pushRegNo"  value="${boardPost.pushRegNo}"/>
            
            <input type="hidden" id="taskSe" name="taskSe"  value="NOTC"/>
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
                                            <li>(이미지는 JPG/PNG/GIF 형식의 파일로 3MB이하로 등록이 가능합니다.)</li>
                                        </ul>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th scope="row">
                                    내용
                                </th>
                                <td colspan="3">
                                    <textarea name="cn" calss="required"  id="cn" cols="30" rows="10">${boardPost.cn}</textarea>
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
                                            <input type="text" calss="required"  id="pushBeginDt" name="pushBeginDt" aria-label="Date-Time" value="${boardPost.pushBeginDt}">
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
                        <button type="button" class="btn btn_default" onClick="javascript:switchContent('/admin/board/viewBoardCommon/NOTC00000001/0');">신규</button>
                        <button type="button" class="btn btn_default" onClick="javascript:fnSave(0);">임시저장</button>
                        <button type="button" class="btn btn_default" onClick="javascript:fnSave(1);">등록</button>
                        <button type="button" class="btn btn_default" onClick="javascript:switchContent('/admin/alert/notc_list');">목록으로</button>
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
    <script>
    
	    $(document).ready( function() {
	        $("#input_imgs").on("change", handleImgFileSelect);
	        $("#div_load_image").hide();
	        //$('#progress').hide();
	      });
	    
	    
	    /*** 파일 처리 ************************************************/
	    // 이미지 정보들을 담을 배열
	    var fileIdx = <%=imgGrpList.size()%>;
        var sel_files = [];
        var sel_del_files = []; // 이미지파일 삭제 배열
        
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
        	
        	});

        function handleImgFileSelect(e) {
			
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


        var delImgFileIdx = 0;
        function deleteImageAction(index,fileId) {
            console.log("index : "+index);
            console.log("sel_files : "+sel_files.length);

            sel_files.splice(index, 1);
            if(!isNull(fileId)) sel_del_files[delImgFileIdx++] = fileId;
            
            var img_id = "#img_id_"+index;
            //console.log("## before img remove .. =>>"+$(img_id).html())
            $(img_id).remove(); 
        }

        function submitImgFileAction(postId) {
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
            formData.append( "taskSe" , "NOTC");
            formData.append( "taskSeCd" , "NTC");
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
	    /*** 파일 처리 ************************************************/		
	    
	    
        var datepicker1 = new tui.DatePicker('#wrapper1', {
            date: parseStrToDate('<%=pushBeginDate%>'),            
            input: {
                element: '#pushBeginDt',
                format: 'yyyy-MM-dd HH:mm'
            },
            timePicker: true
        });
        
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
      var boardId = "${BOARD_ID}"; // 공지사항
		function fnSave(idx){
			
			
			var formData = $("#notcForm").serializeObject();
			var pushBeginDt = $("#pushBeginDt").val();
			if( isNull(pushBeginDt) == false ){
				formData.pushBeginDt = (((((pushBeginDt.replace(/-/gi,"")).replace(/:/gi,"")).replace(/ /gi,"")).replace('PM',"")).replace('AM',""));
			}
			
			console.log("## formJson=>>"+JSON.stringify(formData));
			
			// 필수체크
			if(nullCheckAll() == false) return;
			
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
		  	    	
		  	    	var isImgFileUp = false;
		  	    	//alert("### sel_files length =>"+sel_files.length);
		  	    	console.log("### FILE UPLOAD PROCESS START sel_files =>>"+sel_files.length);
		  	    	console.log("### FILE UPLOAD PROCESS START sel_del_files =>>"+sel_del_files.length);
		  	    	
		  	    	if(sel_files.length > 0 || sel_del_files.length > 0 ){
		  	    		isImgFileUp = submitImgFileAction(rs);
		  	    	}else{
		  	    		isImgFileUp = true;
		  	    	}
		  	    	
		  	    	console.log( "@@@ isImgFileUp complete... =>>"+isImgFileUp );
		  	    								  	    	
		  	    	if(isImgFileUp ){
			  	    	toastr["success"]("공지사항 내용 저장 되었습니다.","저장완료.");
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