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
						<a href="#" class="on" class="sel">카탈로그 목록</a>
					</li>
				</ul>
			</div>
			<!-- // header -->

			<!-- content -->
			<div class="content">

				<!-- 타이틀 -->
				<div class="title_box">
					<h1 class="h1">검색조건</h1>
				</div>
				<!-- // 타이틀 -->


				<!-- 검색 -->
				<div class="tb_search">
					<table>
						<caption>검색</caption>
						<colgroup>
							<col width="200" />
							<col width="" />
						</colgroup>
						<tbody>
							<tr>
								<th scope="row">카테고리</th>
								<td>
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
								<th scope="row">정렬기준</th>
								<td>
									<ul class="inputbox">
										<li>
											<input type="radio" id="radio01_1" name="radio01"><label
												for="radio01_1">최신순</label>
										</li>
										<li>
											<input type="radio" id="radio01_2" name="radio01"><label
												for="radio01_2">카테고리순</label>
										</li>
										<li>
											<input type="radio" id="radio01_3" name="radio01"><label
												for="radio01_3">다운로드순</label>
										</li>
										<li>
											<input type="radio" id="radio01_3" name="radio01"><label
												for="radio01_3">좋아요순</label>
										</li>
									</ul>
								</td>
							</tr>
							<tr>
								<th scope="row">등록일</th>
								<td>
									<div class="datepicker_box">
										<div class="tui-datepicker-input tui-datetime-input tui-has-focus">
											<input type="text" id="datepicker-input1" aria-label="Date-Time">
											<span class="tui-ico-date"></span>
										</div>
										<div id="wrapper1" style="margin-top: -1px;"></div>
									</div>
									~
									<div class="datepicker_box">
										<div class="tui-datepicker-input tui-datetime-input tui-has-focus">
											<input type="text" id="datepicker-input2" aria-label="Date-Time">
											<span class="tui-ico-date"></span>
										</div>
										<div id="wrapper2" style="margin-top: -1px;"></div>
									</div>
								</td>
							</tr>
							<tr>
								<th scope="row">검색내용</th>
								<td>
									<input type="text" name="">
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<!-- // 검색 -->
				
				<div class="btn_box alright">
					<button type="button" class="btn btn_default">검색</button>
				</div>

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
					<div id="pagination1" class="tui-pagination paging"></div>
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
					timepicker: true,
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
							title: '카테고리',
							align: 'left',
							name: 'type02',
							width: 200
						},
						{
							title: '카탈로그명',
							align: 'left',
							name: 'type03'
						},
						{
							title: '날짜',
							align: 'center',
							name: 'type04',
							width: 100
						},
						{
							title: '다운로드 수',
							align: 'center',
							name: 'type05',
							width: 100
						},
						{
							title: '좋아요 수',
							align: 'center',
							name: 'type06',
							width: 100
						},
						{
							title: '수정',
							align: 'center',
							name: 'type07',
							width: 80,
							formatter: function(value, rowData) {
								var btnCy = rowData.btnClass1;
								return '<button type="button" class="tb_btn '+ btnCy +'">' + value + '</button>';
							}
						},
						{
							title: '삭제',
							align: 'center',
							name: 'type08',
							width: 80,
							formatter: function(value, rowData) {
								var btnCy = rowData.btnClass2;
								return '<button type="button" class="tb_btn '+ btnCy +'">' + value + '</button>';
							}
						}
					]
				});
		
				var gridData = [{
						type01: '1',
						type02: '화학, 재료과학',
						type03: 'Analyte Quarterly vol.2 2019',
						type04: '2021.06.21',
						type05: '1,154',
						type06: '113',
						btnClass1: 'blue',
						type07: '수정',
						btnClass2: 'red',
						type08: '삭제'
					}
				];
				grid.setData(gridData);
		
				// 페이징
				var Pagination = tui.Pagination;
		
				var pagination1 = new tui.Pagination('pagination1', {
					totalItems: 500,
					itemsPerPage: 10,
					visiblePages: 10
				});
			</script>