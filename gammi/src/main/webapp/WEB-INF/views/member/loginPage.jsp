<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<style type="text/css">
h1 {
	font-size: 48pt;
	color: navy;
}
div {
	width: 500px;
	height: 200px;
	border: 2px solid navy; 
	position: relative; /* 본래 표시될 위치기준 상대적 위치로 지정 */
	left: 300px;
}
div form {
	font-size: 16pt;
	color: navy;
	font-weight: bold;
	margin: 10px;
	padding: 10px;
}
div#loginForm form input.pos {
	position: absolute; /* 절대좌표로 위치 지정 */
	left: 120px;
	width: 300px;
	height: 25px;
}
div#loginForm form input[type=submit] {
	margin: 10px;
	width: 250px;
	height: 40px;
	position: absolute;
	left: 120px;
	background: navy;
	color: white;
	font-size: 16pt;
	font-weight: bold;
}
</style>
</head>
<body>
<h1 align="center">로그인</h1>
<div id="loginForm">
<form action="login.do" method="post">
	<label>아이디 : <input type="text" name="m_id" class="pos"></label> <br>
	<label>암 호 : <input type="password" name="m_pw" class="pos"></label> <br>
	<input type="submit" value="로그인"> <br><br><br>
	
	<c:url var="mvfindId" value="/moveIdRecovery.do" />
	<a href="${ mvfindId }">아이디 찾기</a> &nbsp; &nbsp; | &nbsp;
	
	<c:url var="mvfindPwd" value="/movePwdRecovery.do" />
	<a href="${ mvfindPwd }">비밀번호 찾기</a> <br><br>
</form>
</div>

</body>
</html>
