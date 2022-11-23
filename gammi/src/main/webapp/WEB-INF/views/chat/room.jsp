<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<!-- 합쳐지고 최소화된 최신 CSS -->
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
  <!-- 부가적인 테마 -->
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
  <!-- 합쳐지고 최소화된 최신 자바스크립트 -->
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
  <script src="https://code.jquery.com/jquery-2.2.1.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
<script type="text/javascript">
     $(document).ready(function(){
         var roomName = '${room.name}';
         var roomId = '${room.roomId}';
         var username = "${username}";
         var sockJs = new SockJS("<c:url value="/stomp/chat"/>");
         //1. SockJS를 내부에 들고있는 stomp를 내어줌
         var stomp = Stomp.over(sockJs);
         //2. connection이 맺어지면 실행
         stomp.connect({}, function (){
            console.log("STOMP Connection")
            
            //4. subscribe(path, callback)으로 메세지를 받을 수 있음
            stomp.subscribe("/sub/chat/room/" + roomId, function (chat) {
                var content = JSON.parse(chat.body);
                var writer = content.writer;
                var message = content.message;
                var str = "";
                if(writer === username){
                	str = "<div>";
                    str += "<b>" + writer + " : " + message + "</b>";
                    str += "</div>";
                    $('#msgArea').append(str);
                }
                else{
                    str = "<div>";
                    str += "<b>" + writer + " : " + message + "</b>";
                    str += "</div>";
                    $('#msgArea').append(str);
                }
            });
            //3. send(path, header, message)로 메세지를 보낼 수 있음
            stomp.send('/pub/chat/enter', {}, JSON.stringify({roomId: roomId, writer: username}))
         });
         $("#button-send").on("click", function(e){
             var msg = document.getElementById("msg");
             stomp.send('/pub/chat/message', {}, JSON.stringify({roomId: roomId, message: msg.value, writer: username}));
             msg.value = '';
         });
     });
 </script>
</head>
<body>

	<th:block
		th:replace="~{/layout/basic :: setContent(~{this :: content})}">
		<th:block th:fragment="content">
			<div class="container">
				<div class="col-6">
					<h1>${room.name}방의 접속 : 접속자이름-${username }</h1>
				</div>
				<div>
					<div id="msgArea" >
					
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



		</th:block>
	</th:block>

</body>
</html>