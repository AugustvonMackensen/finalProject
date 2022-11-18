<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="description" content="Foodeiblog Template">
<meta name="keywords" content="Foodeiblog, unica, creative, html">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title></title>
<!-- Google Font -->
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@500;700&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Unna:400,700&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@700&family=Noto+Sans+KR:wght@500;700&display=swap" rel="stylesheet">
<!-- Css Styles -->
<link rel="stylesheet" href="resources/css/bootstrap.min.css" type="text/css">
<link rel="stylesheet" href="resources/css/font-awesome.min.css" type="text/css">
<link rel="stylesheet" href="resources/css/elegant-icons.css" type="text/css">
<link rel="stylesheet" href="resources/css/owl.carousel.min.css" type="text/css">
<link rel="stylesheet" href="resources/css/slicknav.min.css" type="text/css">
<link rel="stylesheet" href="resources/css/style.css" type="text/css">
<link rel="stylesheet" href="resources/css/band-clone.css" type="text/css">
<link href="https://webfontworld.github.io/cookierun/CookieRun.css" rel="stylesheet">
<link rel="preconnect" href="https://fonts.googleapis.com">
 <script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<script>
$().ready(function () {
            $(".rightbtn3").click(function () {
                Swal.fire({
                    icon: 'success',
                    title: '가입완료!',
                });
            });
        });
</script>
</head>
<body>
	<c:import url="/WEB-INF/views/common/menubar.jsp" />
	
	<div class="container">
		<form action="applicationGroup.do" align="center" method="post">
			<ul style="list-style: none">
			<input type="hidden" name="group_no" value="${ group.group_no }">
			<input type="hidden" name="m_id" value="${ sessionScope.loginMember.m_id }">
				<li>
				<span style="font-family: 'CookieRun'; font-size: 20px">
				그룹명 : &nbsp;&nbsp;&nbsp;<input type="text"
							style="border: 0 solid black;"
							value="${ group.group_name }" name="group_name" id ="group_name"></td>
				</span>
				</li>
				<li>
				<span style="font-family: 'CookieRun'; font-size: 20px">
				현재 가입인원 : &nbsp;&nbsp;&nbsp;<input type="text"
							style="border: 0 solid black;"
							value="${ memberCount }명"></td>
				</span>
				</li>
				
				<li>
				<span style="font-family: 'CookieRun'; font-size: 20px">
				그룹장 이름 : &nbsp;&nbsp;&nbsp;<input type="text"
							style="border: 0 solid black;"
							value="${ group.group_owner }" name="group_owner"></td>
				</span>
				</li>
				
				<li>
				<span style="font-family: 'CookieRun'; font-size: 20px">
				그룹 설명 : &nbsp;&nbsp;&nbsp;<input type="textarea"
							style="border: 0 solid black;"
							value="${ group.group_info }" name="group_info"></td>
				</span>
				</li>
				<li>
				<div class="writelistbtn">
							<button class="rightbtn3">가입신청</button>
							<button onclick="javascript:history.go(-1); return false;"
								class="rightbtn3">돌아가기</button>
				</div>
				</li>
			</ul>
		</form>
	</div>
	<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>