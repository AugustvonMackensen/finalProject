<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<script type="text/javascript" src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.1.min.js"></script>
<script type="text/javascript">
$(function(){
	$.ajax({
		url: "roomsside.do",
		type: "post", //json을 받을 때는 post 지정해야 함
		data: {gno : ${gno}, m_id:"${sessionScope.loginMember.m_id}" },
		dataType: "json",
		success: function(dataObj){
			var objStr = JSON.stringify(dataObj);
			var jsonObj = JSON.parse(objStr);
			var output = $('.div_ul').html();
			for(var i in jsonObj.rooms){
				output+="<li><a class=\"item\" onclick=\"moveChatRoom("+jsonObj.rooms[i].group_no+", "+"\'${ sessionScope.loginMember.m_id }\'"+", "
						+ jsonObj.rooms[i].chatroom_no+", \'" + decodeURIComponent(jsonObj.rooms[i].chatroom_name).replace(/\+/gi, ' ')+"\');\"><div>"+decodeURIComponent(jsonObj.rooms[i].chatroom_name).replace(/\+/gi, " ")
						+"</div></a></li>";
			}
			console.log(output);
			//테이블에 적용
			$('.div_ul').html(output);
		},
		error: function(request, status, errorData){
			console.log("error code : " + request.status
					+ "\nMessage : " + request,responseText
					+ "\nError : " + errorData);
		}
	});
});

function moveChatRoom(gno, id, chatno, chatroom_name){
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

function secessionChatRoom(gno, id, chatno, chatroom_name){
	var form = document.createElement('form');
	form.setAttribute('method', 'post');
	form.setAttribute('action','secessionroom.do');
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
    <br><br> <br><br>
    <div class="menu">
    <ul class="div_ul">
        <li><a href="groupMemberManagement.do?gno= ${ gno }" class="item"><div>멤버관리</div></a></li>
        <li><a href="selectGroup.do?selectGroupNo=${gno }" class="item"><div>모임메인화면</div></a></li>
        <li><a href="groupgal.do?gno=${ gno }" class="item"><div>갤러리게시판</div></a></li>
        <li><a href="#" class="item"><div>캘린더</div></a></li>
        <li><a href="${ pageContext.servletContext.contextPath }/rooms.do?gno=${ gno }" class="item"><div>자유채팅방관리</div></a></li>
        <hr>
    </ul>
</div>
</body>
</html>