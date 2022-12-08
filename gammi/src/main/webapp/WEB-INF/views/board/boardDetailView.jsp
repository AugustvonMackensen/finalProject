<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
	<h2 align="center">${ requestScope.board.b_no }번공지글상세보기</h2>
	<br>
	<div class="board_wrap">
		<div class="board_title">
			<strong>자유게시판</strong>

		</div>
		<div class="board_view_wrap">
			<div class="board_view">
				<div class="title"></div>
				<div class="info">
					<dl>
						<dt>제목</dt>
						<dd>${ board.b_title }</dd>
					</dl>
					<dl>
						<dt>작성자</dt>
						<dd>${ board.b_writer }</dd>
					</dl>
					<dl>
						<dt>날짜</dt>
						<dd>${ board.b_date }</dd>
					</dl>
					<dl>
						<dt>조회수</dt>
						<dd>${ board.b_readcount }</dd>
					</dl>
					<dl>
						<dt>첨부파일</dt>
						<dd>
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
						</dd>
					</dl>
				</div>
				<div class="cont">${ board.b_content }</div>
			</div>
			<div class="bt_wrap">
			<c:url var="movenup" value="/bmoveup.do">
         <c:param name="b_no" value="${ board.b_no }" />         
                </c:url>
			
			<c:if test="${ !empty sessionScope.loginMember and sessionScope.loginMember.m_id eq board.b_writer }">
					<button class="rightbtn7" onclick="javascript:location.href='${ movenup }';">수정하기</button>
					<c:url var="bdel" value="/bdel.do">
						<c:param name="b_no" value="${ board.b_no }" />
						<c:param name="rfile" value="${ board.b_rename_image }" />
					</c:url>
					<button class="rightbtn9" onclick="javascript:location.href='${ bdel }';">글삭제</button>
				</c:if>
						<button class="rightbtn8" onclick="javascript:location.href='${ pageContext.servletContext.contextPath }/ListView.do';">목록</button>
				<c:url var="movenup" value="/bmoveup.do">
					<c:param name="b_no" value="${ board.b_no }" />
				</c:url>
				
				<input class="rightbtn11" type="button" value="댓글달기"
					onclick="javascript:return showreplybox();">
			</div>

		</div>
		<br>
		<div>
			<c:forEach items="${ requestScope.replylist }" var="br">
				<form action="replyup.do" method="POST">
					<input type="hidden" name="b_no" value="${ br.b_no }"> <input
						type="hidden" name="page" value="${ currentPage }">
					<hr style="border-bottom: 1px solid #b1b1b1;">
					<div style="display: flex;">
						<input
							style="float: left; border: 0; font-size: 20px; margin: 5px; width: 95px;"
							type="text" name="br_id" value="${ br.br_id }" readonly>
						<br>
						<p style="font-size: 20px; margin-top: 7px;">
							<fmt:formatDate value="${ br.br_date }" pattern="yyyy-MM-dd" />
						</p>
					</div>
					<div>
						<textarea
							style="width: 100%; height: 200px; padding: 10px; box-sizing: border-box; border: solid 2px #000000; border-radius: 5px; font-size: 16px; resize: both;"
							rows="5" cols="100" name="br_content">${ br.br_content }</textarea>
						<br>
						<c:if test="${ br.br_id eq sessionScope.loginMember.m_id }">
							<div style="display: flex; flex-direction: row-reverse;">
								<input class="rightbtn10" type="submit" value="수정">&nbsp; 
								<input class="rightbtn9" type="button" value="삭제" onclick="javascript:location.href='replydel.do?b_no=${ br.b_no }&br_no=${ br.br_no }&page=${ currentPage }';return false;">
							</div>
						</c:if>
					</div>
				</form>
			</c:forEach>
		</div>
		<hr style="border-bottom: 1px solid #b1b1b1;">
		<script>
			function showreplybox() {
				document.getElementById("replybox").style.display = "inline";
				return false;
			}
		</script>
		<div id="replybox" style="display: none;">
			<form action="breply.do" method="GET">
				<input type="hidden" name="b_no"
					value="${ requestScope.board.b_no }"> <input type="hidden"
					name="page" value="${ requestScope.currentPage }"> <input
					style="float: left; border: 0; font-size: 20px; margin: 5px;"
					type="text" name="br_id" value="${ sessionScope.loginMember.m_id }"><br>
				<div>
					<textarea
						style="width: 100%; height: 200px; padding: 10px; box-sizing: border-box; border: solid 2px #000000; border-radius: 5px; font-size: 16px; resize: both;"
						rows="5" cols="100" name="br_content" placeholder="내용 입력"></textarea>
					<br> <input class="rightbtn10" type="submit" value="등록하기">
				</div>
		</div>
			</form>
	</div>
	<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>