<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="error.jsp" %>
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
    <link href="https://webfontworld.github.io/cookierun/CookieRun.css" rel="stylesheet">
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
    
    function imgSearch(){
    	
    	location.href="imgSearch.do";
    }
    
    function keywordSearch(){
    	location.href="result.do";
    }
    
    function camSearch(){
    	location.href="camSearch.do";
    }
    </script>
</head>
</head>
<body>
 <header class="header">
        <div class="header__top">
            <div class="container">
                <div class="row">

                    <div class="col-lg-8 col-md-10 order-md-2 order-3">

                        <nav class="header__menu">
                            <ul>
                                <li ><a style="font-family: 'Noto Sans KR', sans-serif;" href="main.do">홈</a></li>
                                <li><a style="font-family: 'Noto Sans KR', sans-serif;" href="#">공지사항</a></li>
                                <li><a style="font-family: 'Noto Sans KR', sans-serif;" href="#">자유게시판</a></li>
								<li><a style="font-family: 'Noto Sans KR', sans-serif;" href="group.do">소모임</a></li>
								<li><a style="font-family: 'Noto Sans KR', sans-serif;" href="#">레시피</a></li>
								<li><a style="font-family: 'Noto Sans KR', sans-serif;" href="#">한식관련뉴스</a></li>
								<li><a style="font-family: 'Noto Sans KR', sans-serif;" href="${ pageContext.servletContext.contextPath }/enrollPage.do">회원가입</a></li>
								<li><a style="font-family: 'Noto Sans KR', sans-serif;" href="${ pageContext.servletContext.contextPath }/loginPage.do">로그인</a></li>
                            </ul>
                        </nav>
                    </div>

                </div>
            </div>
        </div>
                <!-- <div>
                    <div class="header__logo">
                        <br><br>
                        <a href="./index.html"><h1  style="font-family: 'CookieRun'; font-size : 50px; color: white; letter-spacing:5px;">음식이 맛있다!<br>감미</h1></a><br><br><br>
                        <div class="search-box">
                            <input class="search-txt" type="text" placeholder="음식을 입력해주세요.">
                              <button type="button" class="btm_image" id="img_btn" onclick="camSearch();"><img class="btn_image2"  src="resources/img/camera4.png"></button>
                              <button type="button2" class="btm_image2" id="img_btn2" onclick="imgSearch();"><img class="btn_image3"  src="resources/img/picture.png"></button>
                            <input  class="search-button" type="button" value="검색" onclick="keywordSearch();">
                          </div>
                    </div>
                </div> -->
    <script src="resources/js/jquery-3.3.1.min.js"></script>
    <script src="resources/js/bootstrap.min.js"></script>
    <script src="resources/js/jquery.slicknav.js"></script>
    <script src="resources/js/owl.carousel.min.js"></script>
    <script src="resources/js/main.js"></script>
    </header>
</body>
</html>