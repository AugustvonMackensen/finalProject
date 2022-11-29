<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>
<html>
<head>>
<meta charset="UTF-8">
<title></title>
</head>
<body>
<!-- 절대경로로 대상 파일의 위치를 지정한 경우 -->
	<c:import url="/WEB-INF/views/common/menubar.jsp" />
<br>
<br>
<br>
<br>
<table align="center" width="500" border="1" cellspacing="0" cellpadding="5">
	<tr><th>제 목</th><td>${ gammiGroupGal.gal_title }</td></tr>
	<tr><th>작성자</th><td>${ gammiGroupGal.gal_id }</td></tr>
	<tr><th>날 짜</th><td>${ gammiGroupGal.gal_date }</td></tr>
	<tr><th>내 용</th><td>${ gammiGroupGal.gal_content }</td></tr>
	<c:forEach items="${ gal_img }"  var ="gal_img">
	<tr><th>이미지</th><td> <img class="img2" src = "resources/groupGalImg/${ gal_img.gal_rename_image }"></td></tr>
	</c:forEach>
	<tr><th>모임번호</th><td> ${ gammiGroupGal.group_no}</td></tr>

	    <c:url var="movenup" value="/updategal2.do">
			<c:param name="gal_no" value="${ gammiGroupGal.gal_no }" />		
		</c:url>
		 <button onclick="javascript:location.href='${ movenup }';">수정페이지로 이동</button>
        <c:url var="ndel" value="/galdel.do">
			<c:param name="gal_no" value="${ gammiGroupGal.gal_no }" />
			<c:param name="gno" value="${ gammiGroupGal.group_no }" />
		</c:url>
		<button onclick="javascript:location.href='${ ndel }';">글삭제</button>
	<tr><th colspan="2">
		<button onclick="javascript:history.go(-1);">목록</button>
	</th></tr>
	
</table>
<br>
<hr>
<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>
