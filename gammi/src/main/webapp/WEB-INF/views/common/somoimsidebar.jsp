<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title></title>
</head>
<body>
<br><br><br><br><br><br><br><br><br><br><br><br>
	<div><c:if test="${ group.group_owner eq sessionScope.loginMember.m_id }">
	<h3 style="text-align : center;">그룹장 : ${ group.group_owner }입니다.</h3>
</c:if>
	<div class="menu">
    <ul>
        <li class="il"><a href="groupMemberManagement.do?gno=${group.group_no}" class="item"><div>멤버관리</div></a></li>
        <li class="il"><a href="#" class="item"><div>공지사항</div></a></li>
        <li class="il"><a href="groupgal.do?gno=${ group.group_no}" class="item"><div>갤러리게시판</div></a></li>
        <li class="il"><a href="#" class="item"><div>캘린더</div></a></li>
        <li class="il"><a href="${ pageContext.servletContext.contextPath }/rooms.do?gno=${ group.group_no}" class="item"><div>자유채팅방</div></a></li>
        <li class="il"><a href="#" class="item"><div>설정</div></a></li>
    </ul>
</div>
</div>
</body>
</html>