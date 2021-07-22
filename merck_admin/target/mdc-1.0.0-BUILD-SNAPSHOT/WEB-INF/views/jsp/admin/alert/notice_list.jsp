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
                        <a href="#" class="on" class="sel">공지사항</a>
                    </li>
                </ul>
            </div>
            <!-- // header -->

            <!-- content -->
            <div class="content">

                <!-- 타이틀 -->
                <div class="title_box">
                    <h2 class="h2">총 <span>12,345</span>건</h2>
                    <div class="fright">
                        <a href="#none">등록일 순</a> |
                        <a href="#none">게시일 순</a>
                    </div>
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
                        <button type="button" class="btn btn_default">글쓰기</button>
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
		
		        var datepicker2 = new tui.DatePicker('#wrapper2', {
		            date: new Date(),
		            input: {
		                element: '#datepicker-input2',
		                format: 'yyyy-MM-dd HH:mm A'
		            }
		        });
		
		
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
		                    title: '제목',
		                    align: 'left',
		                    name: 'type02',
		                },
		                {
		                    title: '등록일',
		                    align: 'center',
		                    name: 'type03',
		                    width: 100
		                },
		                {
		                    title: '게시일',
		                    align: 'center',
		                    name: 'type04',
		                    width: 100
		                },
		                {
		                    title: '수정',
		                    align: 'center',
		                    name: 'type05',
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
		                    name: 'type06',
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
		            type02: '새로운 버전 업데이트 안내',
		            type03: '2021.06.21',
		            type04: '2021.06.21',
		            btnClass1: 'blue',
		            type05: '수정',
		            btnClass2: 'red',
		            type06: '삭제'
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
