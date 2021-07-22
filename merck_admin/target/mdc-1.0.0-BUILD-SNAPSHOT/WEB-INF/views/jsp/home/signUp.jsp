<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<div class="jumbotron">
    <h1>Sign UP</h1>
    <ul>
        <li>아래 계정으로 접속할 수 있습니다.
            <ul>
                <li>id : aaa</li>
                <li>passsword : 1111</li>
            </ul>
        </li>
        <li>구글 로그인 가능합니다.</li>
        <li>그냥 회원가입을 해도 됩니다.</li>
    </ul>
</div>
    <c:if test="${not empty msg}">
	<div class="alert alert-danger" role="alert">${msg}</div>
	</c:if>
<c:url var="signUpInsert" value="/signUpInsert" />
<form class="form-horizontal" action="${signUpInsert}" method="post">
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
    <div class="form-group">
        <label class="control-label col-sm-2" for="name">Name:</label>
        <div class="col-sm-10">
            <input type="text" class="form-control" id="name" placeholder="Enter username" name="name" required="required">
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-2" for="pwd">Password:</label>
        <div class="col-sm-10">          
            <input type="password" class="form-control" id="pwd" placeholder="Enter password" name="password" required="required">
        </div>
    </div>
    
    <div class="form-group">
        <div class="col-sm-offset-2 col-sm-10">
            <button type="submit" class="btn btn-default">Submit</button>
        </div>
    </div>
</form>
