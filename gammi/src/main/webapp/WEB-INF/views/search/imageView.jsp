<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<style type="text/css">
.imgFile{display: none;}
.dropbox {
  border: 2px solid rgb(13 110 253 / 25%);
  border-radius: 10px;
  margin-top: 20px;
  padding: 40px;
  text-align: center;
}
</style>
<script type="text/javascript" src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.1.min.js"></script>
<script src="http://unpkg.com/dropzone@5/dist/min/dropzone.min.js"></script>
<script type="text/javascript">

Dropzone.autoDiscover = false; //false 기본으로 함
$(function(){
	$('#imgUpload').click(function(e){
		//기본 클릭 동작 방지
		e.preventDefault();
		$('#imgFile').click();
	});
	
	$("div.dropzone").dropzone({
		url: "imgTransmission.do",
		method: "post",
		enctype: "multipart/form-data",
		autoQueue: true, //드래그 드랍 후 서버 자동 전송 (성공시 전송이라 false)
		maxFiles: 1, //최대 1개의 파일만 업로드 가능
		uploadMultiple: false, //다중업로드 방지
		paramName: "imgFile",
		acceptedFiles: ".jpeg, .jpg, .png, .JPEG, .JPG, .PNG", //jpeg, jpg, png만 허용
		accept: function(file, done){
			done();
		},
		init: function(){
			var myDropZone = this;
			this.on('success', function(){
				location.href = "imgTransmission.do";
			})
		}
	});
});

function fileTransmit(fileObj){
	var form = $('#transmitImg');
	form.submit();
}
</script>
<link rel="stylesheet" href="https://unpkg.com/dropzone@5/dist/min/dropzone.min.css" type="text/css"/>
</head>
<body>
<div class="imgUploadBtn">
	<button id="imgUpload" class="imgUploadBtn">이미지 업로드</button><br>
</div>
<br><br>
<div class="dropzone">
</div>
<br><br><br>
<!-- input 태그 감추기 -->
<div>
<form id="transmitImg" class="sendImgForm" action="imgTransmission.do" method="post" enctype="multipart/form-data">
	<input type="file" id="imgFile" name="imgFile" class="imgFile" onchange="fileTransmit(this)" accept="image/*">
</form>
</div>
</body>
</html>