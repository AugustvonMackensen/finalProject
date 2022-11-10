<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	<h1 align="center">로그인</h1>
<div id="loginForm">
<form action="kakao_login.do" method=POST>
	<label>아이디 : <input type="text" name="userid" class="pos"></label> <br>
	<label>암 호 : <input type="password" name="userpwd" class="pos"></label> <br>
	<input type="submit" value="로그인">
</form>
</div>

</body>
</html>