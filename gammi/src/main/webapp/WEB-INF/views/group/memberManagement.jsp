<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="resources/css/band-clone.css" type="text/css">
</head>
<script type="text/javascript" src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.1.min.js"></script>
<script type="text/javascript">
//추방
function mExile(no, id){
	var m = new Object();
	m.group_no = String(no);
	m.m_id=id;
	$.ajax({
		url: "groupExile.do",
		type: "post",
		data: JSON.stringify(m),
		contentType: "application/json; charset=utf-8",
		dataType: "json",
		success: function(result){
			location.href="groupMemberManagement.do?gno="+result.group_no;
		},
		error: function(request, status, errorData){
			console.log("error code : " + request.status
					+ "\nMessage : " + request,responseText
					+ "\nError : " + errorData);
		}
	});
}
//가입수락
function mAccept(no, id){
	var m = new Object();
	m.group_no = String(no);
	m.m_id=id;
	$.ajax({
		url: "groupmAccept.do",
		type: "post",
		data: JSON.stringify(m),
		contentType: "application/json; charset=utf-8",
		dataType: "json",
		success: function(result){
			location.href="groupMemberManagement.do?gno="+result.group_no;
		},
		error: function(request, status, errorData){
			console.log("error code : " + request.status
					+ "\nMessage : " + request,responseText
					+ "\nError : " + errorData);
		}
	});
}
//가입거절
function mRefuse(no, id){
	
}
</script>
<body>
<br><br><br><br><br><br><br><br><br><br><br>
<h1>회원 관리 목록 페이지</h1>
	<hr><br><h3>모임 멤버 목록</h3>
	<c:forEach var="gm" items="${gm}" varStatus="mem_status">
		<c:if test="${ gm.member_grade  == 3 }">
		<h5>${gm.m_id} : 님</h5>&nbsp;&nbsp;&nbsp;
		<h5>가입 날짜 : ${ gm.member_grade_date }</h5>
		<div class="writelistbtn">
			<button class="rightbtn3" onclick="mExile(${gm.group_no}, '${ gm.m_id }');">추방하기</button>
		</div>
		<br>
		</c:if>
	</c:forEach>
	<hr><br><h3>가입대기자 목록</h3>
	<c:forEach var="gm" items="${gm}" varStatus="mem_status">
		<c:if test ="${ gm.member_grade < 2 }">
		<h5>${gm.m_id} : 님</h5>&nbsp;&nbsp;&nbsp;
		<h5>가입 신청날짜 : ${ gm.member_grade_date }</h5>
		<div class="writelistbtn">
			<button class="rightbtn3" onclick="mAccept(${gm.group_no}, '${ gm.m_id }');">가입 수락</button>
			<button class="rightbtn3" onclick="mRefuse(${gm.group_no}, '${ gm.m_id }');">가입 거절</button>
		</div>
		<br>
		</c:if>
	</c:forEach>
	<hr><br><h3>가입거절한 목록</h3>
	<c:forEach var="gm" items="${gm}" varStatus="mem_status">
		<c:if test ="${ gm.member_grade == 2 }">
		<h5>${gm.m_id} : 님</h5>&nbsp;&nbsp;&nbsp;
		<h5>가입 신청날짜 : ${ gm.member_grade_date }</h5>
		<div class="writelistbtn">
			<button class="rightbtn3" onclick="mAccept(${gm.group_no}, '${ gm.m_id }');">가입 수락</button>
			<button class="rightbtn3" onclick="mRefuse(${gm.group_no}, '${ gm.m_id }');">가입 거절</button>
		</div>
		<br>
		</c:if>
	</c:forEach>
	<div class="writelistbtn">
	<button class="rightbtn3" onclick="javascript:history.go(-1); return false;">이전페이지로 이동</button>
</div>
</body>
</html>