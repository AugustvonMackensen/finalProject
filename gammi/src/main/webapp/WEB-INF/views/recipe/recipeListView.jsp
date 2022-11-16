<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<c:set var="listCount" value="${ requestScope.listCount }" />
<c:set var="startPage" value="${ requestScope.startPage }" />
<c:set var="endPage" value="${ requestScope.endPage }" />
<c:set var="maxPage" value="${ requestScope.maxPage }" />
<c:set var="currentPage" value="${ requestScope.currentPage }" />
<!DOCTYPE html>
<html>
<head>


<meta charset="UTF-8">

<title></title>
<style>
.container001 {
	margin: 120px;
	item-align: center;
}

.image {
	
}

a {
	text-decoration: none;
}

a:visited {
	color: pink;
}
</style>
<script type="text/javascript"
	src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.1.min.js"></script>

<script type="text/javascript">
	$(function() {
		showDiv();
		$('input[name=item]').on("change", function() {
			showDiv();
		});
	});

	function showDiv() {
		if ($('input[name=item]').eq(0).is(":checked")) {
			$("#titleDiv").css("display", "block");
			$("#contentDiv").css("display", "none");
		}
		if ($('input[name=item]').eq(1).is(":checked")) {
			$("#titleDiv").css("display", "none");
			$("#contentDiv").css("display", "block");

		}
	}

//레시피등록 버튼 클릭시 실행되는 함수
function showWriteForm() {
	//레시피 등록 페이지로 이동 처리
	location.href = "${ pageContext.servletContext.contextPath }/rwform.do";
}
</script>
<script type="text/javascript">
	//모달창 열기 함수
function modalOpen(recipe_title, recipe_readcount, recipe_date, imgBox, recipe_content) {
	
	console.log(recipe_title);
	console.log(recipe_readcount);
	console.log(recipe_date);
	console.log(recipe_content);
	console.log(imgBox);
};
</script>y


<script type="text/javascript">
	// 레시피 검색 (내용, 제목 선택 버튼)
	function Change() {
		var key = test.value;
		if (key == 1) {
			document.all["d1"].style.display = "block";
			document.all["d2"].style.display = "none";
		}
		if (key == 2) {
			document.all["d1"].style.display = "none";
			document.all["d2"].style.display = "block";
		}

	}
</script>

</head>
<body>
	<!-- 상대경로로 대상 파일의 위치를 지정한 경우 -->
	<c:import url="../common/menubar.jsp" />
	<link rel="stylesheet" href="resources/css/modal.css">
	<!--레시피 디테일뷰 (모달창) -->
	<jsp:include page="./recipeDetailView.jsp"></jsp:include>

	<div class="container001">
		<hr>
		<!-- <h1 align="center">레시피 리스트</h1> -->
		<!-- => 로그인한 회원만 게시글 등록(쓰기) 버튼이 보이게 함 -->
		<br>
		<center>
			<c:if test="${ sessionScope.loginMember.admin eq 'Y' }">
				<button onclick="showWriteForm();">새 레시피 등록</button>
			</c:if>
		</center>

		<div align="center">
			<select id="test" onchange="Change()"
				style="width: 6rem; height: 3rem; border: 3px solid #f8f9fa; position: relative; top: 48px; text-align: center; right: 318px;">
				<option value="1">제목</option>
				<option value="2">내용</option>
			</select>

			<div id="d1" style="display: block">
				<form action="rsearchTitle.do" method="get">
					<input type="search" name="keyword"
						style="width: 25rem; height: 3rem; border: 3px solid #f8f9fa;">
					&nbsp; &nbsp; &nbsp; <input type="submit" value="title"
						style="width: 6rem; height: 3rem; border: none; background-color: orange; cursor: pointer;"
						class="btn">
				</form>
			</div>
			<div id="d2" style="display: none">
				<form action="rsearchContent.do" method="get">
					<input type="search" name="keyword"
						style="width: 25rem; height: 3rem; border: 3px solid #f8f9fa;">
					&nbsp; &nbsp; &nbsp; <input type="submit" value="content"
						style="width: 6rem; height: 3rem; border: none; background-color: orange; cursor: pointer;"
						class="btn">
				</form>
			</div>
		</div>

		<!-- 목록 출력 영역 -->
		<br>
		<table width="98%" align="center">
			<tr>
				<th align="left">총 ${ listCount } 개의 맛있는 레시피가 있습니다</th>

				<th style="text-align: end;"><span><a
						href="${ pageContext.servletContext.contextPath }/starlist.do">인기순</a></span>
					<span>|</span> <a
					href="${ pageContext.servletContext.contextPath }/rlist.do">최신순</a></th>
			</tr>
		</table>
		<c:if test="${ requestScope.list.size() == 0 }">등록된 이미지가 없습니다.</c:if>
		<c:if test="${ requestScope.list.size()!= 0 }">

			<c:forEach items="${ requestScope.list }" var="rec" varStatus="vs">
				<ul
					style="padding: 0 0 0 8px; display: inline-block; margin-right: 20px; list-style-type: none; line-height: 28px;">
					
					
					<c:url var="rdt" value="/rdetail.do">
						<c:param name="recipe_num" value="${ rec.recipe_num }" />
						<%-- <c:param name="page" value="${ currentPage }" /> --%>
						<c:param name="page" value="1" />
					</c:url>
					
					
					<div>
						<li><a data-toggle="modal" data-target="#myModal${vs.index}"
							onclick="modalOpen('${ rec.recipe_title }' , 
												'${ rec.recipe_readcount }', 
												'${ rec.recipe_date }',
												'${ rec.recipe_rename_imgname }', 
												'${ rec.recipe_content }');">
						<img src="resources/recipe_upfiles/${ rec.recipe_rename_imgname }"
								class="image" style="border-radius: 2%; width: 300px; height: 300px;"></a></li>
					</div>
					<div
						style="width: 300px; text-overflow: ellipsis; white-space: nowrap; overflow: hidden;">
						<%-- <a href="${ rdt }">${ rec.recipe_title }</a> --%>


						<a id="modal" data-toggle="modal" data-target="#myModal${vs.index}"
							onclick="modalOpen('${ rec.recipe_title }' , 
												'${ rec.recipe_readcount }', 
												'${ rec.recipe_date }',
												'${ rec.recipe_rename_imgname }', 
												'${ rec.recipe_content }');"><b>${ rec.recipe_title }</b></a>
					</div>
					<div>
						작성날짜 :
						<fmt:formatDate value="${ rec.recipe_date }" pattern="yyyy-MM-dd" />
						<span>| 조회수 : ${ rec.recipe_readcount }</span>
					</div>
					
				</ul>
			</c:forEach>

		</c:if>
	</div>

	<br>
	<!-- 페이징 처리 -->
	<div style="text-align: center;">
		<!-- 페이지 표시 영역 -->
		<!-- 1페이지로 이동 처리 -->
		<c:if test="${ currentPage eq 1 }">
		[맨처음] &nbsp;
	</c:if>
		<c:if test="${ currentPage > 1 }">
			<c:url var="rl" value="/rlist.do">
				<c:param name="page" value="1" />
			</c:url>
			<a href="${ rl }">[맨처음]</a> &nbsp;
	</c:if>
		<!-- 이전 페이지그룹으로 이동 처리 -->
		<c:if
			test="${ (currentPage - 10) < startPage and (currentPage - 10) > 1 }">
			<c:url var="rl2" value="/rlist.do">
				<c:param name="page" value="${ startPage - 10 }" />
			</c:url>
			<a href="${ rl2 }">[이전그룹]</a> &nbsp;
	</c:if>
		<c:if
			test="${ !((currentPage - 10) < startPage and (currentPage - 10) > 1) }">
		[이전그룹] &nbsp;
	</c:if>
		<!-- 현재 페이지가 속한 페이지 그룹 페이지 숫자 출력 -->
		<c:forEach var="p" begin="${ startPage }" end="${ endPage }" step="1">
			<c:if test="${ p eq currentPage }">
				<font size="4" color="red"><b>[${ p }]</b></font>
			</c:if>
			<c:if test="${ p ne currentPage }">
				<c:url var="rl3" value="/rlist.do">
					<c:param name="page" value="${ p }" />
				</c:url>
				<a href="${ rl3 }">${ p }</a>
			</c:if>
		</c:forEach>
		<!-- 다음 페이지그룹으로 이동 처리 -->
		<c:if
			test="${ (currentPage + 10) > endPage and (currentPage + 10) < maxPage }">
			<c:url var="rl4" value="/rlist.do">
				<c:param name="page" value="${ endPage + 10 }" />
			</c:url>
			<a href="${ rl4 }">[다음그룹]</a> &nbsp;
	</c:if>
		<c:if
			test="${ !((currentPage + 10) > endPage and (currentPage + 10) < maxPage) }">
		[다음그룹] &nbsp;
	</c:if>
		<!-- 끝페이지로 이동 처리 -->
		<c:if test="${ currentPage eq maxPage }">
		[맨끝] &nbsp; 
	</c:if>
		<c:if test="${ currentPage < maxPage }">
			<c:url var="rl5" value="/rlist.do">
				<c:param name="page" value="${ maxPage }" />
			</c:url>
			<a href="${ rl5 }">[맨끝]</a> &nbsp;
	</c:if>
	</div>
	<hr>

	

	<!-- 모달창 css, script -->
	
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
	<c:import url="/WEB-INF/views/common/footer.jsp" />

</body>
</html>