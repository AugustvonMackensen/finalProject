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
	<div class="board_wrap">
		<div class="board_title">
			<strong>갤러리게시판</strong>
		</div>
		<div class="board_view_wrap">
			<div class="board_view">
				<div class="title">${ gammiGroupGal.gal_title }</div>
				<div class="info">

					<dl>
						<dt>작성자</dt>
						<dd>${ gammiGroupGal.gal_id }</dd>
					</dl>
					<dl>
						<dt>날 짜</dt>
						<dd>${ gammiGroupGal.gal_date }</dd>
					</dl>
				</div>
				<div class="cont">
					<textarea readonly name="gal_content" cols="150"
						style="overflow: auto; height: 220px; border: none; resize: none;">${gammiGroupGal.gal_content }</textarea>
					<c:forEach items="${ gal_img }" var="gal_img">
						<img class="thumb"
							src="resources/groupGalImg/${ gal_img.gal_rename_image }">
											

					</c:forEach>


				</div>

			</div>
			<div class="bt_wrap">
				<c:url var="movenup" value="/updategal2.do">
					<c:param name="gal_no" value="${ gammiGroupGal.gal_no }" />
				</c:url>
				<button class="rightbtn7"
					onclick="javascript:location.href='${ movenup }';">수정하기</button>
				<c:url var="ndel" value="/galdel.do">
					<c:param name="gal_no" value="${ gammiGroupGal.gal_no }" />
					<c:param name="gno" value="${ gammiGroupGal.group_no }" />
				</c:url>
				<button class="rightbtn9" onclick="javascript:location.href='${ ndel }';">글삭제</button>
				<button class="rightbtn8" onclick="javascript:history.go(-1);">목록</button>

				<input class="rightbtn11" type="button" value="댓글달기"
					onclick="javascript:return showreplybox();">
				<div>
					<c:forEach items="${ requestScope.replylist }" var="br">
						<form action="greplyup.do" method="POST">
							<input type="hidden" name="gal_no" value="${ br.gal_no }">
							<input type="hidden" name="page" value="${ currentPage }">
							<hr style="border-bottom: 1px solid #b1b1b1;">
							<div style="display: flex;">
								<input
									style="float: left; border: 0; font-size: 20px; margin: 5px; width: 95px;"
									type="text" name="reply_id" value="${ br.reply_id }" readonly>
								<br>

								<p style="font-size: 20px; margin-top: 7px;">
									<fmt:formatDate value="${ br.reply_date }" pattern="yyyy-MM-dd" />
								</p>
							</div>
							<div>
								<textarea
									style="width: 100%; height: 200px; padding: 10px; box-sizing: border-box; border: solid 2px #000000; border-radius: 5px; font-size: 16px; resize: both;"
									rows="5" cols="100" name="reply_content">${ br.reply_content }</textarea>
								<br>
								<c:if test="${ br.reply_id eq sessionScope.loginMember.m_id }">
									<div style="display: flex; flex-direction: row-reverse;">
										<input class="rightbtn10" type="submit" value="수정">&nbsp;
										<input class="rightbtn9" type="button" value="삭제"
											onclick="javascript:location.href='greplydel.do?gal_no=${ br.gal_no }&reply_no=${ br.reply_no }&page=${ currentPage }';return false;">
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
					<form action="greply.do" method="GET">
						<input type="hidden" name="gal_no"
							value="${ requestScope.gammiGroupGal.gal_no }"> <input
							type="hidden" name="page" value="${ requestScope.currentPage }">
						<input
							style="float: left; border: 0; font-size: 20px; margin: 5px;"
							text" name="reply_id" value="${ sessionScope.loginMember.m_id }"><br>
						<div>
							<textarea
								style="width: 100%; height: 200px; padding: 10px; box-sizing: border-box; border: solid 2px #000000; border-radius: 5px; font-size: 16px; resize: both;"
								rows="5" cols="100" name="reply_content"></textarea>
							<br> <input class="rightbtn10" type="submit" value="등록하기">
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>

	<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>
