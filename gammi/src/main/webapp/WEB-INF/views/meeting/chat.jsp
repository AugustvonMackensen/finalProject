	<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	.text_right {
		text-align: right;
	}
	
	.text_left {
		text-align: left;
	}
	.chattingBox {
		padding : 15px;
		border : 1px solid #AAA;
		margin: 10px 0;
	}
</style>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
 
<!-- 웹소켓 객체를 가져올 수 있게해준다 -->
<script
	src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
 
<!-- Zebra-Dialog CDN -->
<!-- <script src="resources/js/dialog/zebra_dialog.src.js"></script>
<link rel="stylesheet" href="resources/css/dialog/zebra_dialog.css" type="text/css" /> -->
 
</head>
<body>
 
	<h1>Chatting Page (id: ${user.m_id})</h1>
	<br>
	<form>
		<div>
			<div>
				<input type="text" id="message" />
				<input type="submit" id="sendBtn" value="전송" />
			</div>
			<br>
			<div class="well" id="chatdata">
				<!-- User Session Info Hidden -->
				<input type="hidden" value='${user.m_id}' id="sessionuserid">
			</div>
		</div>
	</form>
</body>
 
<script>
	//websocket을 지정한 URL로 연결
	var sock = new SockJS("<c:url value="/echo"/>");
	//websocket 서버에서 메시지를 보내면 자동으로 실행된다.
	sock.onmessage = onMessage;
	//websocket 과 연결을 끊고 싶을때 실행하는 메소드
	sock.onclose = onClose;
	console.log(sock);
	
	$(document).ready(function(){
		
		$("form").submit(function() {
			console.log('send message...');
			sendMessage();
			
			$('#message').val('');
			
			$('#message').focus();
			
			
			return false;
		});
		
	});
	
	$(function() {
	});
 
	function sendMessage() {
		//websocket으로 메시지를 보내기
		
		var msg = {
			user : '${user}',
			to : 'jin', // 현재 페이지 작성자의 id를 작성 (강제로하나써놈예제로)
			articleId : '${user.m_id}',
			articleOwner : '${articleOwner}',
			message : $("#message").val()
		};
		
		sock.send(JSON.stringify(msg));
	}
 
	//evt 파라미터는 websocket이 보내준 데이터다.
	function onMessage(evt) { //변수 안에 function자체를 넣음.
		var data = evt.data; // 전달 받은 데이터
		
		//alert(data);
		
		msgData = JSON.parse(data); 
		
		var sessionid = null;
		var message = null;
		
		//current session id//
		var currentuser_session = $('#sessionuserid').val();
		console.log('current session id: ' + currentuser_session);
		
		var target = $('#chattingBox-1');
		
		if(target.length==0){
			$('<div id=\"chattingBox-1\" class=\"chattingBox\"></div>').html('<h3>${user} : 게시물 작성자-'+msgData.group.group_owner+'</h3>').appendTo('body');
			$('#chattingBox-1').append('<hr>')
		}
 
			
 
		// 나와 상대방이 보낸 메세지를 구분하여 출력
		if (msgData.user == currentuser_session) {
			var printHTML = "<div class='well text_right'>";
			printHTML += "<div class='alert alert-info'>";
			printHTML += "<strong>[" + msgData.user + "] -> " + msgData.message
					+ "</strong>";
			printHTML += "</div>";
			printHTML += "</div>";
 
			$('#chattingBox-1').append(printHTML);
		} else {
			var printHTML = "<div class='well text_left'>";
			printHTML += "<div class='alert alert-warning'>";
			printHTML += "<strong>[" + msgData.user + "] -> " + msgData.message
					+ "</strong>";
			printHTML += "</div>";
			printHTML += "</div>";
 
			$('#chattingBox-1').append(printHTML);
		}
 
		console.log('chatting data: ' + data);
 
		/* sock.close(); */
	}
 
	function onClose(evt) {
		$("#data").append("연결 끊김");
	}
</script>
</html>