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
                        <a href="#" class="on" class="sel">공지사항 등록</a>
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
                                    이미지등록
                                </th>
                                <td colspan="3">
                                    <div class="file_wrap">

                                        <ul class="img_create_list">
                                            <li>
                                                <div class="file_wrap">
                                                    <div class="dragAndDropDiv filebox2" id="fileDiv1"
                                                        onClick="javascript:fileUtil.fn.selectFiles('fileDiv1');">
                                                        <input type="hidden" id="fileId" name="fileId" value="0" />

                                                        <!-- 썸네일 정보 -->
                                                        <div class="thumnail_txt_info">
                                                            <span>대표 이미지</span><br>
                                                            <span>사이즈표기</span><br>
                                                        </div>

                                                        <!-- 썸네일 이미지 -->
                                                        <!-- <div class="thumnail_img">
                                                            <img src="../resource/images/list_type03_img03.jpg" alt="">
                                                        </div> -->
                                                    </div>
                                                </div>
                                            </li>
                                            <li>
                                                <div class="file_wrap">
                                                    <div class="dragAndDropDiv filebox2" id="fileDiv2"
                                                        onClick="javascript:fileUtil.fn.selectFiles('fileDiv2');">
                                                        <input type="hidden" id="fileId" name="fileId" value="0" />

                                                        <!-- 썸네일 정보 -->
                                                        <div class="thumnail_txt_info">
                                                            <span>추가 이미지1</span><br>
                                                            <span>사이즈표기</span><br>
                                                        </div>

                                                        <!-- 썸네일 이미지 -->
                                                        <!-- <div class="thumnail_img">
                                                            <img src="../resource/images/list_type03_img03.jpg" alt="">
                                                            <button type="button" class="thumnail_del">삭제</button>
                                                        </div> -->
                                                    </div>
                                                </div>
                                            </li>
                                            <li>
                                                <div class="file_wrap">
                                                    <div class="dragAndDropDiv filebox2" id="fileDiv3"
                                                        onClick="javascript:fileUtil.fn.selectFiles('fileDiv3');">
                                                        <input type="hidden" id="fileId" name="fileId" value="0" />

                                                        <!-- 썸네일 정보 -->
                                                        <div class="thumnail_txt_info">
                                                            <span>추가 이미지2</span><br>
                                                            <span>사이즈표기</span><br>
                                                        </div>

                                                        <!-- 썸네일 이미지 -->
                                                        <!-- <div class="thumnail_img">
                                                            <img src="../resource/images/list_type03_img03.jpg" alt="">
                                                        </div> -->
                                                    </div>
                                                </div>
                                            </li>
                                            <li>
                                                <div class="file_wrap">
                                                    <div class="dragAndDropDiv filebox2" id="fileDiv4"
                                                        onClick="javascript:fileUtil.fn.selectFiles('fileDiv4');">
                                                        <input type="hidden" id="fileId" name="fileId" value="0" />

                                                        <!-- 썸네일 정보 -->
                                                        <div class="thumnail_txt_info">
                                                            <span>추가 이미지3</span><br>
                                                            <span>사이즈표기</span><br>
                                                        </div>

                                                        <!-- 썸네일 이미지 -->
                                                        <!-- <div class="thumnail_img">
                                                            <img src="../resource/images/list_type03_img03.jpg" alt="">
                                                        </div> -->
                                                    </div>
                                                </div>
                                            </li>
                                            <li>
                                                <div class="file_wrap">
                                                    <div class="dragAndDropDiv filebox2" id="fileDiv5"
                                                        onClick="javascript:fileUtil.fn.selectFiles('fileDiv5');">
                                                        <input type="hidden" id="fileId" name="fileId" value="0" />

                                                        <!-- 썸네일 정보 -->
                                                        <div class="thumnail_txt_info">
                                                            <span>추가 이미지4</span><br>
                                                            <span>사이즈표기</span><br>
                                                        </div>

                                                        <!-- 썸네일 이미지 -->
                                                        <!-- <div class="thumnail_img">
                                                            <img src="../resource/images/list_type03_img03.jpg" alt="">
                                                        </div> -->
                                                    </div>
                                                </div>
                                            </li>
                                        </ul>
                                        <ul class="bullet mark mt5">
                                            <li>이미지는 JPG/PNG/GIF 형식의 파일로 3MB이하로 등록이 가능합니다.</li>
                                        </ul>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th scope="row">
                                    내용
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