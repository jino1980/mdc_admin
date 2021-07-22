<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<%@page import="java.util.*"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="navbar-header">
	<button type="button" 
		class="navbar-toggle collapsed"
		data-toggle="collapse"	data-target="#navbar" aria-expanded="false"	aria-controls="navbar">
		<span class="sr-only">Toggle navigation</span>
		<span class="icon-bar"></span>
		<span class="icon-bar"></span>
		<span class="icon-bar"></span>
	</button>
	<a class="navbar-brand" href="<c:url value="/home/home" />">Spring4.0</a>
</div>
<div id="navbar" class="navbar-collapse collapse">
	<ul class="nav navbar-nav">
		<li id="home_li"><a href="<c:url value="/home/home" />">Home</a></li>
		<li id="board_li"><a href="<c:url value="/home/board" />">Board</a></li>
		<li id="contact_li"><a href="<c:url value="/home/contact" />">Contact</a></li>
		<li id="dropdown_li" class="dropdown">
			<a href="#" class="dropdown-toggle"
				data-toggle="dropdown" role="button" aria-haspopup="true"
				aria-expanded="false">
				Rink<span class="caret"></span>
			</a>
			<ul class="dropdown-menu">
				<li><a href="https://slipp.net/" target="_blank">자바지기</a></li>
				<li><a href="https://opentutorials.org/course/1" target="_blank">생활코딩</a></li>
				<li><a href="https://www.w3schools.com/" target="_blank">w3schools</a></li>
				<li role="separator" class="divider"></li>
				<li class="dropdown-header">Project</li>
				<li><a href="https://mvnrepository.com/" target="_blank">mvnrepository.com</a></li>
				<li><a href="https://start.spring.io/" target="_blank">SPRING INITIALIZR</a></li>
				<li><a href="http://getbootstrap.com/" target="_blank">bootstrap</a></li>
			</ul>
		</li>
		<li id="signUp_li"><a href="<c:url value="/home/signUp" />">Sign Up</a></li>
		<li id="admin_li"><a href="<c:url value="/home/admin" />">Admin</a></li>
	</ul>
		
        <c:choose>
            <c:when test="${displayName != null}">
                <form class="form-inline navbar-form navbar-right" action="<c:url value="/logout" />" method="post">
                    <button type="submit" class="btn btn-warning">Log out</button>
                </form>
                <div class="navbar-right">
                    <img src="${imageUrl }">
                    <span style="color: white;">${displayName }</span>  
                </div>
            </c:when>
            <c:otherwise>
                <security:authorize access="isAuthenticated()">
                    <form class="form-inline navbar-form navbar-right" action="<c:url value="/logout" />" method="post">
                        <button type="submit" class="btn btn-warning">Log out</button>
                    </form>
                </security:authorize>
                <security:authorize access="isAnonymous()">
                    <form class="form-inline navbar-form navbar-right" action="<c:url value="/login" />" method="post">
                        <button type="submit" class="btn btn-default">Log in</button>
                    </form>
                </security:authorize>
            </c:otherwise>
        </c:choose>
	<!-- metohd=get -->
	<%-- <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> --%>
</div>

<script>
(function(){
	var url = location.href;	
	if (url.includes('/home/home')) {
	    document.getElementById("home_li").className = "active";
	} else if (url.includes('/home/board') || url.includes('/home/findOneBoard')) {
		document.getElementById("board_li").className = "active";
	} else if (url.includes('/home/contact')) {
		document.getElementById("contact_li").className = "active";
	} else if (url.includes('/home/signUp')) {
		document.getElementById("signUp_li").className = "active";
	} else if (url.includes('/home/admin')) {
		document.getElementById("admin_li").className = "active";
	}
})();
</script>