<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<script type="text/javascript"
	src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.1.min.js"></script>

</head>
<body>
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
	<link rel="stylesheet" href="resources/css/board.css">
	<!-- 상대경로로 대상 파일의 위치를 지정한 경우 -->
	<c:import url="../common/menubar.jsp" />
	<!-- jstl 에서 절대경로 표기 : /WEB-INF/views/common/menubar.jsp -->
	<br>
	<br>
	<c:if test="${ empty list }"><br><br><br>
	<h1>ㅇㄴㅇㄴㅁㅇㅁㅇㅁㅇㅁㅇ</h1>
	</c:if>
	<c:if test="${ !empty list }">
	
	
	<div class="page-title">
		<div class="container">
			<h4
				style="font-family: 'Noto Sans KR', sans-serif; text-align: center;">공지사항</h4>
		</div>
	</div>
	<!-- 관리자만 공지글 등록할 수 있도록 처리함
  => 로그인한 회원이 관리자이면 공지글 등록 버튼이 보이게 함 -->


	<hr>
	<!-- 검색 항목 영역 -->
	<section class="notice">
		<!-- board seach area -->
		<div id="board-search">
			<div class="container">
				<div style="max-height:30px; font-family: 'Noto Sans KR', sans-serif; font-size:14px ">
				<div style="margin-left:15px"><span>총 ${ listCount } 건</span></div>
				<div style="text-align : right; margin-top : -20px; margin-right: 33px;">
				    <span><a class="visted" href="nstarlist.do?keyword=readcount">조회순</a></span>
					<span>|</span> 
					<a class="visted" href="nlist.do">최신순</a></div></div>
				<br>
				<div class="search-window">
					<div
						style="display: flex; justify-content: center; margin: 0px 0px 0px 200px;">
						<select id="test" onchange="Change()"
							style="position: relative; border: 1px solid #ccc; left: -198px; width: 5rem; height: 3rem; text-align: center">
							<option value="1">제목</option>
							<option value="2">내용</option>
						</select>

						<div id="d1" style="display: block">
							<form action="nsearchTitle.do" method="get">
								<input type="search" name="keyword"
									style="width: 26rem; height: 3rem; border: 1px solid #ccc; margin-left: -198px;">
								<input type="submit" value="검색"
									style="width: 5.5rem; height: 3rem; border: none; margin-left: -5px; background: #555; color: #fff; cursor: pointer; margin-top: -3px;"
									class="btn" name="title">
							</form>

						</div>

						<div id="d2" style="display: none">
							<form action="nsearchContent.do" method="get">
								<input type="search" name="keyword"
									style="width: 26rem; height: 3rem; border: 1px solid #ccc; margin-left: -198px;">
								<input type="submit" value="검색"
									style="width: 5.5rem; height: 3rem; margin-left: -5px; border: none; background: #555; color: #fff; cursor: pointer; margin-top: -3px;"
									class="btn" name="content">
							</form>

						</div>
					</div>
				</div>
			</div>
		</div>



		<!-- 목록 출력 영역 -->
		<div id="board-list">
			<div class="container">
				<table class="board-table">
					<thead>
						<tr>
							<th scope="col" class="th-num">번호</th>
							<th scope="col" class="th-title">제목</th>
							<th scope="col" class="th-date">조회수</th>
							<th scope="col" class="th-date">작성자</th>
							<th scope="col" class="th-date">첨부파일</th>
							<th scope="col" class="th-date">등록일</th>
						</tr>
					</thead>
					<c:forEach items="${ requestScope.list }" var="n">
						<tbody>
							<tr>
								<td>${ n.notice_num }</td>
								<c:url var="ndt" value="/ndetail.do">
								<c:param name="notice_num" value="${ n.notice_num }" />
								</c:url>
								<th><a href="${ ndt }">${ n.notice_title }</a>
								<td>${ n.notice_readcount }</td>
								<td>${ n.notice_writer }</td>
								<td><c:if test="${ !empty n.notice_original_filename }">◎</c:if>
									<c:if test="${ empty n.notice_original_filename }">&nbsp;</c:if>
								</td>
								<td><fmt:formatDate value="${ n.notice_date }"
										pattern="yyyy-MM-dd" /></td>

								</th>
							</tr>
						</tbody>
					</c:forEach>
				</table>
				
		<c:if test="${ sessionScope.loginMember.admin eq 'Y' }">
			<button class="rightbtn" onclick="javascript:location.href='movewrite.do';"> 공지글 등록</button>
		</c:if>
				<button class="rightbtn3"
					onclick="javascript:location.href='${ pageContext.servletContext.contextPath }/nlist.do';">목록</button>
			</div>
		</div>
	</section>
	

	<c:if test="${ empty action }">
		<!-- 전체 목록 페이징 처리 -->

		<div style="text-align: center;">
			<!-- 페이지 표시 영역 -->
			<!-- 1페이지로 이동 처리 -->
			<c:if test="${ currentPage eq 1 }">
		[맨처음] &nbsp;
	</c:if>
			<c:if test="${ currentPage > 1 }">
				<c:url var="bl" value="/nlist.do">
					<c:param name="page" value="1" />
				</c:url>
				<a href="${ bl }">[맨처음]</a> &nbsp;
	</c:if>
			<!-- 이전 페이지그룹으로 이동 처리 -->
			<c:if
				test="${ (currentPage - 10) < startPage and (currentPage - 10) > 0 }">
				<c:url var="bl2" value="/nlist.do">
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
					<c:url var="bl3" value="/nlist.do">
						<c:param name="page" value="${ p }" />
					</c:url>
					<a href="${ bl3 }">${ p }</a>
				</c:if>
			</c:forEach>
			<!-- 다음 페이지그룹으로 이동 처리 -->
			<c:if
				test="${ (currentPage + 10) > endPage and ((endPage%10)==0) and listCount > ( endPage*limit ) }">
				<c:url var="bl4" value="/nlist.do">
					<c:param name="page" value="${ endPage + 1 }" />
				</c:url>
				<a href="${ bl4 }">[다음그룹]</a> &nbsp;
	</c:if>
			
			<!-- 끝페이지로 이동 처리 -->
			<c:if test="${ currentPage eq maxPage }">
		[맨끝] &nbsp; 
	</c:if>
			<c:if test="${ currentPage < maxPage }">
				<c:url var="bl5" value="/nlist.do">
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
					<c:url var="nsl" value="nsearchTitle.do">
						<c:param name="keyword" value="${ keyword }" />
						<c:param name="page" value="1" />
					</c:url>
				</c:if>

				<c:if test="${ action eq 'date' }">
					<c:url var="nsl" value="nsearchDate.do">
						<c:param name="begin" value="${ begin }" />
						<c:param name="end" value="${ end }" />
						<c:param name="page" value="1" />
					</c:url>
				</c:if>
				
				<c:if test="${ action eq 'readcount' }">
					<c:url var="nsl" value="nstarlist.do">
						<c:param name="keyword" value="${ keyword }" />
						<c:param name="page" value="1" />
					</c:url>
				</c:if>
				<a href="${ nsl }">[맨처음]</a> &nbsp;
	</c:if>
			<!-- 이전 페이지그룹으로 이동 처리 -->
			<c:if
				test="${ (currentPage - 10) < startPage and (currentPage - 10) > 0 }">
				<c:if test="${ action eq 'title' }">
					<c:url var="nsl" value="nsearchTitle.do">
						<c:param name="keyword" value="${ keyword }" />
						<c:if test="${currentPage%10==0 }">
							<c:param name="page" value="${ startPage-1 }" />
						</c:if>
						<c:if test="${currentPage%10!=0 }">
							<c:param name="page" value="${ currentPage - (currentPage%10) }" />
						</c:if>
					</c:url>
				</c:if>

				<c:if test="${ action eq 'date' }">
					<c:url var="nsl" value="nsearchDate.do">
						<c:param name="begin" value="${ begin }" />
						<c:param name="end" value="${ end }" />
						<c:if test="${currentPage%10==0 }">
							<c:param name="page" value="${ startPage-1 }" />
						</c:if>
						<c:if test="${currentPage%10!=0 }">
							<c:param name="page" value="${ currentPage - (currentPage%10) }" />
						</c:if>
					</c:url>
				</c:if>
				
				<c:if test="${ action eq 'readcount' }">
					<c:url var="nsl" value="nstarlist.do">
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
						<c:url var="nsl" value="nsearchTitle.do">
							<c:param name="keyword" value="${ keyword }" />
							<c:param name="page" value="${ p }" />
						</c:url>
					</c:if>

					<c:if test="${ action eq 'date' }">
						<c:url var="nsl" value="nsearchDate.do">
							<c:param name="begin" value="${ begin }" />
							<c:param name="end" value="${ end }" />
							<c:param name="page" value="${ p }" />
						</c:url>
					</c:if>
					
					<c:if test="${ action eq 'readcount' }">
						<c:url var="nsl" value="nstarlist.do">
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
					<c:url var="nsl" value="nsearchTitle.do">
						<c:param name="keyword" value="${ keyword }" />
						<c:param name="page" value="${ endPage + 1 }" />
					</c:url>
				</c:if>

				<c:if test="${ action eq 'date' }">
					<c:url var="nsl" value="nsearchDate.do">
						<c:param name="begin" value="${ begin }" />
						<c:param name="end" value="${ end }" />
						<c:param name="page" value="${ endPage + 1 }" />
					</c:url>
				</c:if>
				
				<c:if test="${ action eq 'readcount' }">
					<c:url var="nsl" value="nstarlist.do">
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
					<c:url var="nsl" value="nsearchTitle.do">
						<c:param name="keyword" value="${ keyword }" />
						<c:param name="page" value="${ maxPage }" />
					</c:url>
				</c:if>

				<c:if test="${ action eq 'date' }">
					<c:url var="nsl" value="nsearchDate.do">
						<c:param name="begin" value="${ begin }" />
						<c:param name="end" value="${ end }" />
						<c:param name="page" value="${ maxPage }" />
					</c:url>
				</c:if>
				
				<c:if test="${ action eq 'readcount' }">
					<c:url var="nsl" value="nstarlist.do">
						<c:param name="keyword" value="${ keyword }" />
						<c:param name="page" value="${ maxPage }" />
					</c:url>
				</c:if>
				<a href="${ nsl }">[맨끝]</a> &nbsp;
	</c:if>
		</div>
	</c:if>
	<!-- 검색 목록 페이징 처리 -->
	</c:if>
	<br>
	<c:import url="/WEB-INF/views/common/footer.jsp" />

</body>
</html>

