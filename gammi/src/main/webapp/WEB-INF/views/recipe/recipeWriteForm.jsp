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
	<hr>
	<br><br><br><br>
	<h2 align="center">새 레시피 등록 페이지</h2>

	<form action="rinsert.do" method="post" enctype="multipart/form-data">
		<table align="center" width="500" border="1" cellspacing="0"
			cellpadding="5">
			<tr>
				<th>제 목</th>
				<td><input type="text" name="recipe_title"></td>
			</tr>
			<tr>
				<th>작성자</th>
				<td><input type="text" name="recipe_writer" readonly
					value="${ sessionScope.loginMember.m_id }"></td>
			</tr>
			<tr>
				<th>첨부파일</th>
				<td>
					<div class="preview-zone hidden">
						<div class="box box-solid">
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
				</td>
			</tr>
			<tr>
				<th>내 용</th>
				<td><textarea rows="5" cols="105" name="recipe_content"></textarea></td>
			</tr>
			<tr align="center">
				<th colspan="2"><input type="submit" value="등록하기">
					&nbsp; <input type="reset" value="작성취소"> &nbsp;
					<button onclick="javascript:history.go(-1); return false;">취소</button>
				</th>
			</tr>
		</table>
	</form>
	<br>
	<hr>
	<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>