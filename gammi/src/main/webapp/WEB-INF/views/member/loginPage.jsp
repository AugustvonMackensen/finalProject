<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="resources/css/login.css" type="text/css">
      <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">
<meta charset="UTF-8">
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
</div>
</div>
</form>
<c:import url="/WEB-INF/views/common/footer.jsp" />

</body>
</html>
