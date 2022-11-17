<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<link rel="stylesheet" href="resources/css/band-clone.css" type="text/css">
<body>
<c:import url="/WEB-INF/views/common/menubar.jsp" />
<c:if test="${ group.group_owner eq sessionScope.loginMember.m_id }">
	<h3>그룹장 : ${ group.group_owner }입니다.</h3>
	<div class="writelistbtn">
	<button class="rightbtn3" onclick = "location.href= '${ pageContext.servletContext.contextPath }/groupMemberManagement.do?gno=${group.group_no }'">멤버 관리</button>
	</div>
</c:if>

<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>