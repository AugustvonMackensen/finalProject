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
<h2 align="center">${ requestScope.board.b_no } 번 공지글 상세보기</h2>
<br>
<table align="center" width="500" border="1" cellspacing="0" 
cellpadding="5">
	<tr><th>제 목</th><td>${ board.b_title }</td></tr>
	<tr><th>작성자</th><td>${ board.b_writer }</td></tr>
	<tr><th>날 짜</th><td>${ board.b_date }</td></tr>
	<tr><th>첨부파일</th>
		<td>
			<!-- 첨부파일이 있다면, 파일명 클릭시 다운로드 실행되게 함 -->
			<c:if test="${ !empty board.b_original_image }">
				<%-- <c:url var="nfd" value="/bfdown.do"> --%>
				 <c:url var="nfd" value="/bdetail.do">
					<c:param name="ofile" value="${ board.b_original_image }" />
					<c:param name="rfile" value="${ board.b_rename_image }" />
				</c:url>
				<a href="${ nfd }">${ board.b_original_image }</a>
			</c:if>
			<!-- 첨부파일이 없다면 공백으로 처리함 -->
			<c:if test="${ empty board.b_original_image }">
				&nbsp;
			</c:if>
		</td>
	</tr>
	<tr><th>내 용</th><td>${ board.b_content }</td></tr>
	<tr><th>조회수</th><td>${ board.b_readcount }</td></tr>
	<tr><th colspan="2">
		<button onclick="javascript:history.go(-1);">목록</button>
		<!-- 수정페이지로 이동 버튼 -->
		<c:url var="movenup" value="/bmoveup.do">
			<c:param name="b_no" value="${ board.b_no }" />			
		</c:url>
		<c:if test="${ !empty sessionScope.loginMember and sessionScope.loginMember.m_id eq board.b_writer }">
		<button onclick="javascript:location.href='${ movenup }';">수정페이지로 이동</button>
		<!-- 삭제하기 버튼 -->
		<c:url var="bdel" value="/bdel.do">
			<c:param name="b_no" value="${ board.b_no }" />
			<c:param name="rfile" value="${ board.b_rename_image }" />
		</c:url>
		<button onclick="javascript:location.href='${ bdel }';">글삭제</button>
		</c:if>
		
		<c:if test="${ !empty sessionScope.loginMember and sessionScope.loginMember.m_id ne board.b_writer }">
		<input type="button" value="댓글달기" onclick="javascript:return showreplybox();">
		</c:if>
	</th></tr>
</table>
<br>
<table class="board-table">
					<c:forEach items="${ requestScope.replylist }" var="br">
						<tbody> 
							<c:if test="${ br.br_id eq loginMember.m_id }">
								<form action="replyup.do" method="POST">
								<input type="hidden" name="b_no" value="${ br.b_no }">
								<input type="hidden" name="page" value="${ currentPage }">
								<tr>
									<td><input type="text" name="br_no" value="${ br.br_no }" readonly></td>
									<td><input type="text" name="br_id" value="${ br.br_id }" readonly></td>
									<td><fmt:formatDate value="${ br.br_date }" pattern="yyyy-MM-dd" /></td>
								</tr>
								<tr colspen="4"><td><textarea rows="5" cols="100" name="br_content">${ br.br_content }</textarea></td>
								</tr>
								
								<tr colspen="4">
									<td align="right" >
										<input type="submit" value="수정">&nbsp; 
										<input type="button" value="삭제" onclick="javascript:location.href='replydel.do?b_no=${ br.b_no }&br_no=${ br.br_no }&page=${ currentPage }';return false;">
									</td>
								</tr>
								</form>
							</c:if>
						</tbody>
					</c:forEach>
				</table>
<script>
	function showreplybox() {
		document.getElementById("replybox").style.display = "inline";
		return false;
	}
</script>
<div id="replybox" style="display: none;">
	
	<form action="breply.do" method="GET">
	<input type="hidden" name="b_no" value="${ requestScope.board.b_no }">
	<input type="hidden" name="page" value="${ requestScope.currentPage }">
	<input type="text" name="br_id" value="${ sessionScope.loginMember.m_id }"><br>
		<textarea rows="5" cols="100" name="br_content"></textarea>
		<input type="submit" value="등록하기">
	</form>
</div>
<hr>
<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>