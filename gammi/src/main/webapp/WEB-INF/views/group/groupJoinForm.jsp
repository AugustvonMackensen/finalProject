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
                    title: '가입신청 완료!!',
                    timer: 2000,
                }).then(function(){
                	var form = document.createElement('form');
                	form.setAttribute('method', 'post');
                	form.setAttribute('action','applicationGroup.do');
                	document.charset="utf-8";
                	var values = {
                			"group_no": ${group.group_no},
                			"m_id": "${ sessionScope.loginMember.m_id }"
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
                });
            });
        });

</script>
</head>
<body>
	<c:import url="/WEB-INF/views/common/menubar.jsp" />
<div class="bgc">

	<div style="height: 100%; display:flex; justify-content: center; align-items:center; min-height: 100vh; width:1000px;" class="container">

		<form action="applicationGroup.do" align="center" method="post">
			<div style="border :1px solid; width:500px; height : 450px; border-radius :20px;">
			<ul style="list-style: none">
			<input type="hidden" name="group_no" value="${ group.group_no }">
			<input type="hidden" name="m_id" value="${ sessionScope.loginMember.m_id }">
			<br><br>

				<li>
				<span style="font-family: 'CookieRun'; font-size: 20px">
				그룹명 : &nbsp;&nbsp;&nbsp;<input type="text"
							style="border: 0 solid black; background: #F7F8F9; font-size : 20px;"
							value="${ group.group_name }" name="group_name" id ="group_name">
				</span>
				</li>
				<li>
				<span style="font-family: 'CookieRun'; font-size: 20px">
				현재 가입인원 : &nbsp;&nbsp;&nbsp;<input type="text"
							style="border: 0 solid black; background: #F7F8F9; font-size : 20px;"
							value="${ memberCount }명">
				</span>
				</li>
				
				<li>
				<span style="font-family: 'CookieRun'; font-size: 20px">
				그룹장 이름 : &nbsp;&nbsp;&nbsp;<input type="text"
							style="border: 0 solid black; background: #F7F8F9; font-size : 20px;"
							value="${ group.group_owner }" name="group_owner">
				</span>
				</li>
				
				<li>
				<span style="font-family: 'CookieRun'; font-size: 20px">
				그룹 설명 : &nbsp;&nbsp;&nbsp;<input type="textarea"
							style="border: 0 solid black; background: #F7F8F9; font-size : 20px;"
							value="${ group.group_info }" name="group_info">
				</span>
				</li>
				<li>
				<div class="writelistbtn">
							<button type="button" class="rightbtn3">가입신청</button>
							<button onclick="javascript:history.go(-1); return false;"
								class="rightbtn3">돌아가기</button>
				</div>
				</li>
			</ul>
			</div>
		</form>
	</div>
	</div>
	<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>