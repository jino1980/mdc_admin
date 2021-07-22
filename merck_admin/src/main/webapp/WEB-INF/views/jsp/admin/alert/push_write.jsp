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
                        <a href="#" class="on" class="sel">푸시 등록</a>
                    </li>
                </ul>
            </div>
            <!-- // header -->

            <!-- content -->

            <div class="content">
                <!-- 작성폼 -->
                <div class="tb_create">
                    <table>
                        <caption>등록</caption>
                        <colgroup>
                            <col width="160">
                            <col>
                            <col width="160">
                            <col>
                        </colgroup>
                        <tbody>
                            <tr>
                                <th scope="row">
                                    제목
                                </th>
                                <td colspan="3">
                                    <input type="text" name="" id="">
                                </td>
                            </tr>
                            <tr>
                                <th scope="row">
                                    카테고리
                                </th>
                                <td colspan="3">
									<ul class="inputbox">
										<li>
											<input type="checkbox" id="checkbox01_1" name="checkbox01"><label
												for="checkbox01_1">전체</label>
										</li>
										<li>
											<input type="checkbox" id="checkbox01_2" name="checkbox01"><label
												for="checkbox01_2">생명과학</label>
										</li>
										<li>
											<input type="checkbox" id="checkbox01_3" name="checkbox01"><label
												for="checkbox01_3">화학</label>
										</li>
										<li>
											<input type="checkbox" id="checkbox01_4" name="checkbox01"><label
												for="checkbox01_4">재료과학</label>
										</li>
										<li>
											<input type="checkbox" id="checkbox01_5" name="checkbox01"><label
												for="checkbox01_5">QA/QC</label>
										</li>
										<li>
											<input type="checkbox" id="checkbox01_6" name="checkbox01"><label
												for="checkbox01_6">기타</label>
										</li>
									</ul>
                                </td>
                            </tr>
                            <tr>
                                <th scope="row">
                                    간략내용
                                </th>
                                <td colspan="3">
                                    <textarea name="" id="" cols="30" rows="10"></textarea>
                                </td>
                            </tr>
                            <tr>
                                <th scope="row">
                                    카탈로그 경로
                                </th>
                                <td>
                                    <input type="text" name="" id="">
                                </td>
                                <th scope="row">
                                    발행일
                                </th>
                                <td>
                                    <button class="tb_btn state" disabled>현재</button><button class="tb_btn state">예약</button>
                                    <div class="datepicker_box">
                                        <div class="tui-datepicker-input tui-datetime-input tui-has-focus">
                                            <input type="text" id="datepicker-input1" aria-label="Date-Time">
                                            <span class="tui-ico-date"></span>
                                        </div>
                                        <div id="wrapper1" style="margin-top: -1px;"></div>
                                    </div>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <!-- // 작성폼 -->


                <!-- 페이징 + 버튼 -->
                <div class="paging_box">
                    <div class="btn_box">
                        <button type="button" class="btn btn_default">임시저장</button>
                        <button type="button" class="btn btn_default">등록</button>
                    </div>
                </div>
                <!-- // 페이징 + 버튼 -->

            </div>
            <!-- // content -->

    <script>
        var datepicker1 = new tui.DatePicker('#wrapper1', {
            date: new Date(),
            timepicker: true,
            input: {
                element: '#datepicker-input1',
                format: 'yyyy-MM-dd HH:mm A'
            }
        });

        fileUtil.init();
    </script>