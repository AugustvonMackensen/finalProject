<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>



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
<script type="text/javascript"
	src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.1.min.js"></script>
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
    
    function Change(){
        var key = test.value;
        if(key==1){
        document.all["d1"].style.display="block";
        document.all["d2"].style.display="none";
        }
        if(key==2){
        document.all["d1"].style.display="none";
        document.all["d2"].style.display="block";
        }
    }
    </script>
</head>
<body>
	<c:import url="/WEB-INF/views/common/menubar.jsp" />
	<c:if test="${ !empty groups }">
	<div class="bgc">
		<br><br><br><br><br>
		<div class="wrap2">
			<h4 style="font-family: 'CookieRun';">
				음식, 취향에 맞는 사람들끼리 <br> 채팅을 즐겨보세요!
			</h4>
			<ul class="container2">
			<c:forEach var="groups" items="${groups}" varStatus="groups_status"> 
				<li class="item">
				<a href = "${ pageContext.servletContext.contextPath }/selectGroup.do?selectGroupNo=${ groups.group_no }">
					<div class="wrap">
						<div class="imgbox">
							<c:if test="${ empty groups.group_img }">
							<img class="img2" src="resources/img/banner.png" alt="무사진">
							</c:if>
							<c:if test="${ !empty groups.group_img }">
							<img class="img2" src="resources/groupImg/${ groups.group_img }" alt="무사진">
							</c:if>
						</div>
					</div>
					<div class="content">
						<div class="nameleader">
							<p class="roomname">소모임이름 : ${ groups.group_name }</p>
							<p class="roomabout">모임 설명 : ${ groups.group_info }</p>
							<p class="roomsize">멤버 명 리더 : ${ groups.group_owner }</p>
						</div>
					</div>
					</a>
				</li>
				</c:forEach>
			</ul>

			<div class="writelistbtn">
				<button class="rightbtn3">목록</button>
				<button class="rightbtn" onclick="javascript:location.href='${ pageContext.servletContext.contextPath }/group.do';">가입목록</button>
				<button class="rightbtn2" onclick="javascript:location.href='creategroupform.do';">모임생성</button>
			</div>
			<br>
			<div
				style="display: flex; justify-content: center; margin: 0px 0px 0px 200px;">
				<select id="test" onchange="Change()"
					style="position: relative; left: -200px; width: 5rem; height: 3rem; border: 2px solid #b5daff; text-align: center">
					<option value="1">제목</option>
					<option value="2">키워드</option>
				</select>
				<div id="d1" style="display: block">
					<form action="qna.do" method="post">
						<input type="search" name="keyword"
							style="width: 20rem; height: 3rem; margin-left: -198px; border: 2px solid #b5daff;">
						<input type="submit" value="검색"
							style="width: 5.5rem; height: 3rem; border: none; background-color: #b5daff; cursor: pointer; margin-top: -3px;"
							class="btn">
					</form>
				</div>
				<div id="d2" style="display: none">
					<form action="qna.do" method="post">
						<input type="search" name="keyword"
							style="width: 20rem; height: 3rem; margin-left: -198px; border: 2px solid #b5daff;">
						<input type="submit" value="검색"
							style="width: 5.5rem; height: 3rem; border: none; background-color: #b5daff; cursor: pointer; margin-top: -3px;"
							class="btn">
					</form>
				</div>
			</div>
		</div>
	</div>
	</c:if>
	<c:if test="${ empty groups }">
			<div style="display: grid;  place-items: center;  min-height: 80vh;">
				<h1 style=" font-family: 'Noto Sans KR', sans-serif;">
				현재 생성된 그룹이 없습니다.
				</h1>
			</div>
			<div class="writelistbtn">
				<button class="rightbtn2" onclick="javascript:location.href='creategroupform.do';">모임생성</button>
			</div>
		</c:if>
	<br>
	<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>