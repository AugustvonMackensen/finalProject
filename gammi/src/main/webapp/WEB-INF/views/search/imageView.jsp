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
<script type="text/javascript">

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

function dragover(ev){
	ev.preventDefault();
}

function allowDrop(ev) {
  ev.preventDefault();
  var form = $('#transmitImg');
  $('#imgFile').value = ev.dataTransfer.getData('file');
  form.submit();
}
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
<form id="transmitImg" class="sendImgForm" action="imgTransmission.do" method="post" enctype="multipart/form-data">
	<input type="file" id="imgFile" name="imgFile" class="imgFile" onchange="fileTransmit(this)" accept="image/*">
</form>
</div>
</body>
</html>