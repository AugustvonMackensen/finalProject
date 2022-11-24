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
<script src="https://unpkg.com/dropzone@5/dist/min/dropzone.min.js"></script>
<link rel="stylesheet" href="https://unpkg.com/dropzone@5/dist/min/dropzone.min.css" type="text/css"/>
<script type="text/javascript" src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.1.min.js"></script>
<script type="text/javascript">
Dropzone.autodiscover = false;
$(function(){
	$('#imgUpload').click(function(e){
		//기본 클릭 동작 방지
		e.preventDefault();
		$('#imgFile').click();
	});
	
});

function fileTransmit(fileObj){
	var form = $('#transmitImg');
	form.submit();
}

const dropzone = new Dropzone('div.my-dropzone', {
	url: 'transmitImg.do',
	method: 'post',
	maxFiles: 1,
	uploadMultiple: false,
	acceptedFiles: '.jpeg, .jpg, .png, .JPEG, .PNG, .JPG',
	init: function(){
		var myDropZone = this;
		
		//학습 성공시 처리할 내역
		this.on('success', function(file){
			console.log("드래그 앤 드랍 및 학습 성공");
		});
		
		//학습 실패시
		this.on('error', function(file){
			alert("에러가 발생하였습니다.");
		});
	}
})
</script>
</head>
<body>
<div class="imgUploadBtn">
	<button id="imgUpload" class="imgUploadBtn">이미지 업로드</button><br>
</div>
<br><br>
<div id="dropbox" class="dropbox" ondrop="drop(event)" ondragover="allowDrop(event)">이미지를 드래그해주세요!</div>
<br><br><br>
<!-- input 태그 감추기 -->
<div>
<form id="transmitImg" class="sendImgForm" action="transmitImg.do" method="post" enctype="multipart/form-data">
	<input type="file" id="imgFile" name="imgFile" class="imgFile" onchange="fileTransmit(this)" accept="image/*">
</form>
</div>
</body>
</html>