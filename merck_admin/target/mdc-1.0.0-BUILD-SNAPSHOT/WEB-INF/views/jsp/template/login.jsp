<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>

	<div class="container">
		
		<c:if test="${not empty param.error }">
			<h2>${SPRING_SECURITY_LAST_EXCEPTION.message }</h2>
		</c:if>
      
      <form:form class="form-signin" id="loginForm" action="" method="post">
		 
        <h2 class="form-signin-heading">Sign in</h2>
        <h5 class="form-signin-heading">
            <a href="<c:url value="/home/home" />">
                <span class="glyphicon glyphicon-hand-right" aria-hidden="true"></span>
                <span class="glyphicon-class">Just go home page !</span>
            </a>
        </h5>
        <!-- 
        <label for="inputEmail" class="sr-only">Email address</label>
        <input type="email" id="inputEmail" class="form-control" placeholder="Email address" required="" autofocus="">
        
          버튼에 백그라운드 스타일 넣기
        style="background: #ccc url(test.jpg); padding: 0.5em 1em "
         -->
        
        <label for="inputName" class="sr-only">Email address</label>
        <input type="text" id="inputName" class="form-control" placeholder="Name" required="required" autofocus="autofocus" name="username">
        
        <label for="inputPassword" class="sr-only">Password</label>
        <input type="password" id="inputPassword" class="form-control" placeholder="Password" required="required" name="password">
        
        <div class="checkbox">
          <label>
            <input type="checkbox" value="remember-me"> Remember me
          </label>
        </div>
        <button class="btn btn-lg btn-primary btn-block" type="submit">Sign in</button>
        
        <a href="<c:url value="/login/googleSignIn" />" class="btn btn-default btn-lg btn-block" style="max-height: 46px;">
            <span style="color: blue;">G</span>
            <span style="color: red;">o</span>
            <span style="color: orange;">o</span>
            <span style="color: blue;">g</span>
            <span style="color: green;">l</span>
            <span style="color: red;">e</span>
        </a>
        
        <a href="<c:url value="/home/signUp"/>" class="btn btn-default btn-lg btn-block">Sign up</a>
      </form:form>

    </div> <!-- /container -->
    
	<div style="text-align:center">
	<c:if test="${not empty error}">
		<div class="error">${error}</div>
	</c:if>
	<c:if test="${not empty msg}">
		<div class="msg">${msg}</div>
	</c:if>
	</div>
</body>
</html>