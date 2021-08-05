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
			<c:forEach var="boardPost" items="${boardPostList}">

            <form:form commandName="notcForm" action="#">
            <input type="hidden" id="boardId" name="boardId"  value="${BOARD_ID}"/>
            <input type="hidden" id="postId" name="postId"  value="${boardPost.postId}"/>
            
            <input type="hidden" id="taskSe" name="taskSe"  value="HELP"/>
            <input type="hidden" id="taskSeCd" name="taskSeCd"  value="HLP"/>
            
            <div class="content">
                <!-- 타이틀 -->
                <div class="title_box">
                    <h2 class="h2">총 <span id="totCnt"></span>건</h2>
                </div>
                <!-- // 타이틀 -->

                <!-- 리스트 -->
                <div class="help_list">
                    <ul>
                        <li>
                            <a href="#none" data-name="popup01" class="popup_open">
                                <img src="http://placehold.it/150x200" />
                            </a>
                            <div class="btn_box">
                                <button type="button" class="tb_btn blue">수정</button>
                                <button type="button" class="tb_btn red">삭제</button>
                            </div>
                        </li>
                        <li>
                            <a href="#none">
                                <img src="http://placehold.it/150x200" />
                            </a>
                            <div class="btn_box">
                                <button type="button" class="tb_btn blue">수정</button>
                                <button type="button" class="tb_btn red">삭제</button>
                            </div>
                        </li>
                        <li>
                            <a href="#none">
                                <img src="http://placehold.it/150x200" />
                            </a>
                            <div class="btn_box">
                                <button type="button" class="tb_btn blue">수정</button>
                                <button type="button" class="tb_btn red">삭제</button>
                            </div>
                        </li>
                        <li>
                            <a href="#none">
                                <img src="http://placehold.it/150x200" />
                            </a>
                            <div class="btn_box">
                                <button type="button" class="tb_btn blue">수정</button>
                                <button type="button" class="tb_btn red">삭제</button>
                            </div>
                        </li>
                        <li>
                            <a href="#none">
                                <img src="http://placehold.it/150x200" />
                            </a>
                            <div class="btn_box">
                                <button type="button" class="tb_btn blue">수정</button>
                                <button type="button" class="tb_btn red">삭제</button>
                            </div>
                        </li>
                        <li>
                            <a href="#none">
                                <img src="http://placehold.it/150x200" />
                            </a>
                            <div class="btn_box">
                                <button type="button" class="tb_btn blue">수정</button>
                                <button type="button" class="tb_btn red">삭제</button>
                            </div>
                        </li>
                        <li>
                            <a href="#none">
                                <img src="http://placehold.it/150x200" />
                            </a>
                            <div class="btn_box">
                                <button type="button" class="tb_btn blue">수정</button>
                                <button type="button" class="tb_btn red">삭제</button>
                            </div>
                        </li>
                        <li>
                            <a href="#none">
                                <img src="http://placehold.it/150x200" />
                            </a>
                            <div class="btn_box">
                                <button type="button" class="tb_btn blue">수정</button>
                                <button type="button" class="tb_btn red">삭제</button>
                            </div>
                        </li>
                        <li>
                            <a href="#none">
                                <img src="http://placehold.it/150x200" />
                            </a>
                            <div class="btn_box">
                                <button type="button" class="tb_btn blue">수정</button>
                                <button type="button" class="tb_btn red">삭제</button>
                            </div>
                        </li>
                        <li class="add_file">
                            <button></button>
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
            </form:form>
            </c:forEach>
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
		                    <img src="http://placehold.it/300x400" />
		                    <!-- // 이미지 -->
		                    <a href="#none" class="prev_btn"></a>
		                    <a href="#none" class="next_btn"></a>
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
        
    </script>