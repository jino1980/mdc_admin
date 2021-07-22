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
                        <a href="#" class="on" class="sel">카탈로그 등록</a>
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
                                    카탈로그 명
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
                                                    <div class="dragAndDropDiv filebox2" id="fileDiv1" onClick="javascript:fileUtil.fn.selectFiles('fileDiv1');">
                                                        <input type="hidden" id="fileId" name="fileId"  value="0"/>
    
                                                        <!-- 썸네일 정보 -->
                                                        <div class="thumnail_txt_info">
                                                            <span class="color_red">[필수]</span><br>
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
                                                    <div class="dragAndDropDiv filebox2" id="fileDiv2" onClick="javascript:fileUtil.fn.selectFiles('fileDiv2');">
                                                        <input type="hidden" id="fileId" name="fileId"  value="0"/>
    
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
                                                    <div class="dragAndDropDiv filebox2" id="fileDiv3" onClick="javascript:fileUtil.fn.selectFiles('fileDiv3');">
                                                        <input type="hidden" id="fileId" name="fileId"  value="0"/>
    
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
                                                    <div class="dragAndDropDiv filebox2" id="fileDiv4" onClick="javascript:fileUtil.fn.selectFiles('fileDiv4');">
                                                        <input type="hidden" id="fileId" name="fileId"  value="0"/>
    
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
                                                    <div class="dragAndDropDiv filebox2" id="fileDiv5" onClick="javascript:fileUtil.fn.selectFiles('fileDiv5');">
                                                        <input type="hidden" id="fileId" name="fileId"  value="0"/>
    
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
                                    검색어
                                </th>
                                <td colspan="3">
                                    <input type="text" name="" id="">
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
                                    상세내용
                                </th>
                                <td colspan="3">
                                    <textarea name="" id="" cols="30" rows="10"></textarea>
                                </td>
                            </tr>
                            <tr>
                                <th scope="row">
                                    버전정보
                                </th>
                                <td>
                                    <input type="text" name="" id="">
                                </td>
                                <th scope="row">
                                    언어선택
                                </th>
                                <td>
                                    <ul class="inputbox">
                                        <li>
                                            <input type="radio" id="radio01_1" name="radio01"><label
                                                for="radio01_1">한국어</label>
                                        </li>
                                        <li>
                                            <input type="radio" id="radio01_2" name="radio01"><label
                                                for="radio01_2">영어</label>
                                        </li>
                                    </ul>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    전화문의
                                </th>
                                <td>
                                    <select name="" id="">
                                        <option value="">씨그마알드리치 (031-329-9000)</option>
                                    </select>
                                </td>
                                <th>
                                    이메일문의
                                </th>
                                <td>
                                    <select name="" id="">
                                        <option value="">씨그마알드리치 (sakr@naver.com)</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    파일 업로드
                                </th>
                                <td colspan="3">
                                    <input type="file">
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
				fileUtil.fileConfig.push({
					fileId : "",
					fileCheckNum : 1,
					fileCheckType : 4,  //1==isImage , 2==isVideo , 3==isDoc 4==AllFile
					delButtonYn : "Y",		//삭제버튼 유무
					addButtonYn : "Y",		//첨부버튼 유무
					targetId : "fileDiv1",
					screenId : "SAMPLE",
					viewYn : "Y"
				});
			
				fileUtil.fileConfig.push({
					fileId : "",
					fileCheckNum : 1,
					fileCheckType : 4,  //1==isImage , 2==isVideo , 3==isDoc 4==AllFile
					delButtonYn : "Y",		//삭제버튼 유무
					addButtonYn : "Y",		//첨부버튼 유무
					targetId : "fileDiv2",
					screenId : "SAMPLE",
					viewYn : "Y"
				});
			
				fileUtil.fileConfig.push({
					fileId : "",
					fileCheckNum : 1,
					fileCheckType : 4,  //1==isImage , 2==isVideo , 3==isDoc 4==AllFile
					delButtonYn : "Y",		//삭제버튼 유무
					addButtonYn : "Y",		//첨부버튼 유무
					targetId : "fileDiv3",
					screenId : "SAMPLE",
					viewYn : "Y"
				});
			
				fileUtil.fileConfig.push({
					fileId : "",
					fileCheckNum : 1,
					fileCheckType : 4,  //1==isImage , 2==isVideo , 3==isDoc 4==AllFile
					delButtonYn : "Y",		//삭제버튼 유무
					addButtonYn : "Y",		//첨부버튼 유무
					targetId : "fileDiv4",
					screenId : "SAMPLE",
					viewYn : "Y"
				});
			
				fileUtil.fileConfig.push({
					fileId : "",
					fileCheckNum : 10,
					fileCheckType : 4,  //1==isImage , 2==isVideo , 3==isDoc 4==AllFile
					delButtonYn : "Y",		//삭제버튼 유무
					addButtonYn : "Y",		//첨부버튼 유무
					targetId : "fileDiv5",
					screenId : "SAMPLE",
					viewYn : "Y"
				});
				
				fileUtil.init();
			    </script>