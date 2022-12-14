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

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
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
				??????, ????????? ?????? <br>????????? ???????????????!
			</h4>
			<ul class="container2">
			<c:forEach var="groups" items="${groups}" varStatus="groups_status"> 
				<li class="item">
			
				<a href = "${ pageContext.servletContext.contextPath }/selectGroup.do?selectGroupNo=${ groups.group_no }">
					<div class="wrap">
						<div class="imgbox">
							<c:if test="${ empty groups.group_img }">
							<img class="img2" src="resources/img/banner.png" alt="?????????">
							</c:if>
							<c:if test="${ !empty groups.group_img }">
							<img class="img2" src = "resources/groupImg/${ groups.group_img }">
							</c:if>
						</div>
					</div>
					<div class="content">
						<div class="nameleader">
							<p class="roomname">??????????????? : ${ groups.group_name }</p>
							<p class="roomabout">?????? ?????? : ${ groups.group_info }</p>
							<p class="roomsize">?????? ?????? : ${ groups.group_owner }</p>
							<p class="roomabout">${ groups.total_mem }/10???</p>
						</div>
					</div>
					</a>
				</li>
				</c:forEach>
			</ul>

			<div class="writelistbtn">
				<button class="rightbtn3" onclick="javascript:location.href='group.do'">????????????</button>
				<button class="rightbtn" onclick="javascript:location.href='joinGroup.do';">????????????</button>
				<button class="rightbtn2" onclick="javascript:location.href='creategroupform.do';">????????????</button>
			</div>
			<br>
			<div style="display: flex; justify-content: center; margin: 0px 0px 0px 200px;">
				<select id="test" onchange="Change()"
					style="position: relative; border: 1px solid #ccc; left: -198px; width:7.5rem; height:3rem;  text-align:center">
					<option value="1">??????</option>
					<option value="2">??????????????????</option>
				</select>
				<div id="d1" style="display: block">
					<form action="groupsearchTitle.do" method="post">
						<input type="search" name="keyword" style="width: 26rem;height:3rem; border: 1px solid #ccc; margin-left:-198px; ">
						<input type="submit" value="??????" style="width: 5.5rem;height:3rem;border:none; margin-left: -7px; background: #555;color: #fff; cursor:pointer;  margin-top:-3px;" class="btn">
					</form>
				</div>
				<div id="d2" style="display: none">
					<form action="groupsearchOwner.do" method="post">
						<input type="search" name="keyword" style="width: 26rem;height:3rem; border: 1px solid #ccc; margin-left:-198px; ">
						<input type="submit" value="??????" style="width: 5.5rem;height:3rem;border:none; margin-left: -7px; background: #555;color: #fff; cursor:pointer;  margin-top:-3px;" class="btn">
					</form>
				</div>
			</div>
		</div>
		<br>

	</c:if>
	<c:if test="${ empty groups }">
			<div style="display: grid;  place-items: center;  min-height: 80vh;">
				<h1 style=" font-family: 'Noto Sans KR', sans-serif;">
				???????????? ????????? ????????????.
				</h1>
			</div>
			<div class="writelistbtn">
				<button class="rightbtn3" onclick="javascript:location.href='group.do'">????????????</button>
				<button class="rightbtn2" onclick="javascript:location.href='creategroupform.do';">????????????</button>
			</div>
		</c:if>
	
	<!-- ??????????????????????????????????????????????????????????????? -->
	<c:if test="${ empty action }">
		<!-- ?????? ?????? ????????? ?????? -->

		<div style="text-align: center;">
			<!-- ????????? ?????? ?????? -->
			<!-- 1???????????? ?????? ?????? -->
			<c:if test="${ currentPage eq 1 }">
		[?????????] &nbsp;
	</c:if>
			<c:if test="${ currentPage > 1 }">
				<c:url var="bl" value="/group.do">
					<c:param name="page" value="1" />
				</c:url>
				<a href="${ bl }">[?????????]</a> &nbsp;
	</c:if>
			<!-- ?????? ????????????????????? ?????? ?????? -->
			<c:if
				test="${ (currentPage - 10) < startPage and (currentPage - 10) > 0 }">
				<c:url var="bl2" value="/group.do">
					<c:if test="${currentPage%10==0 }">
						<c:param name="page" value="${ startPage-1 }" />
					</c:if>
					<c:if test="${currentPage%10!=0 }">
						<c:param name="page" value="${ currentPage - (currentPage%10) }" />
					</c:if>
				</c:url>
				<a href="${ bl2 }">[????????????]</a> &nbsp;
	</c:if>
			<!-- ?????? ???????????? ?????? ????????? ?????? ????????? ?????? ?????? -->
			<c:forEach var="p" begin="${ startPage }" end="${ endPage }" step="1">
				<c:if test="${ p eq currentPage }">
					<font size="4" color="red"><b>[${ p }]</b></font>
				</c:if>
				<c:if test="${ p ne currentPage }">
					<c:url var="bl3" value="/group.do">
						<c:param name="page" value="${ p }" />
					</c:url>
					<a href="${ bl3 }">${ p }</a>
				</c:if>
			</c:forEach>
			<!-- ?????? ????????????????????? ?????? ?????? -->
			<c:if
				test="${ (currentPage + 10) > endPage and ((endPage%10)==0) and listCount > ( endPage*limit ) }">
				<c:url var="bl4" value="/group.do">
					<c:param name="page" value="${ endPage + 1 }" />
				</c:url>
				<a href="${ bl4 }">[????????????]</a> &nbsp;
			</c:if>
			<!-- ??????????????? ?????? ?????? -->
			<c:if test="${ currentPage eq maxPage }">
				[??????] &nbsp; 
			</c:if>
			<c:if test="${ currentPage < maxPage }">
				<c:url var="bl5" value="/group.do">
					<c:param name="page" value="${ maxPage }" />
				</c:url>
				<a href="${ bl5 }">[??????]</a> &nbsp;
	</c:if>
		</div>
	</c:if>


	<!-- ?????? ?????? ????????? ?????? -->
	<c:if test="${ !empty action }">

		<div style="text-align: center;">
			<!-- ????????? ?????? ?????? -->
			<!-- 1???????????? ?????? ?????? -->
			<c:if test="${ currentPage eq 1 }">
		 [?????????] &nbsp;
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
				<a href="${ nsl }">[?????????]</a> &nbsp;
	</c:if>
			<!-- ?????? ????????????????????? ?????? ?????? -->
			<c:if test="${ (currentPage - 10) < startPage and (currentPage - 10) > 0 }">
				<c:if test="${ action eq 'title' }">
					<c:url var="nsl" value="groupsearchTitle.do">
						<c:param name="keyword" value="${ keyword }" />
						<c:if test="${currentPage%10==0 }">
							<c:param name="page" value="${ startPage-1 }" />
						</c:if>
						<c:if test="${currentPage%10!=0 }">
							<c:param name="page" value="${ currentPage - (currentPage%10) }" />
						</c:if>
					</c:url>
				</c:if>
				<c:if test="${ action eq 'owner' }">
					<c:url var="nsl" value="groupsearchOwner.do">
						<c:param name="keyword" value="${ keyword }" />
						<c:if test="${currentPage%10==0 }">
							<c:param name="page" value="${ startPage-1 }" />
						</c:if>
						<c:if test="${currentPage%10!=0 }">
							<c:param name="page" value="${ currentPage - (currentPage%10) }" />
						</c:if>
					</c:url>
				</c:if>
				<a href="${ nsl }">[????????????]</a> &nbsp;
			</c:if>
			<!-- ?????? ???????????? ?????? ????????? ?????? ????????? ?????? ?????? -->
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
					<a href="${ nsl }">${ p }</a>
				</c:if>
			</c:forEach>
			<!-- ?????? ????????????????????? ?????? ?????? -->
			<c:if test="${ (currentPage + 10) > endPage and ((endPage%10)==0) and listCount > ( endPage*limit ) }">
				<c:if test="${ action eq 'title' }">
					<c:url var="nsl" value="groupsearchTitle.do">
						<c:param name="keyword" value="${ keyword }" />
						<c:param name="page" value="${ endPage + 1 }" />
					</c:url>
				</c:if>
				<c:if test="${ action eq 'owner' }">
					<c:url var="nsl" value="groupsearchOwner.do">
						<c:param name="keyword" value="${ keyword }" />
						<c:param name="page" value="${ endPage + 1 }" />
					</c:url>
				</c:if>
				<a href="${ nsl }">[????????????]</a> &nbsp;
			</c:if>
			<!-- ??????????????? ?????? ?????? -->
			<c:if test="${ currentPage eq maxPage }">
				[??????] &nbsp; 
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
				<a href="${ nsl }">[??????]</a> &nbsp;
	</c:if>
		</div>
	</c:if>
			<br>
		</div>

	<!-- ?????? ?????? ????????? ?????? -->
	
	<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>