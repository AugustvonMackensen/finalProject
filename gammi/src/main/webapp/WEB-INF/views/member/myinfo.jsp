<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>      
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<script type="text/javascript" src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.1.min.js"></script>
<body>
<h1 align="center">내 정보 보기</h1>
<br>
<table id="outer" align="center" width="500" cellspacing="5" 
cellpadding="0" border="1">
	<tr>
		<th width="120">이 름</th>
		<td>${ requestScope.member.m_name }</td>
	</tr>
	<tr>
		<th width="120">아이디</th>
		<td>${ member.m_id }	</td>
	</tr>	
	<tr>
		<th width="120">닉네임</th>
		<td>${ member.m_nickname }</td>
	</tr>
	<tr>
		<th width="120">생년월일</th>
		<td>${ member.m_birth }</td>
	</tr>
	<tr>
		<th width="120">이메일</th>
		<td>${ member.m_email }</td>
	</tr>
	<<tr>
		<th colspan="2">
			<c:url var="moveup" value="/moveup.do">
				<c:param name="m_id" value="${ member.m_id }"/>
			</c:url>
			<a href="${ moveup }">수정페이지로 이동</a> &nbsp; 
			<c:url var="mdel" value="/mdel.do">
				<c:param name="m_id" value="${ member.m_id }"/>
			</c:url>
			<a href="${ mdel }">탈퇴하기</a> &nbsp; 
			<a href="main.do">시작페이지로 이동</a>
		</th>		
	</tr>
</table>

<hr style="clear:both;">
<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>