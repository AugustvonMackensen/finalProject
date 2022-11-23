<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script src="https://code.jquery.com/jquery-2.2.1.min.js"></script>
<script type="text/javascript">
	function t(id)
	{
		console.log(id);
		location.href="/chat/room/roomId="+id;
		alert("d?");
	}
</script>
<body>
<th:block th:replace="~{/layout/basic :: setContent(~{this :: content})}">
    <th:block th:fragment="content">
         <form action= "${ pageContext.servletContext.contextPath }/chat/room">
        <div class="container">
            <div>
            	<c:forEach var="room" items="${list}" varStatus="room_status">
                <ul>
                	<li><input text="text" id = "username" name = "username" value="">&nbsp;&nbsp;<input text="hidden" name="name" value="${ room.name }">
        &nbsp;&nbsp;<input type="text" name="roomId" value= "${ room.roomId}">
        &nbsp;&nbsp;<button>이동</button></li>
                </ul>
                </c:forEach>
            </div>
        </div>
        </form>
        <form action="${ pageContext.servletContext.contextPath }/chat/roomP" method="post">
            <input type="text" name="name" class="form-control">
            <button class="btn btn-secondary">개설하기</button>
        </form>
    </th:block>
</th:block>

</body>
</html>