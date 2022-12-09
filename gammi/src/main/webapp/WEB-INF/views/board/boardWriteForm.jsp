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
	<!-- 절대경로로 대상 파일의 위치를 지정한 경우 -->
	<c:import url="/WEB-INF/views/common/menubar.jsp" />
	<form action="bwinsert.do" method="post" enctype="multipart/form-data">
		<
		<div class="board_wrap">
			<div class="board_title">
				<strong>자유게시판</strong>
				<p>자유게시판을 빠르고 정확하게 만들어드립니다.</p>
			</div>
			<div class="board_write_wrap">
				<div class="board_write">
					<div class="title">
						<dl>
							<dt>제목</dt>
							<dd>
								<input class="inputds" type="text" name="b_title">
							</dd>
						</dl>
					</div>
					<div class="info">
						<dl>
							<dt>작성자</dt>
							<dd>
								<input class="inputds" type="text" name="b_writer" readonly
									value="${ sessionScope.loginMember.m_id }">
							</dd>
						</dl>
						<dl>
							<dt>첨부파일</dt>
							<dd>
								<!-- 	<input type="file" name="upfile" -->
								<input type="file" name="upfile">
							</dd>
						</dl>
					</div>
					<div class="cont">
						<textarea class="inputdss" rows="5" cols="50" name="b_content"></textarea>
					</div>
				</div>
				<div class="bt_wrap">
				<button type="button" class="rightbtn8" onclick="javascript:location.href='ListView.do';">목록</button>
	                <input class="rightbtn7" type="submit" value="등록하기">
                &nbsp; <input class="rightbtn9" type="reset" value="작성취소"> &nbsp;



				</div>
			</div>
		</div>
	</form>
</body>
</html>







