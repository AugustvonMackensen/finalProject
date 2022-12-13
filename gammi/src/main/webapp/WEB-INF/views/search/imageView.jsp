<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<style type="text/css">
.imgFile{display: none;}
</style>
<script src="https://unpkg.com/dropzone@5/dist/min/dropzone.min.js"></script>
<link rel="stylesheet" href="https://unpkg.com/dropzone@5/dist/min/dropzone.min.css" type="text/css"/>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
Dropzone.autoDiscover = false;

$(function(){
	$('#imgUpload').click(function(e){
		//기본 클릭 동작 방지
		e.preventDefault();
		$('#imgFile').click();
	});
	

	const dropzone = new Dropzone('div.dropzone', {
		url: 'transmitImg.do',
		method: 'post',
		maxFiles: 1,
		parallelUploads: 1,
		autoQueue: true,
		uploadMultiple: false,
		addRemoveLinks: false,
		acceptedFiles: '.jpeg, .jpg, .png, .JPEG, .PNG, .JPG',
		init: function(){
			var myDropZone = this;
			
			//학습 성공시 처리할 내역
			this.on('success', function(data, response){
				var keyword = response;
				const url = "result.do?keyword=" + keyword;
				location.href = url;
				//const encoded = encodeURI(url);
				//location.href = encoded;
			});
						
			//학습 실패시
			this.on('error', function(data, response){
				alert("에러가 발생하였습니다.");
			});
		}	
	});
	
});

function fileTransmit(fileObj){
	var form = $('#dnd');
	form.submit();
}

function upFileTransmit(fileObj){
	var form = $('#transmitImg');
	form.submit();
}


</script>
</head>
<body>
<div class="imgUploadBtn">
	<button id="imgUpload" class="imgUploadBtn">이미지 업로드</button><br>
</div>
<br><br>
<div id="dropzone" class="dropzone"></div>
<br><br><br>
<!-- input 태그 감추기 -->
<div>
<form id="transmitImg" class="sendImgForm" action="upImg.do" method="post" enctype="multipart/form-data">
	<input type="file" id="imgFile" name="imgFile" class="imgFile" onchange="upFileTransmit(this)" accept="image/*">
</form>

<form id="dnd" class="dragAndDropForm" action="transmitImg.do" method="post" enctype="multipart/form-data">
	<input type="file" id="file" name="file" class="imgFile" onchange="fileTransmit(this)" accept="image/*">
</form>

</div>
</body>
</html>