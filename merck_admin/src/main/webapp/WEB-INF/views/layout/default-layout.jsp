<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<%@page import="java.util.*"%>
<%
    request.setCharacterEncoding("UTF-8");
%>
<!-- 공통변수 처리 -->
<c:set var="CONTEXT_PATH" value="${pageContext.request.contextPath}" scope="application"/>
<c:set var="RESOURCES_PATH" value="${CONTEXT_PATH}/resources" scope="application"/>
<!DOCTYPE html>
<html lang='ko'>

<head>
	<!--[if lt IE 9]>
	    <script src="${RESOURCES_PATH}/resource/js/html5shiv.js"></script>
	<![endif]-->
	<meta charset="utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta name="viewport" content="width=device-width" />
	<script type="text/javascript">
		var CONTEXT_PATH = "${CONTEXT_PATH}";
		var RESOURCES_PATH = "${RESOURCES_PATH}";
		var gvSessionParams;
		
	</script>
	<script src="${RESOURCES_PATH}/resource/js/jquery-3.3.1.js"></script>
	<script src="${RESOURCES_PATH}/bower_components/js-cookie/src/js.cookie.js"></script>
	<script src="${RESOURCES_PATH}/bower_components/underscore/underscore.js"></script>
	<script src="${RESOURCES_PATH}/bower_components/backbone/backbone.js"></script>
	<script src="${RESOURCES_PATH}/bower_components/tui-code-snippet/dist/tui-code-snippet.js"></script>
	<script src="${RESOURCES_PATH}/bower_components/tui-dom/dist/tui-dom.js"></script>
	<script src="${RESOURCES_PATH}/bower_components/tui-pagination/dist/tui-pagination.js"></script>
	<script src="${RESOURCES_PATH}/bower_components/tui-time-picker/dist/tui-time-picker.js"></script>
	<script src="${RESOURCES_PATH}/bower_components/tui-date-picker/dist/tui-date-picker.js"></script>
	<script src="${RESOURCES_PATH}/bower_components/tui-auto-complete/dist/tui-auto-complete.js"></script>
	<script src="${RESOURCES_PATH}/bower_components/tui-floating-layer/dist/tui-floating-layer.js"></script>
	<script src="${RESOURCES_PATH}/bower_components/tui-file-uploader/dist/tui-file-uploader.js"></script>
	<script src="${RESOURCES_PATH}/bower_components/tui-tree/dist/tui-tree.js"></script>
	<script src="${RESOURCES_PATH}/bower_components/tui-context-menu/dist/tui-context-menu.js"></script>
	<script src="${RESOURCES_PATH}/bower_components/tui-grid/dist/tui-grid.js"></script>
	<script src="${RESOURCES_PATH}/bower_components/vanilla-Notify-master/dist/vanilla-notify.js"></script>
	<script src="${RESOURCES_PATH}/resource/js/ui_common.js"></script>
	<script src="${RESOURCES_PATH}/resource/js/jquery.serialize-object.js"></script>
	<script src="${RESOURCES_PATH}/resource/js/jquery-impromptu.min.js"></script>
	<script src="${RESOURCES_PATH}/resource/js/toastr.min.js"></script>
	
	<link href="${RESOURCES_PATH}/bower_components/tui-grid/dist/tui-grid.css" rel="stylesheet" />
	<link href="${RESOURCES_PATH}/bower_components/tui-pagination/dist/tui-pagination.css" rel="stylesheet" />
	<link href="${RESOURCES_PATH}/bower_components/tui-time-picker/dist/tui-time-picker.css" rel="stylesheet" />
	<link href="${RESOURCES_PATH}/bower_components/tui-date-picker/dist/tui-date-picker.css" rel="stylesheet" />
	<link href="${RESOURCES_PATH}/bower_components/tui-floating-layer/dist/tui-floating-layer.css" rel="stylesheet" />
	<link href="${RESOURCES_PATH}/bower_components/tui-file-uploader/dist/tui-file-uploader.css" rel="stylesheet" />
	<link href="${RESOURCES_PATH}/bower_components/tui-tree/dist/tui-tree.css" rel="stylesheet" />
	<link href="${RESOURCES_PATH}/bower_components/tui-context-menu/dist/tui-context-menu.css" rel="stylesheet" />
	<link href="${RESOURCES_PATH}/bower_components/vanilla-Notify-master/dist/vanilla-notify.css" rel="stylesheet" />
	<link href="${RESOURCES_PATH}/resource/css/content.css" rel="stylesheet" />
	<link href="${RESOURCES_PATH}/resource/css/jquery-impromptu.min.css" rel="stylesheet" />
	<link href="${RESOURCES_PATH}/resource/css/toastr.min.css" rel="stylesheet" />

	<title>MDC Admin</title>
  </head>
  
  <body>
    <!-- wrap -->
  	<div id="whole_div" class='wrap'>
  		<tiles:insertAttribute name="header" />
		  
  			<tiles:insertAttribute name="left"/>
	  		<!-- content_wrap -->
	  		<div id="bodyTile" class="content_wrap">
	  			<tiles:insertAttribute name="content"/>
	  		</div>
	  		<!-- // content_wrap -->
	  		
  		<tiles:insertAttribute name="footer" />
  	</div>
    <!-- // wrap -->
  </body>
</html>