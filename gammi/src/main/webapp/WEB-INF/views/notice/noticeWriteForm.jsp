<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	<link rel="stylesheet" href="resources/css/upload.css">
	<script src="resources/js/upload.js"></script>
	<!-- 절대경로로 대상 파일의 위치를 지정한 경우 -->
	<c:import url="/WEB-INF/views/common/menubar.jsp" />
	<form action="ninsert.do" method="post" enctype="multipart/form-data">
		    <div class="board_wrap">
        <div class="board_title">
            <strong>공지사항[관리자용]</strong>
            <p>공지사항을 빠르고 정확하게 안내해드립니다.</p>
        </div>
        <div class="board_write_wrap">
            <div class="board_write">
                <div class="title">
                    <dl>
                        <dt>제목</dt>
                        <dd><input type="text" name="notice_title"></dd>
                    </dl>
                </div>
                <div class="info">
                    <dl>
                        <dt>작성자</dt>
                        <dd><input type="text" name="notice_writer" readonly
                            value="${ sessionScope.loginMember.m_id }"></dd>
                    </dl>
                    <dl>
                        <dt>첨부파일</dt>
                        <dd>				<!-- 	<input type="file" name="upfile" -->
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <div class="preview-zone hidden">
                                            <div class="box2 box-solid">
                                                <div class="box-header with-border"></div>
                                                <div class="box-body"></div>
                                            </div>
                                        </div>
                                        <div class="dropzone-wrapper">
                                            <div class="dropzone-desc">
                                                <i class="glyphicon glyphicon-download-alt"></i>
                                                <p>이미지 파일을 업로드</p>
                                            </div>
                                            <input type="file" name="upfile" class="dropzone">
                                        </div>
                                    </div>
                                </div>
                            </div>
        </dd>
                    </dl>
                </div>
                <div class="cont">
                    <textarea rows="5" cols="50" name="notice_content"></textarea>
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








