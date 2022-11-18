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
	<hr><br><br><br>
	<h4 align="center">새 공지글 등록 페이지</h4>
	<br>
	<form action="ninsert.do" method="post" enctype="multipart/form-data">
		<table align="center" width="500" border="1" cellspacing="0"
			cellpadding="5">
			<tr>
				<th>제 목</th>
				<td><input type="text" name="notice_title"></td>
			</tr>
			<tr>
				<th>작성자</th>
				<td><input type="text" name="notice_writer" readonly
					value="${ sessionScope.loginMember.m_id }"></td>
			</tr>
			<tr>
				<th>첨부파일</th>
				<td>
					<!-- 	<input type="file" name="upfile" -->
					<div class="row">
						<div class="col-md-12">
							<div class="form-group">
								<div class="preview-zone hidden">
									<div class="box2 box-solid">
										<div class="box-header with-border"></div>
										<div class="box-body"></div>
									</div>
								</div>
								<div class="dropzone-wrapper">
									<div class="dropzone-desc">
										<i class="glyphicon glyphicon-download-alt"></i>
										<p>이미지 파일을 업로드</p>
									</div>
									<input type="file" name="upfile" class="dropzone">
								</div>
							</div>
						</div>
					</div>

				</td>
			</tr>
			<tr>
				<th>내 용</th>
				<td><textarea rows="5" cols="50" name="notice_content"></textarea></td>
			</tr>
			<tr>
				<th colspan="2"><input type="submit" value="등록하기">
					&nbsp; <input type="reset" value="작성취소"> &nbsp;
					<button onclick="javascript:history.go(-1);">목록</button></th>
			</tr>
		</table>
	</form>
	<br>
	<hr>
	<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>








