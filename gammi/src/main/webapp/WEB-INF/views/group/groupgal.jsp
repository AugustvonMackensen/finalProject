<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
    <link rel="stylesheet" href="resources/css/groupgal.css" type="text/css">

<body>
<c:import url="/WEB-INF/views/common/menubar.jsp" />
<div style="background-color: #F7F8F9;">
<c:import url="/WEB-INF/views/common/somoimsidebar.jsp"/>
<div style="margin-left:25%;padding:1px 16px;height:1000px;">
	<c:if test="${ !empty groupgals }">
	   <br><br>
	    <div class="bgc">
			<div class="gal_width">
	        <br><br>
	        <h4  style=" font-family:'CookieRun';">음식, 취향에 맞는 사람들끼리 <br> 음식을 전시해보세요!</h4>
	        <br><br>
	        <ul class="ulflex">
	        <c:forEach var="groupgals" items="${groupgals}" varStatus="groupgals_status"> 
	            <li class="liflex">
	          <c:url var="bdt" value="/groupgaldetail.do">
	            <c:param name="gal_no" value="${ groupgals.gal_no }" />
	            <c:param name="group_no" value="${ gno }"/>
	         </c:url>
	             	<c:if test="${ empty groupgals.gal_image }">
						<a href="${bdt}"><img class="thumb" src="resources/img/food2.jpg" alt="무사진"></a>
					</c:if>
	
					<c:if test="${ !empty groupgals.gal_image }">
						<a href="${bdt}"><img class="thumb" src="resources/groupGalImg/${ groupgals.gal_image}" alt="무사진"></a>
					</c:if>
	                <p class="uploadtitle">제목 : ${groupgals.gal_title}</p>
	                <p class="uploadname">작성자 : ${groupgals.gal_id }</p>
	                <p class="uploaddate">작성일자 : ${groupgals.gal_date }</p>
	            </li>
	
			</c:forEach>
	        </ul>
	        <button class="rightbtn2" onclick="javascript:location.href='creategroupgal.do?gno=${gno}';">글쓰기</button>
	
	       <br>
	       <br><br>
	       <form action="">
	        <div style="display:flex;  justify-content: center;  margin: 0px 0px 0px 200px;">
	            <select id="test" onchange="Change()"  style="position: relative; border: 1px solid #ccc; left: -198px; width:5rem; height:3rem;  text-align:center">
	            <option value="1">제목</option>
	            <option value="2">내용</option>
	             </select>
	            <div id="d1" style="display: block">
	               <form action="qna.do" method="post" >
	                  <input type="search" name="keyword" style="width: 26rem;height:3rem; border: 1px solid #ccc; margin-left:-198px; ">
	                  <input type="submit" value="검색"  style="width: 5.5rem;height:3rem;border:none; margin-left: -7px; background: #555;color: #fff; cursor:pointer;  margin-top:-3px;" class="btn">
	               </form>
	            </div>
	            <div id="d2" style="display: none">
	            <form action="qna.do" method="post">   
	                 <input type="search" name="keyword" style="width: 26rem;height:3rem; border: 1px solid #ccc; margin-left:-198px; ">
	                 <input type="submit" value="검색"  style="width: 5.5rem; height:3rem; margin-left: -7px; border:none;background: #555; color: #fff; cursor:pointer;  margin-top:-3px;" class="btn">
	               </form>
	            </div>
	            </div>
	      </form>
	        <br>
	</div>
	</div>
		</c:if>
		<c:if test="${ empty groupgals }">
				<div style="display: grid;  place-items: center;  min-height: 80vh;">
					<h1 style=" font-family: 'Noto Sans KR', sans-serif;">
					현재 생성된 갤러리가 없습니다.<br>
					</h1>
					    
				</div>
			
			<div style="margin-right : 50px;">
		<button class="rightbtn4" onclick="javascript:location.href='creategroupgal.do?gno=${gno}';">글쓰기</button>
		</div>
		</c:if>
</div>
</div>
<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>