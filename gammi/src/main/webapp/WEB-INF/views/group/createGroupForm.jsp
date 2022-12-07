<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
<c:import url="/WEB-INF/views/common/menubar.jsp" />

<form action="groupinsert.do" method="post" enctype="multipart/form-data">
    <div class="board_wrap">
        <div class="board_title">
            <strong>모임생성</strong>
           <p>모임을 빠르고 정확하게 만들수있습니다.</p>
        </div>
        <div class="board_write_wrap">
            <div class="board_write">
                <div class="title">
                    <dl>
                        <dt>그룹명</dt>
                        <dd><input type="text" name="group_name" required></dd>
                    </dl>
                </div>
                <div class="info">
                    <dl>
                        <dt>작성자</dt>
                        <dd><input type="text" name="group_owner" readonly value="${ sessionScope.loginMember.m_id }" required></dd>
                    </dl>
                    <dl>
                        <dt>첨부파일</dt>
                        <dd>				<!-- 	<input type="file" name="upfile" -->
                            <input type="file" name="upfile">
                        </dd>
                    </dl>
                </div>
                <div class="cont">
                    <textarea rows="5" cols="50" name="group_info" required></textarea>
                </div>
            </div>
            <div class="bt_wrap">
                <input class="rightbtn7" type="submit" value="등록하기">
                &nbsp; <input class="rightbtn9" type="reset" value="작성취소"> &nbsp;
                <button class="rightbtn8" onclick="javascript:location.href='group.do';">목록</button>
        </div>
        </div>
    </div>
</form>
<br>
<hr>
<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>
