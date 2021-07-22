<%@ page session="false" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<title>Home</title>
</head>
<body>
	<div class="container">
		<h1>Bootstrap starter template</h1>
		<p>
			Use this document as a way to quick start any new project.<br>
			All you get is this message and a barebones HTML document.
		</p>
		
		<h1>Hello world!</h1>
	
		<P>The time on the server is ${serverTime}.</P>
		<P>id is ${vo.id}.</P>
		<P>name is ${vo.name}.</P>
	
		스프링 폼태그가 아닌경우는 다음과 같은 인풋태그를 삽입해야 한다. 스프링 폼태그이면 기본제공 되므로 백단에서의 처리만 하면
		된다. 아작스시 csrf는 별도 작업이 있어야 한다.
	
		<c:url var="logoutUrl" value="/logout" />
	
		<form action="${logoutUrl }" method="post">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
			<input type="submit" value="Log out" />
		</form>
	</div>
</body>
</html>
