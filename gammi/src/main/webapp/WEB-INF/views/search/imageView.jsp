<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<style type="text/css">
#imgFile{display: none;}
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
function changeValue(obj){
		alert(obj.value);
}

</script>
</head>
<body>
<button id="imgUpload" class="imgUploadBtn">이미지 업로드</button><br>
<!-- input 태그 감추기 -->
<input type="file" id="imgFile" name="imgFile" onchange="changeValue(this)" accept="image/*">

<br><br><br><br><br>
</body>
</html>