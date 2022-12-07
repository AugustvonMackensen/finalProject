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
<link rel="stylesheet" href="resources/css/bootstrap.min.css" 	type="text/css">
<link rel="stylesheet" href="resources/css/font-awesome.min.css"	type="text/css">
<link rel="stylesheet" href="resources/css/elegant-icons.css"	type="text/css">
<link rel="stylesheet" href="resources/css/owl.carousel.min.css"	type="text/css">
<link rel="stylesheet" href="resources/css/slicknav.min.css"	type="text/css">
<link rel="stylesheet" href="resources/css/style.css" type="text/css">
<link rel="stylesheet" href="resources/css/band-clone.css" type="text/css">
<link href="https://webfontworld.github.io/cookierun/CookieRun.css"	rel="stylesheet">
<link rel="preconnect" href="https://fonts.googleapis.com">
<script type="text/javascript"
	src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.1.min.js"></script>
<script type="text/javascript">
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
							<img class="img2" src = "resources/groupImg/${ groups.group_img }">
							</c:if>
						</div>
					</div>
					<div class="content">
						<div class="nameleader">
							<p class="roomname">소모임이름 : ${ groups.group_name }</p>
							<p class="roomabout">모임 설명 : ${ groups.group_info }</p>
							<p class="roomsize">모임 리더 : ${ groups.group_owner }</p>
							<p class="roomabout">${ groups.total_mem }/10명</p>
						</div>
					</div>
					</a>
				</li>
				</c:forEach>
			</ul>

			<div class="writelistbtn">
				<button class="rightbtn3" onclick="javascript:location.href='group.do'">전체목록</button>
				<button class="rightbtn" onclick="javascript:location.href='joinGroup.do';">가입목록</button>
				<button class="rightbtn2" onclick="javascript:location.href='creategroupform.do';">모임생성</button>
			</div>
			<br>
			<div style="display: flex; justify-content: center; margin: 0px 0px 0px 200px;">
				<select id="test" onchange="Change()"
					style="position: relative; border: 1px solid #ccc; left: -198px; width:5rem; height:3rem;  text-align:center">
					<option value="1">제목</option>
					<option value="2">그룹장아이디</option>
				</select>
				<div id="d1" style="display: block">
					<form action="groupsearchTitle.do" method="post">
						<input type="search" name="keyword" style="width: 26rem;height:3rem; border: 1px solid #ccc; margin-left:-198px; ">
						<input type="submit" value="검색" style="width: 5.5rem;height:3rem;border:none; margin-left: -7px; background: #555;color: #fff; cursor:pointer;  margin-top:-3px;" class="btn">
					</form>
				</div>
				<div id="d2" style="display: none">
					<form action="groupsearchOwner.do" method="post">
						<input type="search" name="keyword" style="width: 26rem;height:3rem; border: 1px solid #ccc; margin-left:-198px; ">
						<input type="submit" value="검색" style="width: 5.5rem;height:3rem;border:none; margin-left: -7px; background: #555;color: #fff; cursor:pointer;  margin-top:-3px;" class="btn">
					</form>
				</div>
			</div>
		</div>
		<br>
	</div>
	</c:if>
	<c:if test="${ empty groups }">
			<div style="display: grid;  place-items: center;  min-height: 80vh;">
				<h1 style=" font-family: 'Noto Sans KR', sans-serif;">
				해당하는 모임이 없습니다.
				</h1>
			</div>
			<div class="writelistbtn">
				<button class="rightbtn3" onclick="javascript:location.href='group.do'">전체목록</button>
				<button class="rightbtn2" onclick="javascript:location.href='creategroupform.do';">모임생성</button>
			</div>
		</c:if>
	
	<!-- 으아아아아아아아아아아아아아아아아아아아아 -->
	<c:if test="${ empty action }">
		<!-- 전체 목록 페이징 처리 -->

		<div style="text-align: center;">
			<!-- 페이지 표시 영역 -->
			<!-- 1페이지로 이동 처리 -->
			<c:if test="${ currentPage eq 1 }">
		[맨처음] &nbsp;
	</c:if>
			<c:if test="${ currentPage > 1 }">
				<c:url var="bl" value="/group.do">
					<c:param name="page" value="1" />
				</c:url>
				<a href="${ bl }">[맨처음]</a> &nbsp;
	</c:if>
			<!-- 이전 페이지그룹으로 이동 처리 -->
			<c:if
				test="${ (currentPage - 10) < startPage and (currentPage - 10) > 1 }">
				<c:url var="bl2" value="/group.do">
					<c:param name="page" value="${ startPage - 10 }" />
				</c:url>
				<a href="${ bl2 }">[이전그룹]</a> &nbsp;
			
			<c:if
				test="${ !((currentPage - 10) < startPage and (currentPage - 10) > 1) }">
		[이전그룹] &nbsp;
	</c:if>
	</c:if>
			<!-- 현재 페이지가 속한 페이지 그룹 페이지 숫자 출력 -->
			<c:forEach var="p" begin="${ startPage }" end="${ endPage }" step="1">
				<c:if test="${ p eq currentPage }">
					<font size="4" color="red"><b>[${ p }]</b></font>
				</c:if>
				<c:if test="${ p ne currentPage }">
					<c:url var="bl3" value="/group.do">
						<c:param name="page" value="${ p }" />
					</c:url>
					<a href="${ bl3 }"><font color="blue">${ p }</font></a>
				</c:if>
			</c:forEach>
			<!-- 다음 페이지그룹으로 이동 처리 -->
			<c:if
				test="${ (currentPage + 10) > endPage and (currentPage + 10) < maxPage }">
				<c:url var="bl4" value="/group.do">
					<c:param name="page" value="${ endPage + 10 }" />
				</c:url>
				<a href="${ bl4 }">[다음그룹]</a> &nbsp;
	
			<c:if
				test="${ !((currentPage + 10) > endPage and (currentPage + 10) < maxPage) }">
		[다음그룹] &nbsp;
	</c:if></c:if>
			<!-- 끝페이지로 이동 처리 -->
			<c:if test="${ currentPage eq maxPage }">
		[맨끝] &nbsp; 
	</c:if>
			<c:if test="${ currentPage < maxPage }">
				<c:url var="bl5" value="/group.do">
					<c:param name="page" value="${ maxPage }" />
				</c:url>
				<a href="${ bl5 }">[맨끝]</a> &nbsp;
	</c:if>
		</div>
	</c:if>


	<!-- 검색 목록 페이징 처리 -->
	<c:if test="${ !empty action }">

		<div style="text-align: center;">
			<!-- 페이지 표시 영역 -->
			<!-- 1페이지로 이동 처리 -->
			<c:if test="${ currentPage eq 1 }">
		 [맨처음] &nbsp;
	</c:if>
			<c:if test="${ currentPage > 1 }">
				<c:if test="${ action eq 'title' }">
					<c:url var="nsl" value="groupsearchTitle.do">
						<c:param name="keyword" value="${ keyword }" />
						<c:param name="page" value="1" />
					</c:url>
				</c:if>
				<c:if test="${ action eq 'owner' }">
					<c:url var="nsl" value="groupsearchOwner.do">
						<c:param name="keyword" value="${ keyword }" />
						<c:param name="page" value="1" />
					</c:url>
				</c:if>
				<a href="${ nsl }">[맨처음]</a> &nbsp;
	</c:if>
			<!-- 이전 페이지그룹으로 이동 처리 -->
			<c:if
				test="${ (currentPage - 10) < startPage and (currentPage - 10) > 1 }">
				<c:if test="${ action eq 'title' }">
					<c:url var="nsl" value="groupsearchTitle.do">
						<c:param name="keyword" value="${ keyword }" />
						<c:param name="page" value="${ startPage - 10 }" />
					</c:url>
				</c:if>
				<c:if test="${ action eq 'owner' }">
					<c:url var="nsl" value="groupsearchOwner.do">
						<c:param name="keyword" value="${ keyword }" />
						<c:param name="page" value="${ startPage - 10 }" />
					</c:url>
				</c:if>
				<a href="${ nsl }">[이전그룹]</a> &nbsp;
	
			<c:if
				test="${ !((currentPage - 10) < startPage and (currentPage - 10) > 1) }">
		[이전그룹] &nbsp;
	</c:if></c:if>
			<!-- 현재 페이지가 속한 페이지 그룹 페이지 숫자 출력 -->
			<c:forEach var="p" begin="${ startPage }" end="${ endPage }" step="1">
				<c:if test="${ p eq currentPage }">
					<font size="4" color="red"><b>[${ p }]</b></font>
				</c:if>
				<c:if test="${ p ne currentPage }">
					<c:if test="${ action eq 'title' }">
						<c:url var="nsl" value="groupsearchTitle.do">
							<c:param name="keyword" value="${ keyword }" />
							<c:param name="page" value="${ p }" />
						</c:url>
					</c:if>
					<c:if test="${ action eq 'owner' }">
					<c:url var="nsl" value="groupsearchOwner.do">
						<c:param name="keyword" value="${ keyword }" />
						<c:param name="page" value="${ p }" />
					</c:url>
					</c:if>
					<a href="${ nsl }"><font color="blue">${ p }</font></a>
				</c:if>
			</c:forEach>
			<!-- 다음 페이지그룹으로 이동 처리 -->
			<c:if
				test="${ (currentPage + 10) > endPage and (currentPage + 10) < maxPage }">
				<c:if test="${ action eq 'title' }">
					<c:url var="nsl" value="groupsearchTitle.do">
						<c:param name="keyword" value="${ keyword }" />
						<c:param name="page" value="${ endPage + 10 }" />
					</c:url>
				</c:if>
				<c:if test="${ action eq 'owner' }">
					<c:url var="nsl" value="groupsearchOwner.do">
						<c:param name="keyword" value="${ keyword }" />
						<c:param name="page" value="${ endPage + 10 }" />
					</c:url>
				</c:if>
				<a href="${ nsl }">[다음그룹]</a> &nbsp;
	
			<c:if
				test="${ !((currentPage + 10) > endPage and (currentPage + 10) < maxPage) }">
		[다음그룹] &nbsp;
	</c:if></c:if>
			<!-- 끝페이지로 이동 처리 -->
			<c:if test="${ currentPage eq maxPage }">
		[맨끝] &nbsp; 
	</c:if>
			<c:if test="${ currentPage < maxPage }">
				<c:if test="${ action eq 'title' }">
					<c:url var="nsl" value="groupsearchTitle.do">
						<c:param name="keyword" value="${ keyword }" />
						<c:param name="page" value="${ maxPage }" />
					</c:url>
				</c:if>
				<c:if test="${ action eq 'owner' }">
					<c:url var="nsl" value="groupsearchOwner.do">
						<c:param name="keyword" value="${ keyword }" />
						<c:param name="page" value="${ maxPage }" />
					</c:url>
				</c:if>
				<a href="${ nsl }">[맨끝]</a> &nbsp;
	</c:if>
		</div>
	</c:if>
	<!-- 검색 목록 페이징 처리 -->
	
	<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>