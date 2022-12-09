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
	<link rel="stylesheet" href="resources/css/upload.css">
	<script src="resources/js/upload.js"></script>
	<!-- 절대경로로 대상 파일의 위치를 지정한 경우 -->
	<c:import url="/WEB-INF/views/common/menubar.jsp" />
	<h2 align="center">${ notice.notice_title }수정</h2>
	<!-- form 태그에서 입력된 값들(문자열)과 첨부파일을 같이 전송하려면,
	반드시 enctype 속성을 form 태그에 추가해야 됨
	enctype="multipart/form-data" 값을 지정해야 함
	method="post" 로 지정해야 함
 -->
	<form action="nupdate.do" method="post" enctype="multipart/form-data">
		<input type="hidden" name="notice_num" value="${ notice.notice_num }">
		<c:if test="${ !empty notice.notice_original_filename }">
			<!-- 첨부파일이 있는 공지글이라면 -->
			<input type="hidden" name="notice_original_filename"
				value="${ notice.notice_original_filename }">
			<input type="hidden" name="notice_rename_filename"
				value="${ notice.notice_rename_filename }">
		</c:if>
		<div class="board_wrap">
			<div class="board_title">
				<strong>공지사항[관리자용]</strong>
				<p>공지사항을 빠르고 정확하게 안내해드립니다.</p>
			</div>
			<div class="board_write_wrap">
				<div class="board_write">
					<div class="title">
						<dl>
							<dt>제목</dt>
							<dd>
								<input type="text" name="notice_title"
									value="${ notice.notice_title }">
							</dd>
						</dl>
					</div>
					<div class="info">
						<dl>
							<dt>작성자</dt>
							<dd>
								<input type="text" name="notice_writer" readonly
									value="${ notice.notice_writer }">
							</dd>
						</dl>
						<dl>
							<dt>첨부파일</dt>
							<dd>
								<!-- 원래 첨부파일이 있는 경우 -->
								<c:if test="${ !empty notice.notice_original_filename }">
                            ${ notice.notice_original_filename } &nbsp; 
                            <input type="checkbox" name="delFlag"
										value="yes"> 파일삭제 <br>
								</c:if>
								<br> <input type="file" name="upfile">
							</dd>
						</dl>
					</div>
					<div class="cont">
						<textarea rows="5" cols="50" name="notice_content">${ notice.notice_content }</textarea>
					</div>
				</div>
				<div class="bt_wrap">
					<input class="rightbtn7" type="submit" value="수정하기">&nbsp;
					<input class="rightbtn9" type="reset" value="수정취소"> &nbsp;
					<button type="button" class="rightbtn8" onclick="javascript:history.go(-1);">이전페이지</button>
				</div>
			</div>
		</div>
	</form>
	<br>
	<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>