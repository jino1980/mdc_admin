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
                        <a href="#" class="on" class="sel">카카오 싱크 테스트 중</a>
                    </li>
                </ul>
            </div>
            <!-- // header -->

            <!-- content -->
            <div class="content">
                <a id="custom-login-btn" href="javascript:loginWithKakaoPop()">
				  <img
				    src="${RESOURCES_PATH}/resource/images/kakao/kakao_login_large_narrow.png"
				    width="222"
				  />
				</a>
				<p id="token-result"></p>
				<script type="text/javascript">
					
					//초기화 시키기. 
					$(document).ready(function(){
						$("#div_load_image").hide();
						Kakao.init('5e73ef5fe37d873e52cd1e492aa5c924'); 
						Kakao.isInitialized(); 
					});
					
					// Example of use:   setCookie('user', 'John', {secure: true, 'max-age': 3600});
					function setCookie(name, value, options = {}) {

						  options = {
						    path: '/',
						    // 필요한 경우, 옵션 기본값을 설정할 수도 있습니다.
						    ...options
						  };

						  if (options.expires instanceof Date) {
						    options.expires = options.expires.toUTCString();
						  }

						  let updatedCookie = encodeURIComponent(name) + "=" + encodeURIComponent(value);

						  for (let optionKey in options) {
						    updatedCookie += "; " + optionKey;
						    let optionValue = options[optionKey];
						    if (optionValue !== true) {
						      updatedCookie += "=" + optionValue;
						    }
						  }

						  document.cookie = updatedCookie;
						}
					
					function loginWithKakaoPop() {
					    Kakao.Auth.login({
					      success: function(authObj) {
					        //alert(JSON.stringify(authObj))
					        console.log("## 로그인성공!! =>>>"+JSON.stringify(authObj))
					        var token = authObj.access_token;
					        var scope = authObj.scope;
					        console.log("## 로그인 정보 =>>>token["+token+"]");
					        console.log("## 로그인 정보 =>>>scope["+scope+"]");
					        
					        setCookie('reauthenticate-access-token',token);
					        setCookie('reauthenticate-access-scope',scope);
					        switchContent('/client/oauth/login_kakao_cabllBack');
					        
					      },
					      fail: function(err) {
					        alert(JSON.stringify(err))
					      },
					    })
					  }
					
				  function loginWithKakao() {
				    Kakao.Auth.authorize({
				      redirectUri: '${CONTEXT_PATH}/client/oauth/login_kakao_cabllBack'
				    })
				  }
				  
				</script>
		    </div>
		    <!-- // 레이어 팝업 -->
			