<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<style>
table.type09 {
  border-collapse: collapse;
  text-align: left;
  line-height: 1.5;
    border: 1px solid #ccc;
}
table.type09 thead th {
  padding: 10px;
  font-weight: bold;
  vertical-align: top;
  color: #369;
  border-bottom: 3px solid #036;
}
table.type09 tbody th {
  width: 150px;
  padding: 10px;
  font-weight: bold;
  vertical-align: top;
  border-top: 1px solid #ccc;
  border-bottom: 1px solid #ccc;
  background: #cedbdf;
}
table.type09 td {
  width: 350px;
  padding: 10px;
  vertical-align: top;
  border-top: 1px solid #ccc;
  border-bottom: 1px solid #ccc;
  text-align: center;
}

</style>
<meta charset="UTF-8">
<title></title>
</head>
<script type="text/javascript"
	src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.1.min.js"></script>
<body>
	<c:import url="/WEB-INF/views/common/menubar.jsp" />
<div class="bgc">	
	<div
		style="height: 100%; display: flex; justify-content: center; align-items: center; min-height: 100vh; width: 1000px;"
		class="container">
		<div>
			<table class="type09">
			<br>
				<h3 style="text-align:center; font-family: 'Noto Sans KR', sans-serif;">내 정보 보기</h3>
				<br>	
				<tbody>
					<tr>
						<th scope="row">이 름</th>
						<td>${ requestScope.member.m_name }</td>
					</tr>
					<tr>
						<th scpoe="row">아이디</th>
						<td>${ member.m_id }</td>
					</tr>
					<tr>
						<th scope="row">닉네임</th>
						<td>${ member.m_nickname }</td>
					</tr>
					<tr>
						<th scope="row">생년월일</th>
						<td>${ member.m_birth }</td>
					</tr>
					<tr>
						<th scope="row">이메일</th>
						<td>${ member.m_email }</td>
					</tr>
					<td colspan="2">
					<c:url var="moveup" value="/moveup.do">
						<c:param name="m_id" value="${ member.m_id }" />
					</c:url>
					<a href="${ moveup }">수정</a> &nbsp;
					<c:url var="mdel" value="/mdel.do">
						<c:param name="m_id" value="${ member.m_id }" />
					</c:url>
					<a href="${ mdel }">탈퇴하기</a> &nbsp;
					<a href="main.do">홈으로</a>
					</td>
			
				</tbody>
			</table>
		</div>
	</div>
	</div>
	<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>