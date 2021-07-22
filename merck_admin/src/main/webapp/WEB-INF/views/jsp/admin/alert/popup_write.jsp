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
                        <a href="#" class="on" class="sel">팝업 등록</a>
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
                        </colgroup>
                        <tbody>
                            <tr>
                                <th scope="row">
                                    제목
                                </th>
                                <td>
                                    <input type="text" name="" id="">
                                </td>
                            </tr>
                            <tr>
                                <th scope="row">
                                    기간
                                </th>
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
                                <th scope="row">
                                    내용
                                </th>
                                <td>
                                    <textarea name="" id="" cols="30" rows="10"></textarea>
                                </td>
                            </tr>
                            <tr>
                                <th scope="row">
                                    바로가기
                                </th>
                                <td>
                                    <input type="text" name="" id="">
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
                        <button type="button" data-name="popup01" class="btn btn_default popup_open">미리보기</button>
                        <button type="button" class="btn btn_default">등록</button>
                    </div>
                </div>
                <!-- // 페이징 + 버튼 -->

            </div>
            <!-- // content -->

    <!-- 레이어 팝업 -->
    <div class="layer_popup" id="popup01" style="display: none;">
        <div class="popup_wrap type01">
            <div class="pop_head">
                <h1 tabindex="0">새로운 카탈로그가 등록이 되었습니다.</h1>
                <button type="button" class="popup_close" title="닫기"></button>
            </div>
            <div class="pop_cont">
                <div class="pop_cont_wrap">
                    <!-- 팝업 내용 -->
                    <pre class="pop_text">2021년 일자 기준으로 카달로그가 등록이 되었습니다.
많은 이용해 주시고 아래 바로가기 링크로 이동하시면 해당 카달로그를 보실수 있습니다.</pre>
                    <!-- // 팝업 내용 -->
                    <!-- 카탈로그 바로가기 -->
                    <a href="#none" class="go_catalogue">
                        카달로그 바로가기 클릭
                    </a>
                    <!-- // 카탈로그 바로가기 -->
                </div>

                <!-- 오늘 하루 보지 않기 -->
                <div class="not_today_wrapper">
                    <ul class="inputbox">
                        <li>
                            <input type="checkbox" id="not_today" name="not_today"><label for="not_today">오늘 하루 보지
                                않기</label>
                        </li>
                    </ul>
                </div>
                <!-- // 오늘 하루 보지 않기 -->
            </div>
        </div>
    </div>
    <!-- // 레이어 팝업 -->

    <script>
        $(document).on("click", ".popup_open", function () {
            grid.refreshLayout();
        });

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


        fileUtil.fileConfig.push({
            fileId: "",
            fileCheckNum: 1,
            fileCheckType: 4, //1==isImage , 2==isVideo , 3==isDoc 4==AllFile
            delButtonYn: "Y", //삭제버튼 유무
            addButtonYn: "Y", //첨부버튼 유무
            targetId: "fileDiv1",
            screenId: "SAMPLE",
            viewYn: "Y"
        });

        fileUtil.fileConfig.push({
            fileId: "",
            fileCheckNum: 1,
            fileCheckType: 4, //1==isImage , 2==isVideo , 3==isDoc 4==AllFile
            delButtonYn: "Y", //삭제버튼 유무
            addButtonYn: "Y", //첨부버튼 유무
            targetId: "fileDiv2",
            screenId: "SAMPLE",
            viewYn: "Y"
        });

        fileUtil.fileConfig.push({
            fileId: "",
            fileCheckNum: 1,
            fileCheckType: 4, //1==isImage , 2==isVideo , 3==isDoc 4==AllFile
            delButtonYn: "Y", //삭제버튼 유무
            addButtonYn: "Y", //첨부버튼 유무
            targetId: "fileDiv3",
            screenId: "SAMPLE",
            viewYn: "Y"
        });

        fileUtil.fileConfig.push({
            fileId: "",
            fileCheckNum: 1,
            fileCheckType: 4, //1==isImage , 2==isVideo , 3==isDoc 4==AllFile
            delButtonYn: "Y", //삭제버튼 유무
            addButtonYn: "Y", //첨부버튼 유무
            targetId: "fileDiv4",
            screenId: "SAMPLE",
            viewYn: "Y"
        });

        fileUtil.fileConfig.push({
            fileId: "",
            fileCheckNum: 10,
            fileCheckType: 4, //1==isImage , 2==isVideo , 3==isDoc 4==AllFile
            delButtonYn: "Y", //삭제버튼 유무
            addButtonYn: "Y", //첨부버튼 유무
            targetId: "fileDiv5",
            screenId: "SAMPLE",
            viewYn: "Y"
        });

        fileUtil.init();
    </script>