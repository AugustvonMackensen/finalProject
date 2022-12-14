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
    <title>ANDAMIRO | Gammi</title>

    <!-- Google Font -->
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@500;700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Unna:400,700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@700&family=Noto+Sans+KR:wght@500;700&display=swap" rel="stylesheet">
    <!-- Css Styles -->
    <link rel="stylesheet" href="resources/css/media.css" type="text/css">
        <link rel="stylesheet" href="resources/css/css.css">
      <link rel="stylesheet" href="resources/css/style2.css" type="text/css">
    <link rel="stylesheet" href="resources/css/bootstrap.min.css" type="text/css">
    <link rel="stylesheet" href="resources/css/font-awesome.min.css" type="text/css">
    <link rel="stylesheet" href="resources/css/elegant-icons.css" type="text/css">
    <link rel="stylesheet" href="resources/css/owl.carousel.min.css" type="text/css">
    <link rel="stylesheet" href="resources/css/slicknav.min.css" type="text/css">
    <link rel="stylesheet" href="resources/css/style.css" type="text/css">
    <link rel="stylesheet" href="resources/css/groupgal.css" type="text/css">
    <link rel="stylesheet" href="resources/css/sidebar.css" type="text/css">
       <link rel="stylesheet" href="resources/css/admin.css" type="text/css">
              <link rel="stylesheet" href="resources/css/tooltip.css" type="text/css">
    <link href="https://webfontworld.github.io/cookierun/CookieRun.css" rel="stylesheet">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@48,400,0,0" />
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
 <header class="header">
        <div class="header__top">
            <div class="container">
                <div class="row">

                    <div class="col-lg-8 col-md-10 order-md-2 order-3">
                    <!-- ???????????? ??????  -->
                        <nav class="header__menu">
                        <!-- ???????????? ??????  -->
                        	<c:if test="${ empty sessionScope.loginMember }">
                            <ul>
                                <li ><a style="font-family: 'Noto Sans KR', sans-serif;" href="main.do">???</a></li>
                                <li><a style="font-family: 'Noto Sans KR', sans-serif;" href="nlist.do">????????????</a></li>
                      			<li><a style="font-family: 'Noto Sans KR', sans-serif;" href="ListView.do">???????????????</a></li>
								<li><a style="font-family: 'Noto Sans KR', sans-serif;" href="group.do">?????????</a></li>
								<li><a style="font-family: 'Noto Sans KR', sans-serif;" href="rlist.do">?????????</a></li>
								<li><a style="font-family: 'Noto Sans KR', sans-serif;" href="newslist.do">??????????????????</a></li>
								<li><a style="font-family: 'Noto Sans KR', sans-serif;" href="${ pageContext.servletContext.contextPath }/enrollPage.do">????????????</a></li>
								<li><a style="font-family: 'Noto Sans KR', sans-serif;" href="${ pageContext.servletContext.contextPath }/loginPage.do">?????????</a></li>
                            </ul>
                            </c:if>
                            <!--????????? ????????????  -->
                            <c:if test="${ !empty sessionScope.loginMember and sessionScope.loginMember.admin ne 'Y' }">
                            <ul>
                                <li ><a style="font-family: 'Noto Sans KR', sans-serif;" href="main.do">???</a></li>
                                <li><a style="font-family: 'Noto Sans KR', sans-serif;" href="nlist.do">????????????</a></li>
                               <li><a style="font-family: 'Noto Sans KR', sans-serif;" href="ListView.do">???????????????</a></li>
								<li><a style="font-family: 'Noto Sans KR', sans-serif;" href="group.do">?????????</a></li>
								<li><a style="font-family: 'Noto Sans KR', sans-serif;" href="rlist.do">?????????</a></li>
								<li><a style="font-family: 'Noto Sans KR', sans-serif;" href="newslist.do">??????????????????</a></li>
								<li>
								<c:url var="callMyinfo" value="/myinfo.do">
									<c:param name="m_id" value="${ loginMember.m_id }" />
								</c:url>
							<a style="font-family: 'Noto Sans KR', sans-serif;" href="${ callMyinfo }">?????????</a></li>
								<li><a style="font-family: 'Noto Sans KR', sans-serif;" href="${ pageContext.servletContext.contextPath }/logout.do">????????????</a></li>
                            </ul>
                            </c:if>
                            
                            <!--????????? ?????????  -->
                            <c:if test="${ !empty sessionScope.loginMember and sessionScope.loginMember.admin eq 'Y' }">
                            <ul>
                                <li ><a style="font-family: 'Noto Sans KR', sans-serif;" href="main.do">???</a></li>
                                <li><a style="font-family: 'Noto Sans KR', sans-serif;" href="nlist.do">????????????</a></li>
                        		<li><a style="font-family: 'Noto Sans KR', sans-serif;" href="ListView.do">???????????????</a></li>
								<li><a style="font-family: 'Noto Sans KR', sans-serif;" href="group.do">?????????</a></li>
								<li><a style="font-family: 'Noto Sans KR', sans-serif;" href="rlist.do">?????????</a></li>
								<li><a style="font-family: 'Noto Sans KR', sans-serif;" href="newslist.do">??????????????????</a></li>
								<li><a style="font-family: 'Noto Sans KR', sans-serif;" href="${ pageContext.servletContext.contextPath }/mlist.do">????????????</a></li>
								<li><a style="font-family: 'Noto Sans KR', sans-serif;" href="${ pageContext.servletContext.contextPath }/logout.do">????????????</a></li>
                            </ul>
                            </c:if>
                        </nav>
                       
                        
                       
                        
                    </div>

                </div>
            </div>
        </div>
        
                <!-- <div>
                    <div class="header__logo">
                        <br><br>
                        <a href="./index.html"><h1  style="font-family: 'CookieRun'; font-size : 50px; color: white; letter-spacing:5px;">????????? ?????????!<br>??????</h1></a><br><br><br>
                        <div class="search-box">
                            <input class="search-txt" type="text" placeholder="????????? ??????????????????.">
                              <button type="button" class="btm_image" id="img_btn" onclick="camSearch();"><img class="btn_image2"  src="resources/img/camera4.png"></button>
                              <button type="button2" class="btm_image2" id="img_btn2" onclick="imgSearch();"><img class="btn_image3"  src="resources/img/picture.png"></button>
                            <input  class="search-button" type="button" value="??????" onclick="keywordSearch();">
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