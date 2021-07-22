var	 fileUtil = {

	scriptVersion : "",
	fileConfig : [],

	//----------------------------
	// InfoFileUtil 객체
	//----------------------------
	init: function() {
		this.before();
		this.bind();
		this.afterBind();
	},

	before: function() {

	},

	bind: function() {
		for(var i in fileUtil.fileConfig){
			if(fileUtil.fileConfig[i].addButtonYn != 'Y'){
				$("#"+fileUtil.fileConfig[i].targetId).css("background","#fafafa");
			}
		}
	},

	afterBind: function() {
		fileUtil.fn.detectIE();
		for(var i in fileUtil.fileConfig){
			fileUtil.fn.fileForm(fileUtil.fileConfig[i].targetId);
		}

		$(".dragAndDropDiv").on( {
			"dragenter" : function(e){
	            e.stopPropagation();
	            e.preventDefault();
			},
			"dragover" : function(e){
	            e.stopPropagation();
	            e.preventDefault();
			},
			"drop" : function(e){
	            e.stopPropagation();
	            e.preventDefault();
				
				var fileConfigInfo = fileUtil.fn.getfileConfigInfo(e.currentTarget.id);

				if(fileConfigInfo.addButtonYn == 'Y'){
					var files = fileUtil.fn.fileGet(e);
					fileUtil.fn.setFileInput(files, fileConfigInfo.targetId);
				}
			},
		});
	},

	// ----------------------------------
	// 처리 메서드가 정의된 객체
	// ----------------------------------
	fn: {
		
		getfileConfigInfo : function(targetId){
			for(var i in fileUtil.fileConfig){
				if(fileUtil.fileConfig[i].targetId == targetId){
					return fileUtil.fileConfig[i];
				}
			}
		},

		detectIE : function(){
			var agent = navigator.userAgent.toLowerCase();
			var rv = -1; // Return value assumes failure.
			if ( (navigator.appName == 'Netscape' && navigator.userAgent.search('Trident') != -1) || (agent.indexOf("msie") != -1) ) {
			//alert("인터넷 익스플로러 브라우저 입니다.");
	         if (navigator.appName == 'Microsoft Internet Explorer') {
	              var ua = navigator.userAgent;
	              var re = new RegExp("MSIE ([0-9]{1,}[\.0-9]{0,})");
	              if (re.exec(ua) != null)
	                  rv = parseFloat(RegExp.$1);
             }
			}
			if(rv == '8' || rv == '9'){
				fileUtil.scriptVersion = rv;
			}else{
				fileUtil.scriptVersion = rv;
			}
		},
		
		//파일수
		getFileCnt : function(targetId){
			var count = 0;
			
			$("#"+targetId +" #fileList"+" :input[id=fileChk]").each(function(index) {
				if($(this).val() != 2){
					count++;
				}
			});
			
			return count;
		},

		//한 번에 업로드하는 파일 숫자ex)드래그
		fileNumCheck : function(files, num, targetId){
			
			var count = fileUtil.fn.getFileCnt(targetId);
			
			if(files.length > num || count+1 > num || count + files.length > num){
				alert("업로드 가능 파일 수는 " + num + "개 입니다.");
				return false;
			}
		},

		//파일 얻기
		fileGet : function(e){
			var files = e.originalEvent.dataTransfer.files;
			return files;
		},

		fileForm : function(targetId){
			var fileConfigInfo = fileUtil.fn.getfileConfigInfo(targetId);
			var input ='';
			if(fileConfigInfo.viewYn == 'Y'){
				//fileConfigInfo.fileCheckNum = 1;
				fileConfigInfo.fileCheckType = 1;
			}
			input += '<form id="frm" method="post" enctype="multipart/form-data">';
			if(fileConfigInfo.addButtonYn == "Y"){
				input += '<div id="divFake" style="position: relative; left:2px; width: 99px;height:30px; overflow:hidden; float:left; margin-bottom: 5px;">';
				input += '<input type="button" id="getFileButton" value="찾아보기">';
				/*input += '<img src="/images/getFileButton.jpg" alt="찾아보기" id="getFileButton"/>';*/
				input += '<input id="attach_file" name="file" multiple type="file" style="font-size: 23px; position: absolute;right:0px;top:0px; opacity:0; filter: alpha(opacity=0);cursor: pointer;" onchange="fileUtil.fn.setFileInput02(this, \''+targetId+'\');"/>';
				input += '</div>';
			}
			input += '</form>';
			if(fileUtil.scriptVersion == '8' || fileUtil.scriptVersion == '9'){
				input +='<div class="fileTitle"><span>File Name</span><span>File Size</span></div><div id="fileList" class="fileList"></div>';
				$("#"+targetId).hide();
				$("#"+targetId).after(input);
			}else{
				input +='<div class="fileTitle"><span>File Name</span><span>File Size</span></div><div id="fileList" class="fileList"></div>';
				$("#"+targetId).append(input);
			}
		},

		fileFormReset : function(targetId){
			$("#"+targetId+" #divFake").empty();
			var input ='';
			input += '<input type="button" id="getFileButton" value="찾아보기">';
			/*input += '<img src="/images/getFileButton.jpg" alt="찾아보기" id="getFileButton"/>';*/
			input += '<input id="attach_file" multiple name="file" type="file" style="font-size: 23px; position: absolute;right:0px;top:0px; opacity:0; filter: alpha(opacity=0);cursor: pointer;" onchange="fileUtil.fn.setFileInput02(this, \''+targetId+'\');"/>';
			$("#"+targetId+" #divFake").html(input);
		},

		selectFiles:function(targetId){
			//ie8 ie9일 때만 파일 브라우져 활성
			if(fileUtil.scriptVersion == '8' || fileUtil.scriptVersion == '9'){
				$('#'+targetId+' #attach_file').trigger('click');
			}else{
				return false;
			}
		},

		setFileInput : function(files, targetId){
			
			var fileConfigInfo = fileUtil.fn.getfileConfigInfo(targetId);
			
			/**2이상으로 해서 테스트 */
			if(fileConfigInfo.fileCheckNum > 0){
				if(fileUtil.fn.fileNumCheck(files, fileConfigInfo.fileCheckNum, targetId) == false){
					return;
				};
			};
			//파일 확장자체크
			var getExtension = fileUtil.fn.getExtension02(files);
			// 1==isImage , 2==isVideo , 3==isDoc 4==AllFile
			if(fileUtil.fn.extensionCheck(fileConfigInfo.fileCheckType, getExtension) == false){
				alert("업로드 가능한 확장자가 아닙니다.");
				return false;
			};
			
			//var fd = fileUtil.fn.sendFileToForm(files);
			//var fileList = fileUtil.fn.sendFileToServer(fd, "/FileUpload.do", fileConfigInfo);
			fileUtil.fn.drawFileList(files, targetId);
		},

		setFileInput02 : function(files, targetId){
			
			var fileConfigInfo = fileUtil.fn.getfileConfigInfo(targetId);
			
			var filePath = files.value;
			var fileName = filePath.substring(filePath.lastIndexOf("\\")+1);
			var getExtension =  fileUtil.fn.getExtension(fileName);
			
			if(filePath != ""){
				/**2이상으로 해서 테스트 */
				if(fileConfigInfo.fileCheckNum > 0){
					if(fileUtil.fn.fileNumCheck(files.files, fileConfigInfo.fileCheckNum, targetId) == false){
						fileUtil.fn.fileFormReset(targetId);
						return false;
					};
				};
				
				// 1==isImage , 2==isVideo , 3==isDoc  , 4==AllFile
				if(fileUtil.fn.extensionCheck(fileConfigInfo.fileCheckType, getExtension) == false){
					alert("업로드 가능한 확장자가 아닙니다.");
					fileUtil.fn.fileFormReset(targetId);
					return false;
				};
				
				
				// file size 
				var maxSize  = 30 * 1024 * 1024    //30MB
				var fileSize = 0;
				
				// 브라우저 확인
				var browser=navigator.appName;
				
				// 익스플로러일 경우
				if (browser=="Microsoft Internet Explorer")
				{
					var oas = new ActiveXObject("Scripting.FileSystemObject");
					fileSize = oas.getFile( files.value ).size;
				}
				// 익스플로러가 아닐경우
				else
				{
					fileSize = files.files[0].size;
				}
				
				if(fileSize > maxSize)
				{
					alert("파일 사이즈는 10MB 이내로 가능합니다.");
					return;
				}
				
				//var fd = fileUtil.fn.sendFileToForm(files.files);
				//var fileList = fileUtil.fn.sendFileToServer(fd, "/FileUpload.do", fileConfigInfo);
				fileUtil.fn.drawFileList(files.files, targetId);
			}
		},


		/** FormData 생성하여 추가
		 */
		sendFileToForm : function (files) {
        	 var fd = new FormData();
	            for (var i = 0; i < files.length; i++){
	                 fd.append('file', files[i]);
	            }
	            return fd;
         },

 		/**temp 폴더에 파일 업로드
		 FormData, 업로드 url, temp폴더이름
		 */
         sendFileToServer : function (fd, url, fileConfigInfo) {

        	fd.append("atchFileGbCd", fileConfigInfo.atchFileGbCd);
        	 
        	if(fileConfigInfo.fileCheckType==1){
        		fd.append("type", "image");
 			}else if(fileConfigInfo.fileCheckType==2){
 				fd.append("type", "video");
 			}else if(fileConfigInfo.fileCheckType==3){
 				fd.append("type", "doc");
 			}else if(fileConfigInfo.fileCheckType==4){
 				fd.append("type", "all");
 			}
        	 
        	 var data;
             $.ajax({
                 url: url,
                 type: "POST",
                 contentType:false,
                 processData: false,
                 data: fd,
                 async: false,
                 success: function(resJSON, resCode){
                	 data = resJSON;
                 },
 			     error : function(XMLHttpRequest, textStatus, errorThrown){
			     	alert(XMLHttpRequest.responseJSON.message);
			     },
             });
             return data;
         },

		//파일 리스트
		drawFileList : function(data, targetId) {
			var fileConfigInfo = fileUtil.fn.getfileConfigInfo(targetId);
			
		    var reader = new FileReader();
		    reader.readAsDataURL(data [0]);

		    var lastModified = "";
		    
			var html = "";
         	for (var i = 0; i < data.length; i++){
         		lastModified = data[i].lastModified
    			html +='<div id="tr'+data[i].lastModified +'" style="display:block; " class="filelist">';
    			if(fileConfigInfo.viewYn == 'Y'){
    				html += "<div class='thumnail_img'>";
    				html += "<img src='' alt=''>";
    				if(fileConfigInfo.delButtonYn == 'Y'){
    					html += "<button type='button' class='thumnail_del' onClick=\"fileUtil.fn.setFileDelete('"+data[i].lastModified+"', '"+targetId+"')\">삭제</button>";
    				}
    				html += "</div>";
    			}else{
    				html += "<a href='javascript:fileUtil.fn.download(\"0\", 0, \""+data[i].lastModified+"\", \""+data[i].name+"\");' ><span >"+data[i].name+"</span></a>";
    				html +="<span class='fright' >";
    				html += fileUtil.fn.byteConvertor(data[i].size);
    				if(fileConfigInfo.delButtonYn == 'Y'){
    					html +="<button type='button' onClick=\"fileUtil.fn.setFileDelete('"+data[i].lastModified+"', '"+targetId+"')\" >삭제</button>";
    				}
    				html +="</span>";
    			}
    			
    			html +='<input type="hidden" id="fileChk" value="0" >';
				html +='<input type="hidden" id="orignlFileNm"  value="'+data[i].name+'" />';
				html +='<input type="hidden" id="streFileNm"  value="'+data[i].lastModified+'" />';
				html +='<input type="hidden" id="fileSize"  value="'+data[i].size+'" />';
				html +='<input type="hidden" id="fileExtsn"  value="'+data[i].name.split('.')[1]+'" />';
				html +='<input type="hidden" id="atchFileGbCd"  value="test" />';
				html +='<input type="hidden" id="fileStreCours"  value="test" />';
				html +='<input type="hidden" id="seq"  value="0" />';
				html +='</div>';
        	}
         	
         	fileUtil.fn.fileFormReset();
         	$("#"+targetId+" #fileList").append(html);
         	
         	reader.onload = function  () {
         		document.querySelector("#tr"+lastModified+" .thumnail_img img").src = reader.result;
         	}
		},
		
		getSaveFileList : function(targetId){
			var fileConfigInfo = fileUtil.fn.getfileConfigInfo(targetId);
			var fileList = new Array();
			
			for(var i=0;i<	$("#"+fileConfigInfo.targetId+" #fileList > div").length ;i++){
				var fileInfo = new Object();
				var tmpInfo = $("#"+fileConfigInfo.targetId+" #fileList > div").eq(i);
				var fileChk = tmpInfo.find("input[id='fileChk']").val();
				if(fileChk == '1'){
					continue;
				}
				
				fileInfo['atchFileSeq']		= fileConfigInfo.atchFileSeq;
				fileInfo['seq']				= tmpInfo.find("input[id='seq']").val();
				fileInfo['fileStreCours']	= tmpInfo.find("input[id='fileStreCours']").val();
				fileInfo['atchFileGbCd']	= tmpInfo.find("input[id='atchFileGbCd']").val();
				fileInfo['orignlFileNm']	= tmpInfo.find("input[id='orignlFileNm']").val();
				fileInfo['streFileNm']		= tmpInfo.find("input[id='streFileNm']").val();
				fileInfo['fileExtsn']		= tmpInfo.find("input[id='fileExtsn']").val();
				fileInfo['fileSize']		= tmpInfo.find("input[id='fileSize']").val();
				fileInfo['fileChk']			= tmpInfo.find("input[id='fileChk']").val();
				
				fileList.push(fileInfo);
			}
			
			return fileList;
		},

		getFileList : function(atchFileSeq, targetId){

			var fileConfigInfo = fileUtil.fn.getfileConfigInfo(targetId);
			
			if(atchFileSeq != '' || atchFileSeq != undefined){
				fileConfigInfo.atchFileSeq = atchFileSeq;
				
				var param = {
					"atchFileSeq" : atchFileSeq,
					"atchFileGbCd" : fileConfigInfo.atchFileGbCd,
				};
				
		        $.ajax({
		            url:'/json/inqFileList',
		            type:'POST',
		            data:param,
		            async:true,
		            dataType : "JSON",
					success	: function(resJSON) {
						var data = resJSON.body;
						var html = '';

						for(i in data){
			        		$("#"+fileConfigInfo.targetId+" #atchFileSeq").val(data[i].atchFileSeq);
			        		//데이터 .jpg 등 확장자가 있으면 찾지를 못함
		        			html+="<div id=tr"+data[i].streFileNm +" style='display:block; ' class='filelist'>";
		        			html += "<input type='hidden' id='fileChk' value='1' >";
							html +='<input type="hidden" id="orignlFileNm"  value="'+data[i].orignlFileNm+'" />';
							html +='<input type="hidden" id="streFileNm"  value="'+data[i].streFileNm+'" />';
							html +='<input type="hidden" id="fileSize"  value="'+data[i].fileSize+'" />';
							html +='<input type="hidden" id="fileExtsn"  value="'+data[i].fileExtsn+'" />';
							html +='<input type="hidden" id="atchFileGbCd"  value="'+data[i].atchFileGbCd+'" />';
							html +='<input type="hidden" id="fileStreCours"  value="'+data[i].fileStreCours+'" />';
							html +="<input type='hidden' id='seq'  value='"+data[i].seq+"' />";
							
						    html += "<a href='javascript:fileUtil.fn.download(\""+data[i].atchFileSeq+"\", "+data[i].seq+", \""+data[i].atchFileGbCd+"\", \""+data[i].streFileNm+"\", \""+data[i].orignlFileNm+"\");' ><span >"+data[i].orignlFileNm+"</span></a>";
							html +="<span class='fright' >";
							html +=fileUtil.fn.byteConvertor(data[i].fileSize);
							if( fileConfigInfo.delButtonYn == 'Y'){
								html +="<button type='button' onClick=\"fileUtil.fn.setFileDelete('"+data[i].streFileNm+"', '"+fileConfigInfo.targetId+"')\"  > 삭제</button>";
							}
							html +="</span>";
							html +="</div>";
						}
						if(data.length <= 0){
							fileConfigInfo.atchFileSeq = '';
						}
						$("#"+fileConfigInfo.targetId+" #fileList").html(html);
					},
				    error : function(XMLHttpRequest, textStatus, errorThrown){
				    },
				});
				
			}
		},

		/** 데이터만 불러오기 */
		getFileListData : function(atchFileSeq, targetId){
			var fileConfigInfo = fileUtil.fn.getfileConfigInfo(targetId);
			var data = "";
			fileConfigInfo.atchFileSeq = atchFileSeq;
			
			var param = {
				"atchFileSeq" : fileUtil.atchFileSeq,
				"atchFileGbCd" : fileConfigInfo.atchFileGbCd,
			};
			
	        $.ajax({
	            url:'/FileList.do',
	            type:'POST',
	            data:param,
	            async:false,
	            sendDataType:"json",
				success	: function(resJSON, resCode) {
					data = resJSON.data.list;
				},
			    error : function(XMLHttpRequest, textStatus, errorThrown){
			    },
			});
			
			if(data.length > 0){
				return data;
			}else{
				return 0;
			}
		},

		//파일삭제
		setFileDelete : function(streFileNm, targetId){
			/*
			var fileChk = $("#tr"+streFileNm+" > #fileChk").val();
			
			if(fileChk == 0){
				var fileConfigInfo = fileUtil.fn.getfileConfigInfo(targetId);
				
				var param = {
						"streFileNm"			: streFileNm
				};
		
		        $.ajax({
		            url:'/TempFileDelete.do',
		            type:'POST',
		            data:param,
		            async:false,
		            sendDataType:"json",
					success: function(data) {
						$("#tr"+streFileNm).remove();
				    },
				    error : function(XMLHttpRequest, textStatus, errorThrown){
				    },
				});
				
			}else{
				$("#tr"+streFileNm+" > #fileChk").val("2");
				$("#tr"+streFileNm).hide();
			}
			*/
			$("#tr"+streFileNm).remove();

		},
		
		//첨부파일 전체 보기 모드
		setFileViewModeAll : function(){
			$(".filebox").css("background","#fafafa");
			$(".filebox #divFake").remove();
			$(".filebox :button").remove();
			for(var i in fileUtil.fileConfig){
				fileUtil.fileConfig[i].delButtonYn = 'N';
				fileUtil.fileConfig[i].addButtonYn = 'N';
			}
		},
		
		//특정 첨부파일 보기 모드
		setFileViewMode : function(targetId){
			$("#"+targetId).css("background","#fafafa");
			$("#"+targetId+" #divFake").remove();
			$("#"+targetId+".filebox :button").remove();
			for(var i in fileUtil.fileConfig){
				if(fileUtil.fileConfig[i].targetId == targetId){
					fileUtil.fileConfig[i].delButtonYn = 'N';
					fileUtil.fileConfig[i].addButtonYn = 'N';
					continue;
				}
			}
		},

		download :  function(atchFileSeq, seq, atchFileGbCd, streFileNm, orignlFileNm){
			var downUrl = "/FileDownload.do";
			var param = {
					"atchFileSeq" : atchFileSeq,
					"seq" : seq,
					"atchFileGbCd" : atchFileGbCd,
					"streFileNm" : streFileNm,
					"orignlFileNm" : orignlFileNm,
				};
			
			var str = Object.keys(param).map(function(key){ 
			  return encodeURIComponent(key) + '=' + encodeURIComponent(param[key]); 
			}).join('&');
		
	        $.ajax({
	            url:downUrl,
	            type:'POST',
	            data:param,
	            async:false,
	            sendDataType:"json",
				success: function(data) {
					location.href=downUrl+"?"+str;
			    },
			    error : function(XMLHttpRequest, textStatus, errorThrown){
			    	alert(XMLHttpRequest.responseJSON.message);
			    },
			});
			
		},

		byteConvertor : function(bytes) {
			var s = ['bytes', 'KB', 'MB', 'GB', 'TB', 'PB'];
			var e = Math.floor(Math.log(bytes)/Math.log(1024));
			if(e >= s.length) e = s.length - 1;//s의 마지막 단위로 표시할 수 없이 크다면, 마지막 단위로 처리
			if(e == "-Infinity") return "0 " + s[0];
			else return (bytes/Math.pow(1024, Math.floor(e))).toFixed(2)+" "+s[e];
		},
		
		getExtension : function(filename)
		{
		    var parts = filename.split('.');
		    return parts[parts.length - 1];
		},

		getExtension02 : function(files){
	            for (var i = 0; i < files.length; i++){
//	            	return fileUtil.fn.getExtension(files[i].name);
	            	return files[i].name;
	            }
		},

		extensionCheck : function(extensionFunc, getExtension){

			if(extensionFunc==1){
				return fileUtil.fn.isImage(getExtension);
			}else if(extensionFunc==2){
				return fileUtil.fn.isVideo(getExtension);
			}else if(extensionFunc==3){
				return fileUtil.fn.isDoc(getExtension);
			}else if(extensionFunc==4){
				return fileUtil.fn.AllFile(getExtension);
			}
		},

		isImage : function(filename)
		{
		    var ext = this.getExtension(filename);
		    switch (ext.toLowerCase()) {
		    case 'jpg':
		    case 'gif':
		    case 'bmp':
		    case 'png':
		    case 'jpeg':
		        //etc
		        return true;
		    }
		    return false;
		},

		isVideo : function(filename)
		{
		    var ext = this.getExtension(filename);
		    switch (ext.toLowerCase()) {
		    case 'm4v':
		    case 'avi':
		    case 'mpg':
		    case 'mp4':
		        // etc
		        return true;
		    }
		    return false;
		},

		isDoc : function(filename)
		{
			var ext = this.getExtension(filename);
		    switch (ext.toLowerCase()) {
		    case 'pdf':
		    case 'doc':
		    case 'docx':
		    case 'xlsx':
		    case 'xls':
		    case 'txt':
		    case 'ppt':
		    case 'pptx':
		    case 'zip':
		    case 'hwp':
		        // etc
		        return true;
		    }
		    return false;
		},

		AllFile : function(filename)
		{
			var ext = this.getExtension(filename);
		    switch (ext.toLowerCase()) {
		    case 'pdf':
		    case 'doc':
		    case 'docx':
		    case 'xlsx':
		    case 'xls':
		    case 'txt':
		    case 'ppt':
		    case 'pptx':
		    case 'zip':
		    case 'hwp':
		    	
		    case 'jpg':
		    case 'gif':
		    case 'bmp':
		    case 'png':
		    case 'jpeg':
		    	
		    case 'm4v':
		    case 'avi':
		    case 'mpg':
		    case 'mp4':
		    	
		        // etc
		        return true;
		    }
		    return false;
		}
	}
};
