<%@page import="org.slf4j.Logger"%>
<%@page import="org.slf4j.LoggerFactory"%>
<%@page import="com.merck.catalog.common.SoftLabHumUtils"%>
<%@page import="com.merck.catalog.admin.vo.TbCab002d"%>
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
                        <a href="#" class="on" class="sel">카카오로그인 후처리</a>
                    </li>
                </ul>
            </div>
            <!-- // header -->

            <div class="content">
                <!-- 작성폼 -->
                <div class="tb_create">
                    <table>
                        <caption>카카오정보</caption>
                        <colgroup>
                            <col width="160">
                            <col>
                        </colgroup>
                        <tbody>
                            <tr>
                                <th scope="row">
                                    로그인 토큰 정보
                                </th>
                                <td>
                                     <textarea name="token-result" id="token-result" title="token" class="required" cols="30" rows="10"></textarea>
                                </td>
                            </tr>
                            <tr>
                                <th scope="row">
                                    프로필 이미지
                                </th>
                                <td>
                                    <img id="thumbnail_image_url" src="" />
                                </td>
                            </tr>
                            <tr>
                                <th scope="row">
                                    카카오 ID
                                </th>
                                <td>
                                    <input type="text" class="required" title="kakaoId" name="kakaoId" id="kakaoId">
                                </td>
                            </tr>
                            <tr>
                                <th scope="row">
                                    생일
                                </th>
                                <td>
                                    <input type="text" class="required" title="birthday" name="birthday" id="birthday">
                                </td>
                            </tr>
                            <tr>
                                <th scope="row">
                                    이메일주소
                                </th>
                                <td>
                                    <input type="text" class="required" title="emailAddr" name="emailAddr" id="emailAddr">
                                </td>
                            </tr>
                            <tr>
                                <th scope="row">
                                    닉네임
                                </th>
                                <td>
                                    <input type="text" class="required" title="nickname" name="nickname" id="nickname" >
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <!-- // 작성폼 -->
             </div>
             
			<script type="text/javascript"> 
				var kakao_message = new Object(); 
				
				function displayToken() {
				    const token = getCookie('reauthenticate-access-token');
				    if(token) {
				      Kakao.Auth.setAccessToken(token)
				      Kakao.Auth.getStatusInfo(({ status }) => {
				        if(status === 'connected') {
				          document.getElementById('token-result').innerText = 'login success. token: ' + Kakao.Auth.getAccessToken()
				        } else {
				          Kakao.Auth.setAccessToken(null)
				        }
				      })
				    }
				  }
				
			  function getCookie(name) {
			    const value = "; " + document.cookie;
			    const parts = value.split("; " + name + "=");
			    if (parts.length === 2) return parts.pop().split(";").shift();
			  }
				
			  $(document).ready( function() {
					
					//로그인 토큰 확인
					displayToken();
					
					
					var ACCESS_TOKEN= getCookie('reauthenticate-access-token');
					//할당받은 토근을 세팅 
					Kakao.Auth.setAccessToken(ACCESS_TOKEN);
					console.log(Kakao.Auth.getAccessToken());
					Kakao.API.request({ url: '/v2/user/me', 
						
						success: function(response) {
							console.log(response); 
							kakao_message['id']=response['id'];
							kakao_message['birthday']=response['kakao_account']['birthday']; 
							kakao_message['email']=response['kakao_account']['email']; 
							kakao_message['nickname']=response['kakao_account']['profile']['nickname']; 
							kakao_message['thumbnail_image_url']=response['kakao_account']['profile']['thumbnail_image_url']; 
							console.log(kakao_message); 
							
							$("#kakaoId").val(response['id']);
							$("#birthday").val(response['kakao_account']['birthday']);
							$("#emailAddr").val(response['kakao_account']['email']);
							$("#nickname").val(response['kakao_account']['profile']['nickname']);
							$("#thumbnail_image_url").prop("src",response['kakao_account']['profile']['thumbnail_image_url']);
							
							var m_uid = 'KAKAO_'+kakao_message['id']; 
							console.log(""+window.location.hostname+""); 
							
							return ;
							
							
							
							var data = JSON.stringify({ uid : m_uid , uname : kakao_message['nickname'] , uemail : kakao_message['email'] , join_pass : 'KAKAO' }); 
							// 로그인시 서버에서 넘어왔음.. 
							//로그인정보가 있다면 로그인 시도하기..
							var url = '/user/userid_duplicate_check'; 
							getPostData(url,data,callback_userid_duplicate_check, false); 
							
							if(!is_userid) 
								//sns가입된 id가 있다면 로그인 시도. 
							{ 
								url = '/user/naver_kakao_sns_login'; 
								getPostData(url,data,callback_join_ok, false); 
							} else if(is_userid) //sns로 가입된 id가 없다면 가입시도.. 
							{ 
								$("#i_id").val(m_uid); 
								$("#i_name").val(kakao_message['nickname']); 
								$("#i_email").val(kakao_message['email']); 
							} 
						}, 
							
						fail: function(error) {
							console.log(error); 
						} 
					}); 
			}); 
			</script>
			