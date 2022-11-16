<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
<!-- 절대경로로 대상 파일의 위치를 지정한 경우 -->
<c:import url="/WEB-INF/views/common/menubar.jsp" />
<hr>
<h2 align="center">${ requestScope.notice.notice_num } 번 공지글 상세보기 [관리자용]</h2>
<br>
<table align="center" width="500" border="1" cellspacing="0" 
cellpadding="5">
	<tr><th>제 목</th><td>${ notice.notice_title }</td></tr>
	<tr><th>작성자</th><td>${ notice.notice_writer }</td></tr>
	<tr><th>날 짜</th><td>${ notice.notice_date }</td></tr>
	<tr><th>첨부파일</th>
		<td>
			<!-- 첨부파일이 있다면, 파일명 클릭시 다운로드 실행되게 함 -->
			<c:if test="${ !empty notice.notice_original_filename }">
				<c:url var="nfd" value="/nfdown.do">
					<c:param name="ofile" value="${ notice.notice_original_filename }" />
					<c:param name="rfile" value="${ notice.notice_rename_filename }" />
				</c:url>
				<a href="${ nfd }">${ notice.notice_original_filename }</a>
			</c:if>
			<!-- 첨부파일이 없다면 공백으로 처리함 -->
			<c:if test="${ empty notice.notice_original_filename }">
				&nbsp;
			</c:if>
		</td>
	</tr>
	<tr><th>내 용</th><td>${ notice.notice_content }</td></tr>
	<tr><th>조회수</th><td>${ notice.notice_readcount }</td></tr>
	<tr><th colspan="2">
		<button onclick="javascript:history.go(-1);">목록</button>
		<!-- 수정페이지로 이동 버튼 -->
		<c:url var="movenup" value="/nmoveup.do">
			<c:param name="notice_num" value="${ notice.notice_num }" />			
		</c:url>
		<button onclick="javascript:location.href='${ movenup }';">수정페이지로 이동</button>
		<!-- 삭제하기 버튼 -->
		<c:url var="ndel" value="/ndel.do">
			<c:param name="notice_num" value="${ notice.notice_num }" />
			<c:param name="rfile" value="${ notice.notice_rename_filename }" />
		</c:url>
		<button onclick="javascript:location.href='${ ndel }';">글삭제</button>
	</th></tr>
</table>
<br>
<hr>
<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>