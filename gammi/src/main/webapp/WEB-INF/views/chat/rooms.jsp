<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<script type="text/javascript">
function moveChatRoom(gno, id, chatno, chatroom_name){
	console.log(gno);
	console.log(id);
	console.log(chatno);
	var form = document.createElement('form');
	form.setAttribute('method', 'post');
	form.setAttribute('action','room.do');
	document.charset="utf-8";
	var values = {
			"chatroom_no" : chatno,
			"group_no" : gno,
			"m_id" : id,
			"chatroom_name" : chatroom_name
	};
	for(var key in values){
		var field = document.createElement('input');
		field.setAttribute('type', 'hidden');
		field.setAttribute('name', key);
		field.setAttribute('value', values[key]);
		form.appendChild(field);
	}
	document.body.appendChild(form);
	form.submit();
}
</script>
</head>
<body>
<c:import url="/WEB-INF/views/common/menubar.jsp" />
<div style="background-color: #F7F8F9;">
<br><br><br><br><br>
<div class="container">
    <div>
    	<c:forEach var="room" items="${list}" varStatus="room_status">
        <ul>
        	<li>
	        	<input type="text" name="chatroom_name" value= "${ room.chatroom_name}">
	        	<button onclick="moveChatRoom(${ room.group_no }, '${ sessionScope.loginMember.m_id }', ${ room.chatroom_no },'${ room.chatroom_name }');">이동</button>
        	</li>
        </ul>
        </c:forEach>
    </div>
</div>
<form action="${ pageContext.servletContext.contextPath }/roomP.do" method="post">
    <input type="hidden" name = "group_no" value="${ gno }">
    <input type="hidden" name = "m_id" value="${ sessionScope.loginMember.m_id }">
    <input type="text" name="chatroom_name" ><br>
    <button >개설하기</button>
</form>
<c:import url="/WEB-INF/views/common/somoimsidebar.jsp"/>
</div>
</body>
</html>