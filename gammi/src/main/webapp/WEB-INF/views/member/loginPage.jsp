<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="resources/css/login.css" type="text/css">
      <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">
<meta charset="UTF-8">
<script src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>
<script type="text/javascript"
	src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js"
	charset="utf-8"></script>
<script type="text/javascript">
        //애플리케이션 등록하고 발급받은 javascript 앱키를 사용해야 함
        Kakao.init('c3ecbcd41bfe29231bd45758bb64ea58');
        //sdk 초기화여부 판단
        console.log(Kakao.isInitialized());

        //카카오 로그인
        function kakaoLogin() {
          Kakao.Auth.login({
            success: function (response) {
              Kakao.API.request({
                url: '/v2/user/me',
                success: function (response) {
                  console.log(response)
                },
                fail: function (error) {
                  console.log(error)
                },
              })
            },
            fail: function (error) {
              console.log(error);
            },
          })
        }

        //카카오로그아웃  
        function kakaoLogout() {
          if (Kakao.Auth.getAccessToken()) {
            Kakao.API.request({
              url: '/v1/user/unlink',
              success: function (response) {
                console.log(response)
              },
              fail: function (error) {
                console.log(error)
              },
            })
            Kakao.Auth.setAccessToken(undefined)
          }
        }
       
        
        
        
      </script>
      <style>
      .sothumb {
      width:350px;
       height : 60px;
      }
      </style>
<title></title>
</head>
<body>
<c:import url="/WEB-INF/views/common/menubar.jsp" />

<form action="login.do" method="post">
<div class="wrap">
<div class="login">
<a href="main.do"><h3  style="font-size:50px; 	font-family: 'Noto Sans KR', sans-serif;">Gammi</h3></a>
<div class="login_id">
	<h4 style="	font-family: 'Noto Sans KR', sans-serif;">아이디</h4>
	<input type="text" name="m_id" class="pos" placeholder="ID(아이디)"  >
	</div>
	<div class="login_pw">
	<h4 style="	font-family: 'Noto Sans KR', sans-serif;">비밀번호</h4>
	 <input type="password" name="m_pw" class="pos" placeholder="비밀번호">
	 </div>
	<div class="submit">
	<input style="	font-family: 'Noto Sans KR', sans-serif;" type="submit" value="로그인">
	</div>
	<br>
	<div class="loginmenu">
	<div class="schid">
	<c:url var="mvfindId" value="/moveIdRecovery.do" />
	<a href="${ mvfindId }"><p style="	font-family: 'Noto Sans KR', sans-serif;">아이디 찾기</p></a>
	</div>
	<span style="margin-top: 8px;">|</span>
	<div class="schpw">
	<c:url var="mvfindPwd" value="/movePwdRecovery.do" />
	<a href="${ mvfindPwd }"><p style="	font-family: 'Noto Sans KR', sans-serif;">비밀번호 찾기</p></a>
	</div>
	</div>
	<div id="kakao_id_login" class="kakao_id_login" style="text-align: center">
	<a href="<c:url value='${kakaoUrl}'/>" class="cp"> 
		<img class="sothumb"  src="${ pageContext.servletContext.contextPath }/resources/img/kakao_login.png" alt="카카오로그인">
	</a>
	</div>
	
	<div id="ndfin" style="text-align:center">
	<a href="${naverUrl}" id='.cp_naver'>
		<img class="sothumb" style="width:350px; height : 60px;"  src="${ pageContext.servletContext.contextPath }/resources/img/naver.png" alt="네이버로그인">
	</a>
</div>
</div>


	
</div>
</form>
<c:import url="/WEB-INF/views/common/footer.jsp" />

</body>
</html>
