<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<c:import url="/WEB-INF/views/common/menubar.jsp" /> 
<br>
<br>
<br><br>
<!-- 원글 수정 폼 -->
<form action="updategal.do" method="post" enctype="multipart/form-data">
	<input type="hidden" name="gal_no" value="${ gammiGroupGal.gal_no }">
	<input type="hidden" name="page" value="${ currentPage }">
	<c:if test="${ !empty gal_img.gal_ori_image }">
	<!-- 첨부파일이 있는 공지글이라면 -->
		<input type="hidden" name="gal_ori_image" value="${ gal_img.gal_ori_image }">
		<input type="hidden" name="gal_rename_image" value="${ gal_img.gal_rename_image }">
	</c:if>
<table class="type02" align="center">
	<tr><th scope="row">제 목</th><td><input class="inputds"  type="text" name="gal_title" value="${ gammiGroupGal.gal_title }"></td></tr>
	<tr><th scope="row">작성자</th>
	<td><input class="inputds"  type="text" name="q_writer" readonly value="${ gammiGroupGal.gal_id }"></td></tr>
	<tr><th scope="row">첨부파일</th>
		<td>
			<!-- 원래 첨부파일이 있는 경우 -->
			<c:if test="${ !empty gal_img.gal_ori_image }">
				${ gal_img.gal_rename_image } &nbsp; 
				<input type="checkbox" name="delFlag" value="yes"> 파일삭제 <br>
			</c:if>
			<br>
			새로 첨부 : <input multiple="multiple" type="file" name="file" />
		</td>
	</tr>
	<tr><th scope="row">내 용</th><td><textarea class="inputdss" rows="5" cols="50" name="gal_content">${ gammiGroupGal.gal_content }</textarea></td></tr>
	</table>
	<div class="containerr2">
	<tr><th colspan="2">
		<input class="replybtn" type="submit" value="수정하기"> &nbsp; 
		<input class="replybtn" type="reset" value="수정취소"> &nbsp; 
		<button class="replybtn" onclick="javascript:history.go(-1); return false;">목록</button>
	</th></tr>
</div>
</form>
<!-- 댓글/대댓글 수정 폼 -->
<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</body>
</html>