<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style>
/* http://craziers.com/%EB%A7%90%EC%A4%84%EC%9E%84-ellipsis-css/ */
.p_text {
    display: -webkit-box;
    display: -ms-flexbox;
    display: box;
    margin-top:1px;
    max-height:60px;
    overflow:hidden;
    vertical-align:top;
    text-overflow: ellipsis;
    word-break:break-all;
    -webkit-box-orient:vertical;
    -webkit-line-clamp:3
}
</style>

<div class="jumbotron">
    <h1>Board</h1>
</div>
<!-- issue list table -->
<div class="panel panel-default">
    <!-- Default panel contents -->
    <div class="panel-heading">일반 게시판</div>
    <div class="panel-body">
        <div class="clearfix">
            <div class="row">
                <div class="col-md-12">
                <p>pagenation.</p>
                </div>
            </div>
        </div>
    </div>
    
    <table class="table table-hover">
        <thead>
            <tr>
                <th class="col-xs-1">#</th>
                <th class="col-xs-7 text-overflow">content</th>
                <th class="col-xs-2">writer</th>
                <th class="col-xs-2">date</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${BoardList}" var="boardVO" varStatus="status">
                <tr>
                    <th scope="row">${status.count}</th>
                    <td class="text" onclick="findOne('${boardVO.id}')">
                        <div class="p_text">
                            <input type="hidden" id="content_${boardVO.id }" value="${boardVO.board_content}">
                            <script>
                            	document.write(document.getElementById( "content_" + ${ boardVO.id } ).value);
                    		</script>
                        </div>
                    </td>
                    <td>${boardVO.writer}</td>
                    <td><fmt:formatDate value="${boardVO.insDate}" type="date" /></td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

<form action="<c:url value='/home/boardContent'/>" method="post">
    <button type="submit" class="btn btn-default" id="writeButton">글쓰기</button>
</form>

<div class="paging text-center">
	<nav aria-label="...">
	  <ul class="pagination" >
	    <li class="${PageVO.beginPage == 1 ? 'disabled' : '' }"><a href="<c:url value='/home/board?requirePage=${PageVO.beginPage == 1 ? PageVO.requirePage : PageVO.beginPage - PageVO.perPage}'/>" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
	        <c:forEach begin="${PageVO.beginPage }" end = "${PageVO.endPage }" varStatus="status">
	            <li class='${PageVO.requirePage==status.index?"active":""}' ><a href="<c:url value='/home/board?requirePage=${status.index}'/>"> ${status.index} <span class="sr-only"> </span></a></li>
	        </c:forEach>
	    <li class="${PageVO.endPage == PageVO.totalPage ? 'disabled' : '' }"><a href="<c:url value='/home/board?requirePage=${PageVO.endPage < PageVO.totalPage ? PageVO.endPage + 1 : PageVO.requirePage}'/>" aria-label="Next"><span aria-hidden="true">&raquo;</span></a></li>
	  </ul>
	</nav>
</div>

<form id="findForm" action="<c:url value="/home/findOneBoard" />" method="post" style="display: none;">
    <input type="number" id="find_id" name="id">
</form>

<script>
	function findOne(id) {
		document.getElementById("find_id").value = id;
		$("#findForm").submit();
	}
</script>
