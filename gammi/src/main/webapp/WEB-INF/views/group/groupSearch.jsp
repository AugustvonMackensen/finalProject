<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<head>
<meta charset="UTF-8">
<meta name="description" content="Foodeiblog Template">
<meta name="keywords" content="Foodeiblog, unica, creative, html">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title></title>

<!-- Google Font -->
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@500;700&display=swap"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css?family=Unna:400,700&display=swap"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@700&family=Noto+Sans+KR:wght@500;700&display=swap"
	rel="stylesheet">
<!-- Css Styles -->
<link rel="stylesheet" href="resources/css/bootstrap.min.css"
	type="text/css">
<link rel="stylesheet" href="resources/css/font-awesome.min.css"
	type="text/css">
<link rel="stylesheet" href="resources/css/elegant-icons.css"
	type="text/css">
<link rel="stylesheet" href="resources/css/owl.carousel.min.css"
	type="text/css">
<link rel="stylesheet" href="resources/css/slicknav.min.css"
	type="text/css">
<link rel="stylesheet" href="resources/css/style.css" type="text/css">
<link rel="stylesheet" href="resources/css/band-clone.css"
	type="text/css">
<link href="https://webfontworld.github.io/cookierun/CookieRun.css"
	rel="stylesheet">
<link rel="preconnect" href="https://fonts.googleapis.com">
<script type="text/javascript">
    function showPopup(hasFilter) {
    	const popup = document.querySelector('#popup');
      
      if (hasFilter) {
      	popup.classList.add('has-filter');
      } else {
      	popup.classList.remove('has-filter');
      }
      
      popup.classList.remove('hide');
    }

    function closePopup() {
    	const popup = document.querySelector('#popup');
      popup.classList.add('hide');
    }
    </script>
</head>
<body>
	<c:import url="/WEB-INF/views/common/menubar.jsp" />
	<br>	<br>	<br>
	<div class="bgc">
		<br>
		<div style="line-height: 3px;">
			<h4 style="font-family: 'CookieRun'; margin-left: 25%;">
				음식, 취향에 맞는 사람들끼리 <br> 채팅을 즐겨보세요!
			</h4>
		</div>
		<br>
		<ul>
			<li>
				<div class="wrap">

					<div class="imgbox">
						<img class="img2" src="resources/img/banner.png" alt="무사진">
					</div>
				</div>
				<div class="content">
					<div class="nameleader">
						<p>소모임이름</p>
						<p>멤버 n 리더 :</p>
					</div>
			</li>
			<br>
			<br>
			<li>
				<div class="wrap">
					<div class="imgbox">
						<img class="img2" src="resources/img/banner.png" alt="무사진">
					</div>
				</div>
				<div class="content">
					<div class="nameleader">
						<p>소모임이름</p>
						<p>멤버 n 리더 :</p>
					</div>
				</div>
			</li>
			<br>
			<br>
			<li>
				<div class="wrap">
					<div class="imgbox">
						<img class="img2" src="resources/img/banner.png" alt="무사진">
					</div>
				</div>
				<div class="content">
					<div class="nameleader">
						<p>소모임이름</p>
						<p>멤버 n 리더 :</p>
					</div>
				</div>
			</li>
			<br>
			<br>
			<li>
				<div class="wrap">
					<div class="imgbox">
						<img class="img2" src="resources/img/banner.png" alt="무사진">
					</div>
				</div>
				<div class="content">
					<div class="nameleader">
						<p>소모임이름</p>
						<p>멤버 n 리더 :</p>
					</div>
				</div>
			</li>
			<br>
			<br>
			<li>
				<div class="wrap">
					<div class="imgbox">
						<img class="img2" src="resources/img/banner.png" alt="무사진">
					</div>
				</div>
				<div class="content">
					<div class="nameleader">
						<p>소모임이름</p>
						<p>멤버 n 리더 :</p>
					</div>
				</div>
			</li>
			<br>
	</div>
	<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>