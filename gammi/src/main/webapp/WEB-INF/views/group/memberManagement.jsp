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
//멤버 상태 변경(가입수락, 가입 거부 처리, 추방처리)
function mGrade(no, id, num){
	var m = new Object();
	m.group_no = String(no);
	m.m_id=id;
	m.num = String(num);
	$.ajax({
		url: "mGrade.do",
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
</script>
<body>
<c:import url="/WEB-INF/views/common/menubar.jsp" />
<div style="background-color: #F7F8F9;">
<c:import url="/WEB-INF/views/common/somoimsidebar.jsp"/>
<div style="margin-left:25%;padding:1px 16px;height:1000px;">
<h1>회원 관리 목록 페이지</h1>
	<hr><br><h3>모임 멤버 목록</h3>
	<c:forEach var="gm" items="${gm}" varStatus="mem_status">
		<c:if test="${ gm.member_grade  == 3 }">
		<h5>${gm.m_id} : 님</h5>&nbsp;&nbsp;&nbsp;
		<h5>가입 날짜 : ${ gm.member_grade_date }</h5>
		<div class="writelistbtn">
			<button class="rightbtn3" onclick="mGrade(${gm.group_no}, '${ gm.m_id }', 3);">추방하기</button>
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
			<button class="rightbtn3" onclick="mGrade(${gm.group_no}, '${ gm.m_id }', 1);">가입 수락</button>
			<button class="rightbtn3" onclick="mGrade(${gm.group_no}, '${ gm.m_id }', 2);">가입 거절</button>
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
			<button class="rightbtn3" onclick="mAccept(${gm.group_no}, '${ gm.m_id }',1);">가입 수락</button>
			<button class="rightbtn3" onclick="mRefuse(${gm.group_no}, '${ gm.m_id }',2);">가입 거절</button>
		</div>
		<br>
		</c:if>
	</c:forEach>
	<div class="writelistbtn">
	<button class="rightbtn3" onclick="javascript:history.go(-1); return false;">이전페이지로 이동</button>
</div>
</div>
</div>
</body>
</html>