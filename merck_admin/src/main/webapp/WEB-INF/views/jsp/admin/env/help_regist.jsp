<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<%@page import="java.util.*"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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


            </div>
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

    <script>
        
    </script>