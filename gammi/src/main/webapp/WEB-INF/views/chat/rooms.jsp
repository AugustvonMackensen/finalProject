<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	<c:import url="/WEB-INF/views/common/menubar.jsp" />
	<div style="background-color: #F7F8F9;">
		<c:import url="/WEB-INF/views/common/somoimsidebar.jsp" />
		<div style="padding: 1px 16px; height: 800px; display: flex; margin-left: 20%; max-width: 1100px;">
			<div style="width: 600px;">
				<h4 style=" font-family:'CookieRun';">채팅방을 개설하고<br>이용해보세요!</h4>
				<br>
				<c:if test="${ joinrooms.size() <5 }">
					<div style="text-align: center; width: 500px; margin-left : 50px;">
						<form style="display: flex; justify-content: flex-end;" action="${ pageContext.servletContext.contextPath }/roomP.do"method="post"> 
							<input   type="hidden" name="group_no" value="${ gno }"> <input  type="hidden" name="m_id" value="${ sessionScope.loginMember.m_id }"> <input placeholder="채팅창을 만들어보세요!"  style="height: 33px; padding: 0 10px; border: 1px solid #dddddd; width: 60%; margin-left: 10px"  type="text" name="chatroom_name" required>
							&nbsp;<button style="color: #fff; height: 33px; vertical-align: middle; border: 1px solid #999999; background-color: #999999; cursor: pointer; width: 80px;">개설하기</button>
						</form>
					</div>
				</c:if>
				<div style="width: 500px; text-align: right; margin-left : 50px;">
					<ul style="list-style: none;">
						<li>가입 가능한 채팅방 갯수 : ${ joinrooms.size() } / 5</li>
						<c:forEach var="joinrooms" items="${ joinrooms }">
							<li style="margin: 0px 0px 10px 0;"><input readonly style="height: 66px; padding: 0 10px; border: 1px solid #dddddd; width: 60%;" value="${ joinrooms.chatroom_name }" style="display: inline-block;width: 300px;white-space: nowrap;overflow: hidden; text-overflow: ellipsis;"> 
								<button style="color: #fff; height: 66.5px; vertical-align: middle; border: 1px solid #999999; background-color: #999999; cursor: pointer; width: 65px; margin-left: -6px; margin-top: -6px;"onclick="moveChatRoom(${ joinrooms.group_no }, '${ sessionScope.loginMember.m_id }', ${ joinrooms.chatroom_no },'${ joinrooms.chatroom_name }');">이동</button>
								&nbsp;<button style="color: #fff; height: 66.5px; vertical-align: middle; border: 1px solid #999999; background-color: #999999; cursor: pointer; width: 120px; margin-left: -6px; margin-top: -6px;"onclick="secessionChatRoom(${ joinrooms.group_no }, '${ sessionScope.loginMember.m_id }', ${ joinrooms.chatroom_no },'${ joinrooms.chatroom_name }');">채팅방나가기</button>
							</li>
						</c:forEach>
					</ul>

				</div>
			</div>
			<div class="v-line"></div>
			<div style="margin-left : 150px;" class="container">
				<h4 style=" font-family:'CookieRun';">채팅방 목록을 확인 후<br>
				채팅에 참여해보세요!</h4>
				<br>
				<div style="width: 650px; height: 700px; overflow: scroll;">
					<c:forEach var="room" items="${rooms}" varStatus="room_status">
						<ul style="list-style: none;">
							<li style=" margin: 0px 0px 10px 0; text-align: center;"><input readonly style="height : 66px; padding: 0 10px; border: 1px solid #dddddd; width: 60%; color: #black;" type="text" name="chatroom_name"value="${ room.chatroom_name}">
							<c:if test="${ joinrooms.size() <5 }">
								<button style="color: #fff; height: 66.5px; vertical-align: middle; border: 1px solid #999999; background-color: #999999;cursor: pointer;     width: 65px;     margin-left: -6px; margin-top: -6px;"	
								onclick="moveChatRoom(${ room.group_no }, '${ sessionScope.loginMember.m_id }', ${ room.chatroom_no },'${ room.chatroom_name }');">이동</button>
								</c:if>
							</li>
						</ul>
					</c:forEach>
				</div>
			</div>
		</div>
	</div>
	<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>