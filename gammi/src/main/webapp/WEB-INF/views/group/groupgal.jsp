<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<link rel="stylesheet" href="resources/css/groupgal.css" type="text/css">
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
<body>
	<c:import url="/WEB-INF/views/common/menubar.jsp" />
	<div style="background-color: #F7F8F9;">
		<c:import url="/WEB-INF/views/common/somoimsidebar.jsp" />
		<div style="margin-left: 15%; padding: 1px 16px; height: 1000px;">
			<c:if test="${ !empty groupgals }">
				<div class="bgc">
					<div class="gal_width">

						<h4 style="font-family: 'CookieRun';">
							음식, 취향에 맞는 사람들끼리 <br> 음식을 전시해보세요!
						</h4>
						<br> <br>
						<ul class="ulflex">
							<c:forEach var="groupgals" items="${groupgals}"
								varStatus="groupgals_status">
								<li class="liflex"><c:url var="bdt"
										value="/groupgaldetail.do">
										<c:param name="gal_no" value="${ groupgals.gal_no }" />
										<c:param name="group_no" value="${ gno }" />
									</c:url> <c:if test="${ empty groupgals.gal_image }">
										<a href="${bdt}"><img class="thumb"
											src="resources/img/food2.jpg" alt="무사진"></a>
									</c:if> <c:if test="${ !empty groupgals.gal_image }">
										<a href="${bdt}"><img class="thumb"
											src="resources/groupGalImg/${ groupgals.gal_image}" alt="무사진"></a>
									</c:if>
									<p class="uploadtitle">제목 : ${groupgals.gal_title}</p>
									<p class="uploadname">작성자 : ${groupgals.gal_id }</p>
									<p class="uploaddate">작성일자 : ${groupgals.gal_date }</p></li>

							</c:forEach>
						</ul>
						<button class="rightbtn2"
							onclick="javascript:location.href='creategroupgal.do?gno=${gno}';">글쓰기</button>

						<br> <br> <br>
						
							<div
								style="display: flex; justify-content: center; margin: 0px 0px 0px 200px;">
								<select id="test" onchange="Change()"
									style="position: relative; border: 1px solid #ccc; left: -198px; width: 5rem; height: 3rem; text-align: center">
									<option value="1">제목</option>
									<option value="2">내용</option>
								</select>
								<div id="d1" style="display: block">
									<form action="searchTitle.do" method="post">
										<input type="search" name="keyword"
											style="width: 26rem; height: 3rem; border: 1px solid #ccc; margin-left: -198px;">
										<input type="hidden" name="gno" value="${gno }"
											style="width: 26rem; height: 3rem; border: 1px solid #ccc; margin-left: -198px;">
										<input type="submit" value="검색"
											style="width: 5.5rem; height: 3rem; border: none; margin-left: -7px; background: #555; color: #fff; cursor: pointer; margin-top: -3px;"
											class="btn">
									</form>
								</div>
								<div id="d2" style="display: none">
									<form action="searchContent.do" method="post">
										<input type="search" name="keyword"
											style="width: 26rem; height: 3rem; border: 1px solid #ccc; margin-left: -198px;">
											<input type="hidden" name="gno" value="${gno }"
											style="width: 26rem; height: 3rem; border: 1px solid #ccc; margin-left: -198px;">
										<input type="submit" value="검색"
											style="width: 5.5rem; height: 3rem; margin-left: -7px; border: none; background: #555; color: #fff; cursor: pointer; margin-top: -3px;"
											class="btn">
									</form>
								</div>
							</div>
					</div>
				</div>
			</c:if>
			<c:if test="${ empty groupgals }">
				<div style="display: grid; place-items: center; min-height: 80vh;">
					<h1 style="font-family: 'Noto Sans KR', sans-serif;">
						현재 생성된 갤러리가 없습니다.<br>
					</h1>

				</div>

				<div style="margin-right: 50px;">
					<button class="rightbtn4"
						onclick="javascript:location.href='creategroupgal.do?gno=${gno}';">글쓰기</button>
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
						<c:url var="bl" value="/groupgal.do">
							<c:param name="gno" value="${ gno }" />
							<c:param name="page" value="1" />
						</c:url>
						<a href="${ bl }">[맨처음]</a> &nbsp;
	</c:if>
					<!-- 이전 페이지그룹으로 이동 처리 -->
					<c:if
						test="${ (currentPage - 10) < startPage and (currentPage - 10) > 1 }">
						<c:url var="bl2" value="/groupgal.do">
							<c:param name="page" value="${ startPage - 10 }" />
							<c:param name="gno" value="${ gno }" />
						</c:url>
						<a href="${ bl2 }">[이전그룹]</a> &nbsp;
			
			<c:if
							test="${ !((currentPage - 10) < startPage and (currentPage - 10) > 1) }">
		[이전그룹] &nbsp;
	</c:if>
					</c:if>
					<!-- 현재 페이지가 속한 페이지 그룹 페이지 숫자 출력 -->
					<c:forEach var="p" begin="${ startPage }" end="${ endPage }"
						step="1">
						<c:if test="${ p eq currentPage }">
							<font size="4" color="red"><b>[${ p }]</b></font>
						</c:if>
						<c:if test="${ p ne currentPage }">
							<c:url var="bl3" value="/groupgal.do">
								<c:param name="gno" value="${ gno }" />
								<c:param name="page" value="${ p }" />
							</c:url>
							<a href="${ bl3 }"><font color="blue">${ p }</font></a>
						</c:if>
					</c:forEach>
					<!-- 다음 페이지그룹으로 이동 처리 -->
					<c:if
						test="${ (currentPage + 10) > endPage and (currentPage + 10) < maxPage }">
						<c:url var="bl4" value="/groupgal.do">
							<c:param name="gno" value="${ gno }" />
							<c:param name="page" value="${ endPage + 10 }" />
						</c:url>
						<a href="${ bl4 }">[다음그룹]</a> &nbsp;
	
			<c:if
							test="${ !((currentPage + 10) > endPage and (currentPage + 10) < maxPage) }">
		[다음그룹] &nbsp;
	</c:if>
					</c:if>
					<!-- 끝페이지로 이동 처리 -->
					<c:if test="${ currentPage eq maxPage }">
		[맨끝] &nbsp; 
	</c:if>
					<c:if test="${ currentPage < maxPage }">
						<c:url var="bl5" value="/groupgal.do">
							<c:param name="gno" value="${ gno }" />
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
							<c:url var="nsl" value="searchTitle.do">
								<c:param name="gno" value="${ gno }" />
								<c:param name="keyword" value="${ keyword }" />
								<c:param name="page" value="1" />
							</c:url>
						</c:if>
						<c:if test="${ action eq 'content' }">
							<c:url var="nsl" value="searchContent.do">
								<c:param name="gno" value="${ gno }" />
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
							<c:url var="nsl" value="searchTitle.do">
										<c:param name="gno" value="${ gno }" />
								<c:param name="keyword" value="${ keyword }" />

								<c:param name="page" value="${ startPage - 10 }" />
							</c:url>
						</c:if>
						<c:if test="${ action eq 'content' }">
							<c:url var="nsl" value="searchContent.do">
									<c:param name="gno" value="${ gno }" />
								<c:param name="keyword" value="${ keyword }" />
								<c:param name="page" value="${ startPage - 10 }" />
							</c:url>
						</c:if>
						<a href="${ nsl }">[이전그룹]</a> &nbsp;
	
			<c:if
							test="${ !((currentPage - 10) < startPage and (currentPage - 10) > 1) }">
		[이전그룹] &nbsp;
	</c:if>
					</c:if>
					<!-- 현재 페이지가 속한 페이지 그룹 페이지 숫자 출력 -->
					<c:forEach var="p" begin="${ startPage }" end="${ endPage }"
						step="1">
						<c:if test="${ p eq currentPage }">
							<font size="4" color="red"><b>[${ p }]</b></font>
						</c:if>
						<c:if test="${ p ne currentPage }">
							<c:if test="${ action eq 'title' }">
								<c:url var="nsl" value="searchTitle.do">
								<c:param name="gno" value="${ gno }" />
									<c:param name="keyword" value="${ keyword }" />
									<c:param name="page" value="${ p }" />
								</c:url>
							</c:if>
							<c:if test="${ action eq 'content' }">
								<c:url var="nsl" value="searchContent.do">
										<c:param name="gno" value="${ gno }" />
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
							<c:url var="nsl" value="searchTitle.do">
							<c:param name="gno" value="${ gno }" />
								<c:param name="keyword" value="${ keyword }" />
								<c:param name="page" value="${ endPage + 10 }" />
							</c:url>
						</c:if>
						<c:if test="${ action eq 'content' }">
							<c:url var="nsl" value="searchContent.do">
							<c:param name="gno" value="${ gno }" />
								<c:param name="keyword" value="${ keyword }" />
								<c:param name="page" value="${ endPage + 10 }" />
							</c:url>
						</c:if>
						<a href="${ nsl }">[다음그룹]</a> &nbsp;
	
			<c:if
							test="${ !((currentPage + 10) > endPage and (currentPage + 10) < maxPage) }">
		[다음그룹] &nbsp;
	</c:if>
					</c:if>
					<!-- 끝페이지로 이동 처리 -->
					<c:if test="${ currentPage eq maxPage }">
		[맨끝] &nbsp; 
	</c:if>
					<c:if test="${ currentPage < maxPage }">
						<c:if test="${ action eq 'title' }">
							<c:url var="nsl" value="searchTitle.do">
									<c:param name="gno" value="${ gno }" />
								<c:param name="keyword" value="${ keyword }" />
								<c:param name="page" value="${ maxPage }" />
							</c:url>
						</c:if>
						<c:if test="${ action eq 'content' }">

							<c:url var="nsl" value="searchContent.do">
						<c:param name="gno" value="${ gno }" />
								<c:param name="keyword" value="${ keyword }" />
								<c:param name="page" value="${ maxPage }" />
							</c:url>
						</c:if>
						<a href="${ nsl }">[맨끝]</a> &nbsp;
	</c:if>
			</c:if>
		</div>
		<!-- 검색 목록 페이징 처리 -->
	</div>
	</div>
	<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>