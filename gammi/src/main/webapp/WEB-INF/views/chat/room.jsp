<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="now" value="<%=new java.util.Date()%>" />
<fmt:formatDate var="sysTime" value="${now}" pattern="a hh:mm" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<link rel="stylesheet" href="resources/css/band-clone.css" type="text/css">
<style type="text/css">
div.my_user{
	font-style: red;
	text-align: right;
	margin-right: 15pt;
	
}
div.my_user b{
	background-color: Yellow
}

div.other_user{
	color: gray;
}
div.other_user b{
	background-color: #FFFFFF
}
div#msgArea{
	width: 680px;
	height: 430px;
	overflow: auto;
}
</style>
<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script src="https://code.jquery.com/jquery-2.2.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
<script type="text/javascript">
	$(function(){
		$('#msgArea').scrollTop($('#msgArea')[0].scrollHeight)
	 });
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
								str = "<div class = \"my_user\">";
								str += "<b>" + writer + "<br>" +  "${sysTime}"+ " : " + message
								+ "</b>";
						str += "</div>";
								$('#msgArea').append(str);
							} else {
								str = "<div class = \"other_user\">";
								str += "<b>" + writer + "<br> " + message
										+ "</b>"+"     "+"${sysTime}";
								str += "</div>";
								$('#msgArea').append(str);
							}
						}
						$('#msgArea').scrollTop($('#msgArea')[0].scrollHeight)
					});
					//3. send(path, header, message)로 메세지를 보낼 수 있음
					stomp.send('/pub/chat/enter', {}, JSON.stringify({
						chatroom_no : roomNo,
						m_id : username
					}))

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
				$("#msg").keydown(function (key) {
				        if (key.keyCode == 13) {
				        	sm();
				        }
				});
				function sm(){
					var msg = document.getElementById("msg");
					stomp.send('/pub/chat/message', {}, JSON.stringify({
						chatroom_no : roomNo,
						message : msg.value,
						m_id : username
					}));
					msg.value = '';
				};
			});
</script>
</head>
<body>
<c:import url="/WEB-INF/views/common/menubar.jsp" />
<div style="background-color: #F7F8F9;">
<c:import url="/WEB-INF/views/common/somoimsidebar.jsp"/>
<div style="margin-left:10%;padding:1px 16px;height:1000px;">
	<div class="container" style="border-radius: 20px; box-shadow : 5px 5px 5px 5px gray; height: 580px; border: 1px solid; width: 700px;">
		<div class = "writelistbtn" style="text-align: center;">
		<br><br>
		<p>채팅방 ${room.chatroom_name } 입니다. 방장 : ${ room.m_id }</p>
		<input type = "hidden" name = "chatroom_no" value=${ room.chatroom_no }>
		<input type = "hidden" name = "group_no" value=${ room.group_no }>	
			<c:if test="${room.m_id eq roommem.m_id }">
			<form action="roomDelete.do" method="post">
				<input type="hidden" name = "chatroom_no" value=${ room.chatroom_no }>
				<input type ="hidden" name = "group_no" value=${ room.group_no }>
				<button class="rightbtn3" style="width: 7rem;">채팅방 폭파합니다!</button>
			</form>
			</c:if>
		</div>
		<div>
		
			<div id="msgArea">
				<c:if test="${ !empty messages }">
					<c:forEach var="messages" items="${messages}">
						<c:if test="${ messages.m_id eq roommem.m_id }">
						<div class = "my_user">
							<b>${ messages.m_id }<br><fmt:formatDate value="${ messages.cm_time }" pattern="a hh:mm" /> : ${ messages.message }</b>
						</div>
						</c:if>
						<div class = "other_user">
						<c:if test="${ messages.m_id ne roommem.m_id }">
							<b>${messages.m_id}<br>
							${ messages.message }</b>     <fmt:formatDate value="${ messages.cm_time }" pattern="a hh:mm" />
						</c:if>
						</div>
					</c:forEach>
				</c:if>
			</div>
			<div class="col-6" style="margin-top: 30px;">
				<div class="input-group mb-3" style="width: 500px; margin-left: 4.8rem; ">
					<input type="text" id="msg" class="form-control">
					<div class="input-group-append" >
						<button style="background-color: #767676;
    color: white;" class="btn btn-outline-secondary" type="button"
							id="button-send">전송</button>
					</div>
				</div>
			</div>
		</div>
		<div class="col-6"></div>
	</div>
</div>
</div>
</body>
</html>