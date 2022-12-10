<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<meta charset="UTF-8">
        <script type="text/javascript">
            $(function(){
                $('input[name=item]').on("change", function(){
                    showDiv();
                });
            });
            
            function showDiv(){
                if($('input[name=item]').eq(0).is(":checked")){
                	 location.href="mlist.do";
                }
            }
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
            //모임 제한/가능 레디오 체크가 변경되었을 때 실행되는 함수
            function changeLogin(element){
            	//선택한 radio의 name 속성의 이름에서 group_name 분리 추출함
            	var group_name = element.name.substring(9);
            	var json = new Object();
            	json.group_name = group_name;
            	if(element.checked == true && element.value == "N"){
            		json.group_ok = "N";
            		} else {
            		json.group_ok = "Y";
            		}
            	$.ajax({
					url: "groupok.do",
					type: "post",
					data: JSON.stringify(json),
					contentType: "application/json; charset=utf-8",
					success: function(result){
						
					},
					error: function(request, status, errorData){
						console.log("error code : " + request.status
								+ "\nMessage : " + request,responseText
								+ "\nError : " + errorData);
					}
				});
            } 
</script>
            
            
</head>
<body>
<c:import url="/WEB-INF/views/common/menubar.jsp" />
<div class="bgc">
<section class="notice">
    <div class="page-title">
        <div class="container">
            <h4 style=" font-family: 'Noto Sans KR', sans-serif; text-align: center;">전체 그룹수 :${listCount} </h4>
        </div>
    </div>
  
      <!-- board seach area -->
      <div id="board-search">
          <div class="container">
              <div class="search-window">
                    <div style="display:flex;  justify-content: center;  margin: 0px 0px 0px 200px;">
                        <select id="test" onchange="Change()"  style="position: relative; border: 1px solid #ccc; left: -198px; width:5rem; height:3rem;  text-align:center">
                        <option value="1">그룹장아이디</option>
                        <option value="2">모임제한여부검색(Y,N)</option>
                         </select>
                        <div id="d1" style="display: block">
                           <form action="gsearowner.do" method="get" >
                              <input type="search" name="keyword" style="width: 26rem;height:3rem; border: 1px solid #ccc; margin-left:-198px; ">
                              <input type="submit" value="검색"  style="width: 5.5rem;height:3rem;border:none; margin-left: -5px; background: #555;color: #fff; cursor:pointer;  margin-top:-3px;" class="btn">
                           </form>
                        </div>
                        <div id="d2" style="display: none">
                        <form action="gsearchGOk.do" method="get">   
                             <input type="search" name="keyword" style="width: 26rem;height:3rem; border: 1px solid #ccc; margin-left:-198px; ">
                             <input type="submit" value="검색"  style="width: 5.5rem; height:3rem; margin-left: -5px; border:none;background: #555; color: #fff; cursor:pointer;  margin-top:-3px;" class="btn">
                        </form>
                        </div>
                        <input type="button" value="전체목록"  style="height:3rem;border:none; margin-left: 5px; background: #555;color: #fff; cursor:pointer;" class="btn"
                        onclick="location.href='glist.do'">
                        </div>
                  <br>
                  <div class="checkbox">
                    <input type="radio" name="item" value="title" > 로그인관리 &nbsp; &nbsp;
                    <input type="radio" name="item" value="writer" checked> 소모임관리 &nbsp; &nbsp;
                </div>
                <br>
              </div>
          </div>
      </div>

<div id="titleDiv">
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
                     <c:forEach items="${ requestScope.list }" var="g">
                        <tr>
                            <td>${g.group_owner}</td>
                            <td>${g.group_name }</td>
                            <td>
                                <c:if test="${g.group_ok eq 'Y' }">
                                    <input type="radio"	name="group_ok_${g.group_name }" value="Y"  checked	onchange="changeLogin(this);"> 가능 &nbsp;
                                    <input type="radio"	name="group_ok_${g.group_name }" value="N"	onchange="changeLogin(this);"> 제한 &nbsp;
                                </c:if>
                                <c:if test="${g.group_ok eq 'N' }">
                                    <input type="radio"	name="group_ok_${g.group_name }" value="Y"	onchange="changeLogin(this);"> 가능 &nbsp;
                                    <input type="radio" name="group_ok_${g.group_name }" value="N"	checked	onchange="changeLogin(this);"> 제한 &nbsp;
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
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
		<c:url var="bl" value="/glist.do">
			<c:param name="page" value="1" />
		</c:url>
		<a href="${ bl }">[맨처음]</a> &nbsp;
	</c:if>
	<!-- 이전 페이지그룹으로 이동 처리 -->
	<c:if test="${ (currentPage - 10) < startPage and (currentPage - 10) > 0 }">
		<c:url var="bl2" value="/glist.do">
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
			<c:url var="bl3" value="/glist.do">
				<c:param name="page" value="${ p }" />
		</c:url>
		<a href="${ bl3 }">${ p }</a> 
		</c:if>
	</c:forEach>
	<!-- 다음 페이지그룹으로 이동 처리 -->
	<c:if test="${ (currentPage + 10) > endPage and ((endPage%10)==0) and listCount > ( endPage*limit ) }">
		<c:url var="bl4" value="/glist.do">
			<c:param name="page" value="${ endPage + 1 }" />
		</c:url>
		<a href="${ bl4 }">[다음그룹]</a> &nbsp;
	</c:if>
	<!-- 끝페이지로 이동 처리 -->
	<c:if test="${ currentPage eq maxPage }">
		[맨끝] &nbsp; 
	</c:if>
	<c:if test="${ currentPage < maxPage }">
		<c:url var="bl5" value="/glist.do">
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
			<c:if test="${ action eq 'owner' }">
				<c:url var="nsl" value="gsearowner.do">
					<c:param name="keyword" value="${ keyword }" />
					<c:param name="page" value="1" />
				</c:url>
			</c:if>
		
			<c:if test="${ action eq 'groupok' }">
				<c:url var="nsl" value="gsearchGOk.do">
					<c:param name="keyword" value="${ keyword }" />
					<c:param name="page" value="1" />
				</c:url>
			</c:if>
		<a href="${ nsl }">[맨처음]</a> &nbsp;
	</c:if>
	<!-- 이전 페이지그룹으로 이동 처리 -->
	<c:if test="${ (currentPage - 10) < startPage and (currentPage - 10) > 0 }">
		<c:if test="${ action eq 'owner' }">
				<c:url var="nsl" value="gsearowner.do">
					<c:param name="keyword" value="${ keyword }" />
					<c:if test="${currentPage%10==0 }">
							<c:param name="page" value="${ startPage-1 }" />
						</c:if>
						<c:if test="${currentPage%10!=0 }">
							<c:param name="page" value="${ currentPage - (currentPage%10) }" />
						</c:if>
				</c:url>
			</c:if>
		
			<c:if test="${ action eq 'groupok' }">
				<c:url var="nsl" value="gsearchGOk.do">
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
			<c:if test="${ action eq 'owner' }">
				<c:url var="nsl" value="gsearowner.do">
					<c:param name="keyword" value="${ keyword }" />
					<c:param name="page" value="${ p }" />
				</c:url>
			</c:if>
		
			<c:if test="${ action eq 'groupok' }">
				<c:url var="nsl" value="gsearchGOk.do">
					<c:param name="keyword" value="${ keyword }" />
					<c:param name="page" value="${ p }" />
				</c:url>
			</c:if>
			<a href="${ nsl }">${ p }</a> 
		</c:if>
	</c:forEach>
	<!-- 다음 페이지그룹으로 이동 처리 -->
	<c:if test="${ (currentPage + 10) > endPage and ((endPage%10)==0) and listCount > ( endPage*limit ) }">
		<c:if test="${ action eq 'owner' }">
				<c:url var="nsl" value="gsearowner.do">
					<c:param name="keyword" value="${ keyword }" />
					<c:param name="page" value="${ endPage + 1 }" />
				</c:url>
			</c:if>
		
			<c:if test="${ action eq 'groupok' }">
				<c:url var="nsl" value="gsearchGOk.do">
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
		<c:if test="${ action eq 'owner' }">
				<c:url var="nsl" value="gsearowner.do">
					<c:param name="keyword" value="${ keyword }" />
					<c:param name="page" value="${ maxPage }" />
				</c:url>
			</c:if>
		
			<c:if test="${ action eq 'groupok' }">
				<c:url var="nsl" value="gsearchGOk.do">
					<c:param name="keyword" value="${ keyword }" />
					<c:param name="page" value="${ maxPage }" />
				</c:url>
			</c:if>
		
		<a href="${ nsl }">[맨끝]</a> &nbsp;
	</c:if>
</div>
</c:if> <!-- 검색 목록 페이징 처리 -->
</body>
</html>