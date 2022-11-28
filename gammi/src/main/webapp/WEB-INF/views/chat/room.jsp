<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- 부가적인 테마 -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script src="https://code.jquery.com/jquery-2.2.1.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
<script type="text/javascript">
	$(document).ready(
			function() {
				var roomName = '${room.chatroom_name}';
				var roomNo = '${room.chatroom_no}';
				var username = "${roommem.m_id }";

				var sockJs = new SockJS("<c:url value="/stomp/chat"/>");
				//1. SockJS를 내부에 들고있는 stomp를 내어줌
				var stomp = Stomp.over(sockJs);
				//2. connection이 맺어지면 실행
				stomp.connect({}, function() {
					console.log("STOMP Connection")

					//4. subscribe(path, callback)으로 메세지를 받을 수 있음
					stomp.subscribe("/sub/chat/room/" + roomNo, function(chat) {
						var content = JSON.parse(chat.body);
						var writer = content.m_id;
						var message = content.message;
						var str = "";
						if (message != null) {
							if (writer === username) {
								str = "<div>";
								str += "&nbsp;&nbsp;&nbsp;&nbsp;" + "<b>" + writer
										+ " : " + message + "</b>";
								str += "</div>";
								$('#msgArea').append(str);
							} else {
								str = "<div>";
								str += "<b>" + writer + " : " + message
										+ "</b>";
								str += "</div>";
								$('#msgArea').append(str);
							}
						}
					});
					//3. send(path, header, message)로 메세지를 보낼 수 있음
					stomp.send('/pub/chat/enter', {}, JSON.stringify({
						chatroom_no : roomNo,
						m_id : username
					}))

					/* 메시지 출력 */

				});
				$("#button-send").on("click", function(e) {
					var msg = document.getElementById("msg");
					stomp.send('/pub/chat/message', {}, JSON.stringify({
						chatroom_no : roomNo,
						message : msg.value,
						m_id : username
					}));
					msg.value = '';
				});
			});
</script>
</head>
<body>
<c:import url="/WEB-INF/views/common/menubar.jsp" />
<div style="    background-color: #F7F8F9;">
<c:import url="/WEB-INF/views/common/somoimsidebar.jsp"/>
	<div class="container">
		<div class="col-6">
			<h1>[[${room.chatroom_name}]]방의접속 : 방장 닉네임-${ room.m_id }</h1>
			<c:if test="${room.m_id eq roommem.m_id }">
			<form action="roomDelete.do" method="post">
				<input type = "text" name = "chatroom_no" value=${ room.chatroom_no }>
				<input type = "text" name = "group_no" value=${ room.group_no }>
				<button>채팅방 폭파합니다!</button>
			</form>
			</c:if>
		</div>
		<div>

			<div id="msgArea">
				<c:if test="${ !empty messages }">
					<c:forEach var="messages" items="${messages}">
						<div>
							<c:if test="${ messages.m_id eq roommem.m_id }">
							&nbsp;&nbsp;&nbsp;&nbsp;<b>${messages.m_id} : ${ messages.message }</b>
							</c:if>
							<c:if test="${ messages.m_id ne roommem.m_id }">
								<b>${messages.m_id} : ${ messages.message }</b>
							</c:if>
						</div>
					</c:forEach>
				</c:if>
			</div>
			<div class="col-6">
				<div class="input-group mb-3">

					<input type="text" id="msg" class="form-control">
					<div class="input-group-append">
						<button class="btn btn-outline-secondary" type="button"
							id="button-send">전송</button>
					</div>
				</div>
			</div>
		</div>
		<div class="col-6"></div>
	</div>
</body>
</html>