<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script type="text/javascript" src="<c:url value="/resources/smarteditor2/js/service/HuskyEZCreator.js" />" charset="utf-8"></script>

<div class="jumbotron">
    <h1>Board Content</h1>
</div>
<!-- issue list table -->
<div class="panel panel-default">
    <!-- Default panel contents -->
    <div class="panel-heading">Naver smarteditor2</div>
    <div class="panel-body">
        <div class="clearfix">
            <div class="row">
                <div class="col-md-12">
                    <p>
                        Naver smarteditor2를 사용했다. 
                        <br> bootstrap과 css 충돌이 일어나고, 반응형 동작을 위해 스타일을 추가했으나 이상 현상이 있다.
                        <br> 수정해 보려고 많은 시간을 쏟았지만 실패다.
                        <br> 모바일에 적합한 smarteditor3 버전이 나왔다고 하지만 새 프로젝트때는 다른 editor를 사용하고싶다.
                    </p>
                    <p>글쓰기, 읽기, 수정하기, 삭제하기</p>
                </div>
            </div>
        </div>
    </div>
    
</div>

<button type="button" class="btn btn-default" onclick="window.history.back();">리스트로 돌아가기</button>
 
<div class="page-header">
    <h4>- Naver smarteditor Version: 2.9.0.4a256db 적용.</h4>
    <c:choose>
        <c:when test="${BoardVO.board_content != null }">
            <form class="form-inline" action="<c:url value="/home/uptBoard" />" method="post" id="boardContentForm" name="boardContentForm">
                <textarea name="board_content" id="board_content" class="form-control" style='width: 100%; min-width: 150px; height: 30em; display: none;'>
                    ${BoardVO.board_content}
                </textarea>
                <div class="form-group">
                    <label for="InputName1">Writer</label> <input type="text" class="form-control" id="InputName1" placeholder="Jane Doe" name="writer" value="">
                </div>
                <div class="form-group">
                    <label for="InputPassword1">Password</label> <input type="password" class="form-control" id="InputPassword1" name="password" value="">
                </div>
                <input type="hidden" name="id" value="${BoardVO.id }">
                <button type="button" class="btn btn-default" id="updatebutton">Update</button>
                <button type="button" class="btn btn-danger" id="deletebutton">Delete</button>
                
                <c:if test="${not empty msg}">
				<div class="alert alert-danger" role="alert" style="margin-top: 1rem;">${msg}</div>
				</c:if>
            </form>
        </c:when>
        <c:otherwise>
            <form class="form-inline" action="<c:url value="/home/insBoard" />" method="post" id="boardContentForm" name="boardContentForm">
                <textarea name="board_content" id="board_content" class="form-control" style='width: 100%; min-width: 150px; height: 30em; display: none;'>
                    ${BoardVO.board_content}
                </textarea>
                <div class="form-group">
                    <label for="InputName1">Writer</label> <input type="text" class="form-control" id="InputName1" placeholder="Jane Doe" name="writer" value="">
                </div>
                <div class="form-group">
                    <label for="InputPassword1">Password</label> <input type="password" class="form-control" id="InputPassword1" name="password" value="">
                </div>
                <button type="button" class="btn btn-default" id="savebutton">Save</button>
			</form>
        </c:otherwise>
    </c:choose>
</div>

<form id="delBoardForm" action="<c:url value='/home/delBoard' />" method="post">
    <input type="hidden" name="id" value="${BoardVO.id }">
    <input id="delBoardFormPassword" type="hidden" name="password">
</form>

<script>
(function(){
	
	var oEditors = [];
	nhn.husky.EZCreator
			.createInIFrame({
				oAppRef : oEditors,
				elPlaceHolder : "board_content",
				sSkinURI : "${pageContext.request.contextPath}/resources/smarteditor2/SmartEditor2Skin.html",
				fCreator : "createSEditor2"
			});
	
	function validation() {
		
		if (document.getElementById("InputName1").value === '') {
			$("#InputName1").focus();
			return false;
		} else if (document.getElementById("InputPassword1").value === '') {
			$("#InputPassword1").focus();
			return false;
		} else {
			return true;
		}
	}
	
	
	$("#savebutton").click(function() {
		oEditors.getById["board_content"].exec("UPDATE_CONTENTS_FIELD", []);
		if (validation()) {
			$("#boardContentForm").submit();
		}
	});
	
	$("#updatebutton").click(function() {
		oEditors.getById["board_content"].exec("UPDATE_CONTENTS_FIELD", []);
		$("#boardContentForm").attr('action').value = '/home/uptBoard';
		if (validation()) {
			$("#boardContentForm").submit();
		}
	});
	
	$("#deletebutton").click(function() {
		document.getElementById("delBoardFormPassword").value = document.getElementById("InputPassword1").value;
		$("#delBoardForm").submit();
	});
	
})()
</script>
