<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
<!-- 절대경로로 대상 파일의 위치를 지정한 경우 -->
<c:import url="/WEB-INF/views/common/menubar.jsp" />
<hr>
<h2 align="center">${ requestScope.notice.notice_num } 번 공지글 상세보기 [관리자용]</h2>
<br>
    <div class="board_wrap">
        <div class="board_title">
            <strong>공지사항[관리자용]</strong>
            <p>공지사항을 빠르고 정확하게 안내해드립니다.</p>
        </div>
        <div class="board_view_wrap">
            <div class="board_view">
                <div class="title">
                    ${ notice.notice_title }
                </div>
                <div class="info">
                    <dl>
                        <dt>작성자</dt>
                        <dd>${ notice.notice_writer }</dd>
                    </dl>
                    <dl>
                        <dt>날 짜</dt>
                        <dd>${ notice.notice_date }</dd>
                    </dl>
                    <dl>
                        <dt>조회수</dt>
                        <dd>${ notice.notice_readcount }</dd>
                    </dl>
                    <dl>
                        <dt>첨부파일</dt>
                        <!-- 첨부파일이 있다면, 파일명 클릭시 다운로드 실행되게 함 -->
                       <dd> <c:if test="${ !empty notice.notice_original_filename }">
                            <c:url var="nfd" value="nfdown.do">
                                <c:param name="ofile" value="${ notice.notice_original_filename }" />
                                <c:param name="rfile" value="${ notice.notice_rename_filename }" />
                            </c:url>
                            <a href="${ nfd }">${ notice.notice_original_filename }</a>
                        </c:if>
                        <!-- 첨부파일이 없다면 공백으로 처리함 -->
                        <c:if test="${ empty notice.notice_original_filename }">
                            &nbsp;
			            </c:if>
                    </dd>
                    </dl>
                </div>
                <div class="cont">
                    ${ notice.notice_content }
                </div>
    
            </div>
            <div class="bt_wrap">
                <button class="rightbtn8" onclick="javascript:history.go(-1);">목록</button>
		<!-- 수정페이지로 이동 버튼 -->
		<c:url var="movenup" value="/nmoveup.do">
			<c:param name="notice_num" value="${ notice.notice_num }" />			
		</c:url>
		<button class="rightbtn7" onclick="javascript:location.href='${ movenup }';">수정하기</button>
		<!-- 삭제하기 버튼 -->
		<c:url var="ndel" value="/ndel.do">
			<c:param name="notice_num" value="${ notice.notice_num }" />
			<c:param name="rfile" value="${ notice.notice_rename_filename }" />
		</c:url>
		<button class="rightbtn9" onclick="javascript:location.href='${ ndel }';">글삭제</button>
            </div>
        </div>
    </div>
<br>
<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>