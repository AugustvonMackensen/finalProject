<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="resources/js/jquery-3.6.1.min.js"></script>
<script type="text/javascript">
var fileNoArry = new Array();
var fileNameArry = new Array();
function fn_del(value, name, index){
	fileNoArry.push(value);
	fileNameArry.push(name);
	$("#fileNoDel").attr("value", fileNoArry);
	$("#fileNameDel").attr("value", fileNameArry);
	$("#fileName").remove();
	var id = "#fileName_"+index;
	$(id).parent().remove();
}
</script>
</head>
<body>
	<c:import url="/WEB-INF/views/common/menubar.jsp" />
	<br>
	<!-- 원글 수정 폼 -->
	<form action="updategal.do" method="post" enctype="multipart/form-data">
		<input type="hidden" name="gal_no" value="${ gammiGroupGal.gal_no }">
		<input type="hidden" name="group_no" value="${ gammiGroupGal.group_no }">
		<div class="board_wrap">
			<div class="board_title">
				<strong>갤러리수정게시판</strong>
				<p>글 내용을 수정해보세요!</p>
			</div>
			<div class="board_write_wrap">
				<div class="board_write">
					<div class="title">
						<dl>
							<dt>제목</dt>
							<dd>
								<input type="text" placeholder="제목 입력" name="gal_title" required
									value="${ gammiGroupGal.gal_title }">
							</dd>
						</dl>
					</div>
					<div class="info">
						<dl>
							<dt>작성자</dt>
							<dd>
								<input type="text" name="gal_id" readonly
									value="${ sessionScope.loginMember.m_id }">
							</dd>
						</dl>
						<dl>
							<dt>첨부파일</dt>
							<<input multiple="multiple" type="file" name="file" />
							<dd>
							<dt style="overflow: overlay; height: 100pt; width: 370pt;">
							<<기존 제거할 파일>>
							<table id="file_table">
								<td id="fileIndex">
								<c:forEach var="file" items="${imgs}" varStatus="var">
										<div>
											<input type="hidden" id="FILE_NO" name="FILE_NO_${var.index}" value="${file.galimg_no }">
											<input type="hidden" id="FILE_NAME" name="FILE_NAME" value="FILE_NO_${var.index}">
											<a href="#" id="fileName_${var.index }" onclick="return false;">${file.gal_ori_image}
											<button id="fileDel_${var.index }" onclick="fn_del('${file.galimg_no}','${file.gal_rename_image }','${var.index }');" type="button">삭제</button>
											</a>
											<br>
										</div>
								</c:forEach>
				</td>
								</table>
							</dt>
							</dd>
						</dl>

					</div>
					<div class="cont">
						<textarea placeholder="내용 수정" name="gal_content" required>${gammiGroupGal.gal_content }</textarea>
					</div>
				</div>
				<div class="bt_wrap">
					<input class="rightbtn7" type="submit" value="등록하기"> &nbsp;
					<input class="rightbtn9" type="reset" value="작성취소"> &nbsp;
					<button class="rightbtn8"
						onclick="javascript:history.go(-1); return false;">목록</button>
				</div>
			</div>
		</div>
		<input type="hidden" id="fileNoDel" name="fileNoDel[]" value="">
		<input type="hidden" id="fileNameDel" name="fileNameDel[]" value="">
	</form>
	<!-- 댓글/대댓글 수정 폼 -->
	<br>
	<hr>
	<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</body>
</html>