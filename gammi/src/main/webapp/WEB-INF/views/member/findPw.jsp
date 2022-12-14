<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: "Noto Sans KR", sans-serif;
  }
  
  a {
    text-decoration: none;
    color: black;
  }
  
  li {
    list-style: none;
  }
  
  .wrap {
    width: 100%;
    height: 100vh;
    display: flex;
    align-items: center;
    justify-content: center;
    background: rgba(172, 140, 140, 0.1);
  }
  
  .login {
    width: 30%;
    height: 600px;
    background: rgb(255, 255, 255);
    border-radius: 20px;
    display: flex;
    justify-content: center;
    align-items: center;
    flex-direction: column; 
  }
  
  h2 {
    color: tomato;
    font-size: 2em;
  }
  
  
  .login_id {
    margin-top: 20px;
    width: 80%;
  }
  
  .login_id input {
    width: 100%;
    height: 50px;
    border-radius: 30px;
    margin-top: 10px;
    padding: 0px 20px;
    border: 1px solid lightgray;
    outline: none;
  }
  
  .login_pw {
    margin-top: 20px;
    width: 80%;
  }
  
  .login_pw input {
    width: 100%;
    height: 50px;
    border-radius: 30px;
    margin-top: 10px;
    padding: 0px 20px;
    border: 1px solid lightgray;
    outline: none;
  }
  
  .submit {
    margin-top: 50px;
    width: 80%;
    color: rgb(255, 255, 255);
    
  }
  .submit input{
    width: 100%;
    height: 50px;
    border: 0;
    outline: none;
    border-radius: 40px;
    background: linear-gradient(to left, rgb(255, 77, 46), rgb(255, 155, 47));
    font-size: 1.2em;
    letter-spacing: 2px;
  }
}
</style>
<title></title>
</head>
<body>
<c:import url="/WEB-INF/views/common/menubar.jsp" />

<form action="findPwd.do" method="post">

 <div class="wrap">
 <div class="login">
 <h3 style="font-family: 'Noto Sans KR', sans-serif; font-size : 40px">비밀번호 찾기</h3>
<div class="login_id">
<h4 style="margin-top : 40px; font-family: 'Noto Sans KR', sans-serif;">아이디입력</h4>
<input type="text" name="m_id"  placeholder="아이디(ID)입력"><br>
</div>

<div class="login_pw">
<h4 style="font-family: 'Noto Sans KR', sans-serif;">이메일</h4>
 <input type="email" name="m_email"  placeholder="회원님의 이메일 주소를 입력하세요.">
<input style="background:#ab7021; color:white; margin-top:30px; font-family: 'Noto Sans KR', sans-serif;" type="submit" value="비밀번호찾기 ">
</div>
</div>
</div>
</form>

</body>
</html>