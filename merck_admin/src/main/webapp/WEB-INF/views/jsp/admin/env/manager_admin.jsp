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
                        <a href="#" class="on" class="sel">문의 담당자 관리</a>
                    </li>
                </ul>
            </div>
            <!-- // header -->

            <!-- content -->

            <div class="content">
                <!-- 타이틀 -->
                <div class="title_box">
                    <h2 class="h2">총 <span>12,345</span>건</h2>
                </div>
                <!-- // 타이틀 -->

                <!-- 리스트 -->
                <div class="tb_list">
                    <div id="grid"></div>
                </div>
                <!-- // 리스트 -->


                <!-- 페이징 + 버튼 -->
                <div class="paging_box">
                    <div class="btn_box left">
                        <input type="text">
                        <button type="button" class="btn btn_search">검색</button>
                    </div>
                    <div id="pagination1" class="tui-pagination paging"></div>
                    <div class="btn_box">
                        <button type="button" data-name="popup01" class="btn btn_default popup_open">등록</button>
                    </div>
                </div>
                <!-- // 페이징 + 버튼 -->

            </div>
            <!-- // content -->


    <!-- 레이어 팝업 -->
    <div class="layer_popup" id="popup01" style="display: none;">
        <div class="popup_wrap type01">
            <div class="pop_head">
                <h1 tabindex="0">문의 담당자 등록</h1>
                <button type="button" class="popup_close" title="닫기"></button>
            </div>
            <div class="pop_cont">
                <div class="pop_cont_wrap"style="padding-bottom: 0;">

                    <!-- 작성폼 -->
                    <div class="tb_create">
                        <table>
                            <caption>등록</caption>
                            <colgroup>
                                <col width="120">
                                <col>
                            </colgroup>
                            <tbody>
                                <tr>
                                    <th scope="row">
                                        부서명
                                    </th>
                                    <td>
                                        <input type="text" name="" id="">
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row">
                                        이름
                                    </th>
                                    <td>
                                        <input type="text" name="" id="">
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row">
                                        이메일
                                    </th>
                                    <td>
                                        <input type="text" name="" id="">
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row">
                                        회사전화
                                    </th>
                                    <td>
                                        <input type="text" name="" id="">
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row">
                                        핸드폰
                                    </th>
                                    <td>
                                        <input type="text" name="" id="">
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <!-- // 작성폼 -->
                </div>
                <div class="btn_box">
                    <button type="button" class="btn btn_default">등록</button>
                    <button type="button" class="btn btn_default">취소</button>
                </div>
            </div>
        </div>
    </div>
    <!-- // 레이어 팝업 -->

    <script>
        // 목록
        var Grid = tui.Grid;
        Grid.setLanguage('ko', {
            display: {
                noData: '검색 결과가 없습니다'
            }
        });

        var grid = new tui.Grid({
            el: $('#grid'),
            data: gridData,
            scrollX: false,
            scrollY: false,
            header: {
                height: 35
            },
            minRowHeight: 30,
            bodyHeight: 340,
            columns: [{
                    title: 'No.',
                    align: 'center',
                    name: 'type01',
                    width: 80
                },
                {
                    title: '부서명',
                    align: 'center',
                    name: 'type02',
                },
                {
                    title: '이름',
                    align: 'center',
                    name: 'type03',
                },
                {
                    title: '이메일',
                    align: 'center',
                    name: 'type04',
                },
                {
                    title: '회사전화',
                    align: 'center',
                    name: 'type05',
                },
                {
                    title: '핸드폰',
                    align: 'center',
                    name: 'type06',
                },
                {
                    title: '수정',
                    align: 'center',
                    name: 'type07',
                    width: 80,
                    formatter: function (value, rowData) {
                        var btnCy = rowData.btnClass1;
                        return '<button type="button" class="tb_btn ' + btnCy + '">' + value +
                            '</button>';
                    }
                },
                {
                    title: '삭제',
                    align: 'center',
                    name: 'type08',
                    width: 80,
                    formatter: function (value, rowData) {
                        var btnCy = rowData.btnClass2;
                        return '<button type="button" class="tb_btn ' + btnCy + '">' + value +
                            '</button>';
                    }
                }
            ]
        });

        var gridData = [{
            type01: '1',
            type02: '머크주식회사',
            type03: '홍길동',
            type04: 'test@test.cokr',
            type05: '02-1234-5678',
            type06: '010-1234-5678',
            btnClass1: 'blue',
            type07: '수정',
            btnClass2: 'red',
            type08: '삭제'
        }];
        grid.setData(gridData);

        // 페이징
        var Pagination = tui.Pagination;

        var pagination1 = new tui.Pagination('pagination1', {
            totalItems: 500,
            itemsPerPage: 10,
            visiblePages: 10
        });
    </script>