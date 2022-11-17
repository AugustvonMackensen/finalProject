<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<c:import url="/WEB-INF/views/common/menubar.jsp" />
<c:if test="${ group.group_owner eq sessionScope.loginMember.m_id }">
	<h3>그룹장 : ${ group.group_owner }입니다.</h3>
</c:if>
<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>