<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<%@page import="java.util.*"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

		<!-- lnb_wrap -->
		<div id="left_div" class="lnb_wrap">
			<div class="logo"><img src="${RESOURCES_PATH}/resource/images/logo_main.svg" alt="MDC"></div>
			<div class="lnb_con">
				<div class="lnb_title">관리자 메뉴</div>
				<ul class="lnb_menu">
					<li><a href="#" class="on">카탈로그 관리</a>
						<ul class="lnb_menu_depth">
							<li><a href="#" onClick="switchContent('/admin/catalog/catalog_list');" class="on">카탈로그 목록</a></li>
							<li><a href="#" onClick="switchContent('/admin/catalog/catalog_write');">카탈로그 등록</a></li>
						</ul>
					</li>
					<li><a href="#">알림 관리</a>
						<ul class="lnb_menu_depth">
							<li><a href="#" onClick="switchContent('/admin/alert/notice_list');">공지사항</a></li>
							<li><a href="#" onClick="switchContent('/admin/alert/push_list');">푸시 관리</a></li>
							<li><a href="#" onClick="switchContent('/admin/alert/popup_list');">팝업 관리</a></li>
						</ul>
					</li>
					<li>
						<a href="#">환경설정</a>
						<ul class="lnb_menu_depth">
							<li><a href="#" onClick="switchContent('/admin/env/catalog_list');">카테고리 관리</a></li>
							<li><a href="#" onClick="switchContent('/admin/env/manager_admin');">문의 담당자 관리</a></li>
							<li><a href="#" onClick="switchContent('/admin/env/help');">도움말 관리</a></li>
						</ul>
					</li>
				</ul>
			</div>
		</div>
		<!-- // lnb_wrap -->


<script>
function switchContent(bodyName){
    $('#bodyTile').children().remove();
    $('#bodyTile').load(bodyName);
}
</script>