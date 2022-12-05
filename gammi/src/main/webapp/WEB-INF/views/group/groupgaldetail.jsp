<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>
<html>
<head>>
<meta charset="UTF-8">
<title></title>
</head>
<body>
<!-- 절대경로로 대상 파일의 위치를 지정한 경우 -->
	<c:import url="/WEB-INF/views/common/menubar.jsp" />
  <div class="board_wrap">
        <div class="board_title">
            <strong>갤러리게시판</strong>
        </div>
        <div class="board_view_wrap">
            <div class="board_view">
                <div class="title">
                    ${ gammiGroupGal.gal_title }
                </div>
                <div class="info">

                    <dl>
                        <dt>작성자</dt>
                        <dd>${ gammiGroupGal.gal_id }</dd>
                    </dl>
                    <dl>
                        <dt>날 짜</dt>
                        <dd>${ gammiGroupGal.gal_date }</dd>
                    </dl>
                </div>
                <div class="cont">
                    ${ gammiGroupGal.gal_content } <br>
                    <c:forEach items="${ gal_img }"  var ="gal_img">
                    <img class="thumb" src = "resources/groupGalImg/${ gal_img.gal_rename_image }"></td></tr>
                     </c:forEach>
                </div>

            </div>
            <div class="bt_wrap">
                <c:url var="movenup" value="/updategal2.do">
                    <c:param name="gal_no" value="${ gammiGroupGal.gal_no }" />		
                </c:url>
                 <button class="rightbtn7" onclick="javascript:location.href='${ movenup }';">수정하기</button>
                 <c:url var="ndel" value="/galdel.do">
                    <c:param name="gal_no" value="${ gammiGroupGal.gal_no }" />
                    <c:param name="gno" value="${ gammiGroupGal.group_no }" />
                </c:url>
                <button class="rightbtn9" onclick="javascript:location.href='${ ndel }';">글삭제</button>
                <button class="rightbtn8" onclick="javascript:history.go(-1);">목록</button>
            </div>
        </div>
    </div>
<br>
<hr>
<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>
