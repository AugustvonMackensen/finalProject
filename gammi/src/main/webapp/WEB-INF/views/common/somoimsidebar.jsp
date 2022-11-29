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
    <br><br> <br><br>
    <div class="menu">
    <ul class="div_ul">
        <li style="margin-top : 100px;"><a href="groupMemberManagement.do?gno= ${ group.group_no }" class="item"><div>멤버관리</div></a></li>
        <li><a href="#" class="item"><div>공지사항</div></a></li>
        <li><a href="groupgal.do?gno=${ group.group_no}" class="item"><div>갤러리게시판</div></a></li>
        <li><a href="#" class="item"><div>캘린더</div></a></li>
        <li><a href="${ pageContext.servletContext.contextPath }/rooms.do?gno=${ group.group_no}" class="item"><div>자유채팅방</div></a></li>
        <li><a href="#" class="item"><div>설정</div></a></li>
    </ul>
</div>


</body>
</html>