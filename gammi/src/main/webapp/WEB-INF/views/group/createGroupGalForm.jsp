<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title></title>
<link rel="stylesheet" href="resources/css/style2.css" type="text/css">
<link rel="stylesheet" href="resources/css/media.css" type="text/css">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
$(function(){
	$("#file_add").on('click',function(){ $('#multi-add').click(); });
	var fileListArr = new Array();
	 var toSize = 0;
	 var keyNum = 0;
	 var limit = 0;
	$("#multi-add").on('change',function(){

		var files = $(this)[0].files;

		var fileArr = new Array();

		fileArr = fileListArr;
		limit = toSize;
		for(var i = 0 ; i < files.length ; i++){
			limit = limit + files[i].size;
			if(limit > 20000000){
				alert("첨부파일 용량은 20MB를 넘길수 없습니다.");
				return false;
			}
		}

		for(var i = 0 ; i < files.length ; i++){
			 $('#file_table').append("<tr id=file"+ keyNum +"><td class='txt-c'><button type='button' style='color: #A4A4A4; font-size: large;' class='deleteFile' >X</button></td>"+
						"<td>"+ files[i].name +"</td>"+
						"</tr>");
			 keyNum++;
			 fileArr.push(files[i]);
			 toSize = toSize + files[i].size;
		}


		fileListArr = new Array();
		fileListArr = fileArr;
		$('#totSize').text("");
		$('#totSize').text(Math.floor(toSize / 1000000));
	});
	//파일 delete
	$(document).on("click" , '.deleteFile', function(){
		//삭제할 파일의 아이디
		var DeleteID = $(this).parent().parent().attr('id');

		//삭제하려는 파일의 크기값(텍스트)
		var DeleteFileSize = $(this).parent().next().next().children('p').text();

		//삭제하는 파일의 크기값(바이트)
		var fileSizeByteArr = new Array();
		fileSizeByteArr = DeleteFileSize.split(' ');
		var fileSize = Number(fileSizeByteArr[0]) * 1000;
		
		//배열에서 삭제를 위한 번호
		var DeleteArrNum = DeleteID.substring(DeleteID.length , DeleteID.length -1);
		var fileArr = fileListArr;
		fileArr.splice(DeleteArrNum , 1);
		keyNum = 0
		fileListArr = new Array();
		$('#file_table').children().remove();
		 toSize = 0;
		for(var i = 0 ; i < fileArr.length ; i++){
			 $('#file_table').append("<tr id=file"+ keyNum +"><td class='txt-c'><button type='button' style='color:  #A4A4A4; font-size: large;' class='deleteFile' >X</button></td>"+
						"<td>"+ fileArr[i].name +"</td>"+
						"</tr>");
			 keyNum++;
			 fileListArr.push(fileArr[i]);
			 toSize = toSize + fileArr[i].size;
		}
		limit = toSize;
		$('#totSize').text("");
		$('#totSize').text(Math.floor(toSize / 1000000));
	});
});
</script>
</head>
<body>
	<c:import url="/WEB-INF/views/common/menubar.jsp" />
	<hr>
	<h2 align="center">새로운 모임 생성</h2>

	<form name="fileForm" action="groupgalinsert.do" method="post"
		enctype="multipart/form-data">
		<input type="hidden" name="gno" value="${gno}">
		<div class="board_wrap">
			<div class="board_title">
				<strong>갤러리게시판</strong>
				<p>글쓰기를 통해 사진을 공유해보세요!</p>
			</div>
			<div class="board_write_wrap">
				<div class="board_write">
					<div class="title">
						<dl>
							<dt>제목</dt>
							<dd>
								<input type="text" placeholder="제목 입력" name="gal_title" required>
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
							<!-- <dd><input multiple="multiple" type="file" name="file" />test1.jpg ,test2.jpg</dd> -->
							<dd>
							<input type="file" id="multi-add" class="btn-add" multiple
								style="display: none;" name="file">
							<button type="button" class="btn-add" id="file_add">파일추가</button>
							</dd>
							
							<dt style="overflow: overlay; height: 100pt; width: 370pt;">
							<table id="file_table">
							</table>
							</dt>
						
						</dl>
						
					</div>
					<div class="cont">
						<textarea wrap="hard" placeholder="내용 입력" name="gal_content" required></textarea>
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
	</form>
	<br>
	<hr>
	<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>