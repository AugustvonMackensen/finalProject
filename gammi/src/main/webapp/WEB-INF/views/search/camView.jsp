<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<style>
#container {
	margin: 0px auto;
	width: 500px;
	height: 375px;
}

#videoElement {
	width: 500px;
	height: 375px;
}

#canvas {
	width: 500px;
	border: 1px solid;
}

.rightbtn3 {
	margin: 20px 0px 20px 0px;
	font-size: 12px;
	width: 5rem;
	border-radius: 10px;
	height: 3.2rem;
	background-color: #fff;
	color: #7c7474;;
	border: 1px solid #aaa;
	font-family: 'Noto Sans KR', sans-serif;
}
</style>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>
<br>
<br>
<div class="bgc">
	<div style="max-width: 1130px; margin: 0 auto;">
		<br>
		<h4 style="font-family: 'CookieRun';">
			사진을 찍어<br> 음식을 검색해보세요!
		</h4>
		<body>
			<c:import url="/WEB-INF/views/common/menubar.jsp" />
			<div id="container">
				<video autoplay="true" id="videoElement">

				</video>
			</div>
			<br>

			<div style="margin: 0 auto; width: 500px">
				<canvas id="canvas" width="640" height="480"></canvas>
				<button class="rightbtn7" id="snap">촬영하기</button>
				&nbsp;
				<button class="rightbtn3"
					onclick="javascript:location.href='main.do';">홈으로</button>
			</div>
	</div>
</div>
<script>
var video = document.querySelector("#videoElement");
 
if (navigator.mediaDevices.getUserMedia) {
	  navigator.mediaDevices.getUserMedia({ video: true })
	    .then(function (stream) {
	      video.srcObject = stream;
	    })
	    .catch(function (err0r) {
	      console.log("Something went wrong!");
	    });
	}
	
	
//이미지 그리기
const snap = document.getElementById("snap");
const canvas = document.getElementById('canvas');
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
<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>