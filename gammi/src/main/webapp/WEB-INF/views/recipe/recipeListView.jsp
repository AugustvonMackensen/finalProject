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
	display : flex;
	margin: 100px;
	text-align: center;
	flex-wrap: wrap;
	gap: 15px;
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
<script type="text/javascript" src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.1.min.js"></script>
<script type="text/javascript">
	// 레시피 검색 (내용, 제목 선택 버튼)
	function Change() {
		var key = test.value;
		if (key == 1) {
			document.all["d1"].style.display = "block";
		}
	}
</script>

</head>
<body>
	<!-- 상대경로로 대상 파일의 위치를 지정한 경우 -->
	<c:import url="../common/menubar.jsp" />

<div style="max-width: 1907px; margin : 0 auto;">
		<hr>
		<br>


		<!-- 목록 출력 영역 -->
		<br>
				<h3 style="margin-left: 120px; font-family: 'CookieRun';">총 ${ listCount } 개의 맛있는 레시피가 있습니다.</h3>
							<div class="container001">
		<c:if test="${ requestScope.list.size() == 0 }">등록된 이미지가 없습니다.</c:if>
		<c:if test="${ requestScope.list.size()!= 0 }">
			<c:forEach items="${ requestScope.list }" var="rec" varStatus="vs">
				<a href = "${ rec.recipe_url }" target="_blank">
				<ul style="padding: 0 0 0 8px; display: inline-block; margin-right: 20px; list-style-type: none; line-height: 28px;">
					<div>
						<li>
						<img src="${ rec.recipe_img }"
								class="image" style="border-radius: 2%; width: 300px; height: 300px;"></li>
					</div>
					<div
						style="width: 300px; text-overflow: ellipsis; white-space: nowrap; overflow: hidden;">
						<b>${ rec.recipe_title }</b>
					</div>
				</ul>
				</a>
			</c:forEach>
		</c:if>
	</div>
	<br>
			<div style="display: flex; justify-content: center; margin: 0px 0px 0px 200px;">
			<select id="test" onchange="Change()"
				style="position: relative; border: 1px solid #ccc; left: -198px; width: 5rem; height: 3rem; text-align: center">
				<option value="1">제목</option>
			</select>

			<div id="d1" style="display: block">
				<form action="rsearchTitle.do" method="get">
					<input type="search" name="keyword"
						style="width: 26rem; height: 3rem; border: 1px solid #ccc; margin-left: -198px;">
					&nbsp; &nbsp; &nbsp; <input type="submit" value="검색"
						style="width: 5.5rem; height: 3rem; border: none; margin-left: -40px; background: #555; color: #fff; cursor: pointer; margin-top: -3px;"
						class="btn">
				</form>
			</div>
		</div>
		<br>
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
				<c:url var="bl" value="/rlist.do">
					<c:param name="page" value="1" />
				</c:url>
				<a href="${ bl }">[맨처음]</a> &nbsp;
	</c:if>
			<!-- 이전 페이지그룹으로 이동 처리 -->
			<c:if
				test="${ (currentPage - 10) < startPage and (currentPage - 10) > 0 }">
				<c:url var="bl2" value="/rlist.do">
					<c:if test="${currentPage%10==0 }">
						<c:param name="page" value="${ startPage-1 }" />
					</c:if>
					<c:if test="${currentPage%10!=0 }">
						<c:param name="page" value="${ currentPage - (currentPage%10) }" />
					</c:if>
				</c:url>
				<a href="${ bl2 }">[이전그룹]</a> &nbsp;
	</c:if>
			<!-- 현재 페이지가 속한 페이지 그룹 페이지 숫자 출력 -->
			<c:forEach var="p" begin="${ startPage }" end="${ endPage }" step="1">
				<c:if test="${ p eq currentPage }">
					<font size="4" color="red"><b>[${ p }]</b></font>
				</c:if>
				<c:if test="${ p ne currentPage }">
					<c:url var="bl3" value="/rlist.do">
						<c:param name="page" value="${ p }" />
					</c:url>
					<a href="${ bl3 }">${ p }</a>
				</c:if>
			</c:forEach>
			<!-- 다음 페이지그룹으로 이동 처리 -->
			<c:if
				test="${ (currentPage + 10) > endPage and ((endPage%10)==0) and listCount > ( endPage*limit ) }">
				<c:url var="bl4" value="/rlist.do">
					<c:param name="page" value="${ endPage + 1 }" />
				</c:url>
				<a href="${ bl4 }">[다음그룹]</a> &nbsp;
			</c:if>
			<!-- 끝페이지로 이동 처리 -->
			<c:if test="${ currentPage eq maxPage }">
				[맨끝] &nbsp; 
			</c:if>
			<c:if test="${ currentPage < maxPage }">
				<c:url var="bl5" value="/rlist.do">
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
					<c:url var="nsl" value="rsearchTitle.do">
						<c:param name="keyword" value="${ keyword }" />
						<c:param name="page" value="1" />
					</c:url>
				</c:if>
				<a href="${ nsl }">[맨처음]</a> &nbsp;
	</c:if>
			<!-- 이전 페이지그룹으로 이동 처리 -->
			<c:if test="${ (currentPage - 10) < startPage and (currentPage - 10) > 0 }">
				<c:if test="${ action eq 'title' }">
					<c:url var="nsl" value="rsearchTitle.do">
						<c:param name="keyword" value="${ keyword }" />
						<c:if test="${currentPage%10==0 }">
							<c:param name="page" value="${ startPage-1 }" />
						</c:if>
						<c:if test="${currentPage%10!=0 }">
							<c:param name="page" value="${ currentPage - (currentPage%10) }" />
						</c:if>
					</c:url>
				</c:if>
				<a href="${ nsl }">[이전그룹]</a> &nbsp;
			</c:if>
			<!-- 현재 페이지가 속한 페이지 그룹 페이지 숫자 출력 -->
			<c:forEach var="p" begin="${ startPage }" end="${ endPage }" step="1">
				<c:if test="${ p eq currentPage }">
					<font size="4" color="red"><b>[${ p }]</b></font>
				</c:if>
				<c:if test="${ p ne currentPage }">
					<c:if test="${ action eq 'title' }">
						<c:url var="nsl" value="rsearchTitle.do">
							<c:param name="keyword" value="${ keyword }" />
							<c:param name="page" value="${ p }" />
						</c:url>
					</c:if>
					<a href="${ nsl }">${ p }</a>
				</c:if>
			</c:forEach>
			<!-- 다음 페이지그룹으로 이동 처리 -->
			<c:if test="${ (currentPage + 10) > endPage and ((endPage%10)==0) and listCount > ( endPage*limit ) }">
				<c:if test="${ action eq 'title' }">
					<c:url var="nsl" value="rsearchTitle.do">
						<c:param name="keyword" value="${ keyword }" />
						<c:param name="page" value="${ endPage + 1 }" />
					</c:url>
				</c:if>
				<a href="${ nsl }">[다음그룹]</a> &nbsp;
			</c:if>
			<!-- 끝페이지로 이동 처리 -->
			<c:if test="${ currentPage eq maxPage }">
				[맨끝] &nbsp; 
			</c:if>
			<c:if test="${ currentPage < maxPage }">
				<c:if test="${ action eq 'title' }">
					<c:url var="nsl" value="rsearchTitle.do">
						<c:param name="keyword" value="${ keyword }" />
						<c:param name="page" value="${ maxPage }" />
					</c:url>
				</c:if>
				<a href="${ nsl }">[맨끝]</a> &nbsp;
	</c:if>
		</div>
	</c:if>
	<br>
	</div>
	<!-- 검색 목록 페이징 처리 -->
	<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>