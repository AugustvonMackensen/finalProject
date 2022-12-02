<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title></title>
    <link rel="stylesheet" href="resources/css/style2.css" type="text/css">
	<link rel="stylesheet" href="resources/css/media.css" type="text/css">
</head>
<body>

	<c:import url="/WEB-INF/views/common/menubar.jsp" />

	<hr>
	<h2 align="center">새로운 모임 생성</h2>
	<!-- form 태그에서 입력된 값들(문자열)과 첨부파일을 같이 전송하려면,
   반드시 enctype 속성을 form 태그에 추가해야 됨
   enctype="multipart/form-data" 값을 지정해야 함
   method="post" 로 지정해야 함
 -->

	<form name="fileForm" action="groupgalinsert.do" method="post"
		enctype="multipart/form-data">
		<input type="hidden" name="gno" value="${gno}">
<div class="board_wrap">
        <div class="board_title">
            <strong>갤러리게시판</strong>
            <p>글쓰기를 통해 사진을 공유해보세요!</p>
        </div>
        <div class="board_write_wrap">
            <div class="board_write">
                <div class="title">
                    <dl>
                        <dt>제목</dt>
                        <dd><input type="text" placeholder="제목 입력" name = "gal_title"></dd>
                    </dl>
                </div>
                <div class="info">
                    <dl>
                        <dt>작성자</dt>
                        <dd><input type="text" name="gal_id" readonly
					value="${ sessionScope.loginMember.m_id }"></dd>
                    </dl>
                    <dl>
                        <dt>첨부파일</dt>
                        <dd><input multiple="multiple" type="file" name="file" />test1.jpg ,test2.jpg</dd>
                        
                    </dl>
                </div>
                <div class="cont">
                    <textarea placeholder="내용 입력" name = "gal_content"></textarea>
                </div>
            </div>
            <div class="bt_wrap">
					<input class="rightbtn7" type="submit" value="등록하기">
					&nbsp; <input class="rightbtn9" type="reset" value="작성취소"> &nbsp;
					<button class="rightbtn8" onclick="javascript:history.go(-1); return false;">목록</button>
            </div>
        </div>
    </div>
	</form>
	<br>
	<hr>
	<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>