<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>
<body>
<div class="cam-wrap">
	<video id="video" playsinline autoplay></video>
</div>
<br>
<button id="snap">촬영하기</button><br>
<canvas id="canvas" width="640" height="480"></canvas>
<script>
'use strict';

const video = document.getElementById('video');
const canvas = document.getElementById('canvas');
const snap = document.getElementById('snap');

const constraints = {
		audio: false,
		video: {
			width: 640, height: 480
			
		}
};

//카메라 접속
async function init(){
	try{
		const stream = await navigator.mediaDevices.getUserMedia(constraints);
		handleSuccess(stream);
	}
	catch(e){
		alert("카메라가 연결되지 않았거나 카메라 연결 시 문제가 있습니다.");
	}
}

//카메라 접속 성공 시 
function handleSuccess(stream){
	window.stream = stream;
	video.srcObject = stream;
}

init();

//이미지 그리기
var context = canvas.getContext('2d');
snap.onclick = function(){
	context.drawImage(video, 0, 0, 640, 480);
	var img = canvas.toDataURL("image/png"); //canvas를 png 파일로 저장
	
	img = img.replace("data:image/png;base64,","");
	
	$.ajax({
		type: "post",
		data: {
			"img" : img
		},
		url: "transmitCam.do",
		success: function(response){
			console.log("success");
			var keyword = response;
			location.href = "result.do?keyword=" + keyword;
		},
		error: function(a, b, c){
			alert("error");
		}
	});
}


</script>
</body>
</html>