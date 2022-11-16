<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="currentPage" value="${ requestScope.page }" />

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
	<br><br><br><br><br>
	<h2 align="center">${ recipe.recipe_title } 수정</h2>
	<form action="rupdate.do" method="post" enctype="multipart/form-data">
		<input type="hidden" name="recipe_num" value="${ recipe.recipe_num }">
		<c:if test="${ !empty recipe.recipe_original_imgname }">
			<!-- 첨부파일이 있는 공지글이라면 -->
			<input type="hidden" name="recipe_original_imgname"
				value="${ recipe.recipe_original_imgname }">
			<input type="hidden" name="recipe_rename_imgname"
				value="${ recipe.recipe_rename_imgname }">
		</c:if>
		<table align="center" width="500" border="1" cellspacing="0"
			cellpadding="5">
			<tr>
				<th>제 목</th>
				<td><input type="text" name="recipe_title"
					value="${ recipe.recipe_title }"></td>
			</tr>
			<tr>
				<th>작성자</th>
				<td><input type="text" name="recipe_writer" readonly
					value="${ recipe.recipe_writer }"></td>
			</tr>
			<tr>
				<th>첨부파일</th>
				<td>
					<!-- 원래 첨부파일이 있는 경우 --> <c:if
						test="${ !empty recipe.recipe_original_imgname }">
				${ recipe.recipe_original_imgname } &nbsp; 
				<input type="checkbox" name="delFlag" value="yes"> 파일삭제 <br>
				</c:if>
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
				<td><textarea rows="5" cols="105" name="recipe_content">${ recipe.recipe_content }</textarea></td>
			</tr>
			<tr align="center">
				<th colspan="2"><input type="submit" value="수정하기">
					&nbsp; <input type="reset" value="수정취소"> &nbsp;
					<button onclick="javascript:history.go(-1);">취소</button></th>
			</tr>
		</table>
	</form>
	<br>
	<hr>
	
	<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>