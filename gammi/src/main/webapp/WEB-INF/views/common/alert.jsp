<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="message" value="${ requestScope.message }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
function test(t){
	location.href = "${ pageContext.servletContext.contextPath }/group.do";
};
</script>
</head>
<body onload="test('${message}');">
</body>
</html>