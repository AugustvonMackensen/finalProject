<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>     
<!DOCTYPE html> 
<html>
<head>
<meta charset="UTF-8">
<title></title>
<style type="text/css">
table th { background-color: #99ffff; }
table#outer { border: 2px solid navy; }
</style>
<script type="text/javascript" src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.1.min.js"></script>
<script type="text/javascript">

//아이디 중복 체크 확인을 위한 ajax 실행 처리용 함수
//ajax(Asynchronous Javascript And Xml) : 
//페이지를 바꾸지 않고, 서버와 통신하는 기술임 
// (서버측에 서비스 요청하고 결과받음)
function dupCheckId(){
	//입력된 아이디가 중복되지 않았는지 확인 : jQuery.ajax() 사용
	//jQuery 는 $ 로 줄일 수 있음
	//jQuery.ajax(); => $.ajax();
	$.ajax({
		url: "idchk.do",
		type: "post",
		data: { m_id: $("#m_id").val() },
		success: function(data){
			console.log("success : " + data);
			if(data == "ok"){
				alert("사용 가능한 아이디입니다.");
				$("#upwd1").focus();
			}else{
				alert("이미 사용중인 아이디입니다.\n다시 입력하세요.");
				$("#m_id").select();
			}
		},
		error: function(jqXHR, textStatus, errorThrown){
			console.log("error : " + jqXHR + ", " + textStatus + ", " + errorThrown);
		}
	});
	
	return false;  //클릭 이벤트 전달을 막음
}

function validate(){
	//전송보내기 전(submit 버튼 클릭시) 입력값 유효한 값인지 검사
	
	//암호와 암호확인이 일치하는지 확인
	var pwd1 = document.getElementById("upwd1").value;
	var pwd2 = document.getElementById("upwd2").value;
	
	if(pwd1 !== pwd2){
		alert("암호와 암호 확인의 값이 일치하지 않습니다.\n"
				+ "다시 입력하세요.");
		document.getElementById("upwd1").select();
		return false;  //전송 안 함
	}
	
	return true; //전송함
}
</script>
</head>
<body>
<h1 align="center">회원 가입 페이지</h1>
<br>
<form action="enroll.do" method="post" onsubmit="return validate();">
<table id="outer" align="center" width="500" cellspacing="5" cellpadding="0">
	<tr><th colspan="2">회원 정보를 입력해 주세요.
		(* 표시는 필수입력 항목입니다.)
	</th></tr>
	<tr>
		<th width="120">* 아이디</th>
		<td><input type="text" name="m_id" id="m_id" required>
			&nbsp; &nbsp; 
			<input type="button" value="중복체크" onclick="return dupCheckId();">
		</td>
	</tr>
	<tr>
		<th width="120">* 닉네임</th>
		<td><input type="text" name="m_nickname" id="m_nickname" required></td>
	</tr>
	<tr>
		<th width="120">* 암 호</th>
		<td><input type="password" name="m_pw" id="upwd1" required></td>
	</tr>
	<tr>
		<th width="120">* 암호확인</th>
		<td><input type="password" id="upwd2"></td>
	</tr>
	<tr>
		<th width="120">* 생년월일</th>
		<td><input type="text" name="m_birth" required></td>
	</tr>
	<tr>
		<th width="120">* 이메일</th>
		<td><input type="email" name="m_email" required></td>
	</tr>
	<tr>
		<th colspan="2">
			<input type="submit" value="가입하기"> &nbsp; 
			<input type="reset" value="작성취소"> &nbsp; 
			<a href="main.do">시작페이지로 이동</a>
		</th>		
	</tr>
</table>
</form>

<hr style="clear:both;">
<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>