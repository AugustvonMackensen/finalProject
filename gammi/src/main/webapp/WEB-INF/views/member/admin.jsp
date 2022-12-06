<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.1.min.js"></script>
<meta charset="UTF-8">
        <script type="text/javascript">
            $(function(){
                showDiv();
                
                $('input[name=item]').on("change", function(){
                    showDiv();
                });
            });
            
            function showDiv(){
                if($('input[name=item]').eq(0).is(":checked")){
                    $("#titleDiv").css("display", "block");
                    $("#writerDiv").css("display", "none");
                }
                if($('input[name=item]').eq(1).is(":checked")){
                    $("#titleDiv").css("display", "none");
                    $("#writerDiv").css("display", "block");
                }
            }
            
            
            //로그인 제한/가능 레디오 체크가 변경되었을 때 실행되는 함수
            function changeLogin(element){
            	//선택한 radio의 name 속성의 이름에서 userid 분리 추출함
            	var m_id = element.name.substring(9);
            	console.log("changeLogin : " + m_id);
            	if(element.checked == true && element.value == "N"){
            		//로그인 제한을 체크했다면
            		console.log("로그인 제한 체크함");
            		location.href="${pageContext.servletContext.contextPath}/loginok.do?m_id=" + m_id + "&login_ok=N";
            	} else {
            		console.log("로그인 제한 해제함");
            		location.href="${pageContext.servletContext.contextPath}/loginok.do?m_id=" + m_id + "&login_ok=Y";
            	}
            } 
</script>
            
            
</head>
<body>
<c:import url="/WEB-INF/views/common/menubar.jsp" />
<div class="bgc">
<section class="notice">
    <div class="page-title">
        <div class="container">
            <h4 style=" font-family: 'Noto Sans KR', sans-serif; text-align: center;">전체회원수 :${listCount} </h4>
        </div>
    </div>
  
      <!-- board seach area -->
      <div id="board-search">
          <div class="container">
              <div class="search-window">
                  <form action="">
                    <div style="display:flex;  justify-content: center;  margin: 0px 0px 0px 200px;">
                        <select id="test" onchange="Change()"  style="position: relative; border: 1px solid #ccc; left: -198px; width:5rem; height:3rem;  text-align:center">
                        <option value="1">제목</option>
                        <option value="2">내용</option>
                         </select>
                        <div id="d1" style="display: block">
                           <form action="qna.do" method="post" >
                              <input type="search" name="keyword" style="width: 26rem;height:3rem; border: 1px solid #ccc; margin-left:-198px; ">
                              <input type="submit" value="검색"  style="width: 5.5rem;height:3rem;border:none; margin-left: -5px; background: #555;color: #fff; cursor:pointer;  margin-top:-3px;" class="btn">
                           </form>
                        </div>
                        <div id="d2" style="display: none">
                        <form action="qna.do" method="post">   
                             <input type="search" name="keyword" style="width: 26rem;height:3rem; border: 1px solid #ccc; margin-left:-198px; ">
                             <input type="submit" value="검색"  style="width: 5.5rem; height:3rem; margin-left: -5px; border:none;background: #555; color: #fff; cursor:pointer;  margin-top:-3px;" class="btn">
                           </form>
                        </div>
                        </div>
                  </form>
                  <br>
                  <div class="checkbox">
                    <input type="radio" name="item" value="title" checked> 로그인관리 &nbsp; &nbsp;
                    <input type="radio" name="item" value="writer"> 소모임관리 &nbsp; &nbsp;
                </div>
                <br>
              </div>
          </div>
      </div>

<!------------------------------ 로그인 --------------------------------->
<div id="titleDiv">
      <div id="board-list">
          <div class="container">
              <table class="board-table">
                  <thead>
                  <tr>
                    <th scope="cols">아이디</th>
                    <th scope="cols">이메일</th>
                    <th scope="cols">로그인 활성/비활성</th>
                  </tr>
                  </thead>
                  <tbody>                   
                     <c:forEach items="${ requestScope.list }" var="m">
                        <tr>
                            <td>${m.m_id}</td>
                            <td>${m.m_email }</td>
                            <td>
                                <c:if test="${m.login_ok eq 'Y' }">
                                    <input type="radio"	name="login_ok_${m.m_id }" value="Y"  checked	onchange="changeLogin(this);"> 가능 &nbsp;
                                    <input type="radio"	name="login_ok_${m.m_id }" value="N"	onchange="changeLogin(this);"> 제한 &nbsp;
                                </c:if>
                                <c:if test="${m.login_ok eq 'N' }">
                                    <input type="radio"	name="login_ok_${m.m_id }" value="Y"	onchange="changeLogin(this);"> 가능 &nbsp;
                                    <input type="radio" name="login_ok_${m.m_id }" value="N"	checked	onchange="changeLogin(this);"> 제한 &nbsp;
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
              </table>
            </div>
            </div>
</div>

<!------------------------------ 소모임 --------------------------------->
<div id="writerDiv">
    <div id="board-list">
        <div class="container">
            <table class="board-table">
                <thead>
                <tr>
                    <th scope="cols">그룹장아이디</th>
                    <th scope="cols">그룹명</th>
                    <th scope="cols">소모임 활성/비활성</th>
                </tr>
                </thead>
                <tbody> 
                    <%-- <c:forEach items="${ requestScope.list }" var="m">
                        <tr>
                              <td>지디</td>
                            <td>얍</td>
                            <td>
                                <c:if test="${m.login_ok eq 'Y' }">
                                    <input type="radio"	name="_ok_${m.m_id }" 		value="Y"  checked	onchange="changeLogin(this);"> 가능 &nbsp;
                                    <input type="radio"	name="login_ok_${m.m_id }" 		value="N"	onchange="changeLogin(this);"> 제한 &nbsp;
                                </c:if>
                                <c:if test="${m.login_ok eq 'N' }">
                                    <input type="radio"	name="login_ok_${m.m_id }" 		value="Y"	onchange="changeLogin(this);"> 가능 &nbsp;
                                    <input type="radio" 	name="login_ok_${m.m_id }" 		value="N"	checked	onchange="changeLogin(this);"> 제한 &nbsp;
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach> --%>
                </tbody>
            </table>
          </div>
          </div>
      </div>
  
  </section>
<c:if test="${ empty action }">
<!-- 전체 목록 페이징 처리 -->
<div style="text-align:center;"> <!-- 페이지 표시 영역 -->
	<!-- 1페이지로 이동 처리 -->
	<c:if test="${ currentPage eq 1 }">
		[맨처음] &nbsp;
	</c:if>
	<c:if test="${ currentPage > 1 }">
		<c:url var="bl" value="/mlist.do">
			<c:param name="page" value="1" />
		</c:url>
		<a href="${ bl }">[맨처음]</a> &nbsp;
	</c:if>
	<!-- 이전 페이지그룹으로 이동 처리 -->
	<c:if test="${ (currentPage - 10) < startPage and (currentPage - 10) > 1 }">
		<c:url var="bl2" value="/mlist.do">
			<c:param name="page" value="${ startPage - 10 }" />
		</c:url>
		<a href="${ bl2 }">[이전그룹]</a> &nbsp;
	</c:if>
	<c:if test="${ !((currentPage - 10) < startPage and (currentPage - 10) > 1) }">
		[이전그룹] &nbsp;
	</c:if>
	<!-- 현재 페이지가 속한 페이지 그룹 페이지 숫자 출력 -->
	<c:forEach var="p" begin="${ startPage }" end="${ endPage }" step="1">
		<c:if test="${ p eq currentPage }">
			<font size="4" color="red"><b>[${ p }]</b></font>
		</c:if>
		<c:if test="${ p ne currentPage }">
			<c:url var="bl3" value="/mlist.do">
				<c:param name="page" value="${ p }" />
		</c:url>
		<a href="${ bl3 }">${ p }</a> 
		</c:if>
	</c:forEach>
	<!-- 다음 페이지그룹으로 이동 처리 -->
	<c:if test="${ (currentPage + 10) > endPage and (currentPage + 10) < maxPage }">
		<c:url var="bl4" value="/mlist.do">
			<c:param name="page" value="${ endPage + 10 }" />
		</c:url>
		<a href="${ bl4 }">[다음그룹]</a> &nbsp;
	</c:if>
	<c:if test="${ !((currentPage + 10) > endPage and (currentPage + 10) < maxPage) }">
		[다음그룹] &nbsp;
	</c:if>
	<!-- 끝페이지로 이동 처리 -->
	<c:if test="${ currentPage eq maxPage }">
		[맨끝] &nbsp; 
	</c:if>
	<c:if test="${ currentPage < maxPage }">
		<c:url var="bl5" value="/mlist.do">
			<c:param name="page" value="${ maxPage }" />
		</c:url>
		<a href="${ bl5 }">[맨끝]</a> &nbsp;
	</c:if>
</div>
</c:if>

<c:if test="${ !empty action }">

<!-- 검색 목록 페이징 처리 -->
<div style="text-align:center;"> <!-- 페이지 표시 영역 -->
	<!-- 1페이지로 이동 처리 -->
	<c:if test="${ currentPage eq 1 }">
		 [맨처음] &nbsp;
	</c:if>
	<c:if test="${ currentPage > 1 }">
			<c:if test="${ action eq 'userid' }">
				<c:url var="nsl" value="msearchId.do">
					<c:param name="keyword" value="${ keyword }" />
					<c:param name="page" value="1" />
				</c:url>
			</c:if>
		
			<c:if test="${ action eq 'login' }">
				<c:url var="nsl" value="msearchLogin.do">
					<c:param name="keyword" value="${ keyword }" />
					<c:param name="page" value="1" />
				</c:url>
			</c:if>
		
			<c:if test="${ action eq 'edate' }">
				<c:url var="nsl" value="msearchDate.do">
					<c:param name="begin" value="${ begin }" />
					<c:param name="end" value="${ end }" />
					<c:param name="page" value="1" />
				</c:url>
			</c:if>
		<a href="${ nsl }">[맨처음]</a> &nbsp;
	</c:if>
	<!-- 이전 페이지그룹으로 이동 처리 -->
	<c:if test="${ (currentPage - 10) < startPage and (currentPage - 10) > 1 }">
		<c:if test="${ action eq 'userid' }">
				<c:url var="nsl" value="msearchId.do">
					<c:param name="keyword" value="${ keyword }" />
					<c:param name="page" value="${ startPage - 10 }" />
				</c:url>
			</c:if>
		
			<c:if test="${ action eq 'login' }">
				<c:url var="nsl" value="msearchLogin.do">
					<c:param name="keyword" value="${ keyword }" />
					<c:param name="page" value="${ startPage - 10 }" />
				</c:url>
			</c:if>
		
			<c:if test="${ action eq 'edate' }">
				<c:url var="nsl" value="msearchDate.do">
					<c:param name="begin" value="${ begin }" />
					<c:param name="end" value="${ end }" />
					<c:param name="page" value="${ startPage - 10 }" />
				</c:url>
			</c:if>
		<a href="${ nsl }">[이전그룹]</a> &nbsp;
	</c:if>
	<c:if test="${ !((currentPage - 10) < startPage and (currentPage - 10) > 1) }">
		[이전그룹] &nbsp;
	</c:if>
	<!-- 현재 페이지가 속한 페이지 그룹 페이지 숫자 출력 -->
	<c:forEach var="p" begin="${ startPage }" end="${ endPage }" step="1">
		<c:if test="${ p eq currentPage }">
			<font size="4" color="red"><b>[${ p }]</b></font>
		</c:if>
		<c:if test="${ p ne currentPage }">
			<c:if test="${ action eq 'userid' }">
				<c:url var="nsl" value="msearchId.do">
					<c:param name="keyword" value="${ keyword }" />
					<c:param name="page" value="${ p }" />
				</c:url>
			</c:if>
		
			<c:if test="${ action eq 'login' }">
				<c:url var="nsl" value="msearchLogin.do">
					<c:param name="keyword" value="${ keyword }" />
					<c:param name="page" value="${ p }" />
				</c:url>
			</c:if>
		
			<c:if test="${ action eq 'edate' }">
				<c:url var="nsl" value="msearchDate.do">
					<c:param name="begin" value="${ begin }" />
					<c:param name="end" value="${ end }" />
					<c:param name="page" value="${ p }" />
				</c:url>
			</c:if>
			<a href="${ nsl }">${ p }</a> 
		</c:if>
	</c:forEach>
	<!-- 다음 페이지그룹으로 이동 처리 -->
	<c:if test="${ (currentPage + 10) > endPage and (currentPage + 10) < maxPage }">
		<c:if test="${ action eq 'userid' }">
				<c:url var="nsl" value="msearchId.do">
					<c:param name="keyword" value="${ keyword }" />
					<c:param name="page" value="${ endPage + 10 }" />
				</c:url>
			</c:if>
		
			<c:if test="${ action eq 'login' }">
				<c:url var="nsl" value="msearchLogin.do">
					<c:param name="keyword" value="${ keyword }" />
					<c:param name="page" value="${ endPage + 10 }" />
				</c:url>
			</c:if>
		
			<c:if test="${ action eq 'edate' }">
				<c:url var="nsl" value="msearchDate.do">
					<c:param name="begin" value="${ begin }" />
					<c:param name="end" value="${ end }" />
					<c:param name="page" value="${ endPage + 10 }" />
				</c:url>
			</c:if>
		<a href="${ nsl }">[다음그룹]</a> &nbsp;
	</c:if>
	<c:if test="${ !((currentPage + 10) > endPage and (currentPage + 10) < maxPage) }">
		[다음그룹] &nbsp;
	</c:if>
	<!-- 끝페이지로 이동 처리 -->
	<c:if test="${ currentPage eq maxPage }">
		[맨끝] &nbsp; 
	</c:if>
	<c:if test="${ currentPage < maxPage }">
		<c:if test="${ action eq 'userid' }">
				<c:url var="nsl" value="msearchId.do">
					<c:param name="keyword" value="${ keyword }" />
					<c:param name="page" value="${ maxPage }" />
				</c:url>
			</c:if>
		
			<c:if test="${ action eq 'login' }">
				<c:url var="nsl" value="msearchLogin.do">
					<c:param name="keyword" value="${ keyword }" />
					<c:param name="page" value="${ maxPage }" />
				</c:url>
			</c:if>
		
			<c:if test="${ action eq 'edate' }">
				<c:url var="nsl" value="msearchDate.do">
					<c:param name="begin" value="${ begin }" />
					<c:param name="end" value="${ end }" />
					<c:param name="page" value="${ maxPage }" />
				</c:url>
			</c:if>
		<a href="${ nsl }">[맨끝]</a> &nbsp;
	</c:if>
</div>
</c:if> <!-- 검색 목록 페이징 처리 -->
</body>
</html>