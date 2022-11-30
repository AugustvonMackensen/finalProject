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
		<div style="padding: 1px 16px; height: 1000px;">
			<div style="text-align: center;">
				<h3>현재 가입된 채팅방</h3>
				<div>
				<ul>
				<li>가입 가능한 채팅방 갯수 : ${ joinrooms.size() } / 5</li>
				<c:forEach var = "joinrooms" items="${ joinrooms }">
					<li>채팅방 이름 : ${ joinrooms.chatroom_name }
					<button onclick="moveChatRoom(${ joinrooms.group_no }, '${ sessionScope.loginMember.m_id }', ${ joinrooms.chatroom_no },'${ joinrooms.chatroom_name }');">이동</button>
					<button onclick= "secessionChatRoom(${ joinrooms.group_no }, '${ sessionScope.loginMember.m_id }', ${ joinrooms.chatroom_no },'${ joinrooms.chatroom_name }');">채팅방 나가기</button>
					</li>
				</c:forEach>
				</ul>
				<c:if test="${ joinrooms.size() <5 }">
				<div style="text-align: center;">
				<h4>신규 채팅방 생성</h4>
				<form action="${ pageContext.servletContext.contextPath }/roomP.do"
					method="post">
					<input type="hidden" name="group_no" value="${ gno }"> <input
						type="hidden" name="m_id"
						value="${ sessionScope.loginMember.m_id }"> <input
						type="text" name="chatroom_name">
					<button>개설하기</button>
				</form>
			</div>
				</c:if>
				</div>
			</div>
			<div class="container">
			<h3>전체 채팅방 목록</h3>
				<div>
					<c:forEach var="room" items="${rooms}" varStatus="room_status">
						<ul>
							<li><input type="text" name="chatroom_name" value="${ room.chatroom_name}">
								<c:if test="${ joinrooms.size() <5 }">
								<button onclick="moveChatRoom(${ room.group_no }, '${ sessionScope.loginMember.m_id }', ${ room.chatroom_no },'${ room.chatroom_name }');">이동</button>
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