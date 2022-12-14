<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="resources/css/band-clone.css"
	type="text/css">
</head>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
//멤버 상태 변경(가입수락, 가입 거부 처리, 추방처리)
function mGrade(no, id, num){
	var m = new Object();
	m.group_no = String(no);
	m.m_id=id;
	m.num = String(num);
	$.ajax({
		url: "mGrade.do",
		type: "post",
		data: JSON.stringify(m),
		contentType: "application/json; charset=utf-8",
		dataType: "json",
		success: function(result){
			if('${group.group_owner}' != '${ sessionScope.loginMember.m_id }'){
				location.href="group.do";
			}else{
			location.href="groupMemberManagement.do?gno="+result.group_no;
			}
		},
		error: function(request, status, errorData){
			console.log("error code : " + request.status
					+ "\nMessage : " + request,responseText
					+ "\nError : " + errorData);
		}
	});
}
</script>
<body>
	<c:import url="/WEB-INF/views/common/menubar.jsp" />
	<div style="background-color: #F7F8F9;">
		<c:import url="/WEB-INF/views/common/somoimsidebar.jsp" />
		<div
			style="margin-left: 30%; padding: 1px 16px; height: 1000px; width: 1430px;">
			<h4 style="font-family: 'CookieRun';">
				신청 목록을 확인 후<br> 멤버들을 관리해보세요!
			</h4>
			<c:if test="${ group.group_owner ne sessionScope.loginMember.m_id  }">
			<div class="writelistbtn2">
			<button class="rightbtn3" onclick="mGrade(${gno}, '${ sessionScope.loginMember.m_id }', 3);">탈퇴하기</button>
			</div>
			</c:if>
			<div>
				<hr class="hline">
				<br>
				<h3 style=" font-family: 'Noto Sans KR', sans-serif;">모임 멤버 목록</h3>
				<br>
				<c:forEach var="gm" items="${gm}" varStatus="mem_status">
					<c:if test="${ gm.member_grade  == 3 }">
						<p style=" font-family: 'Noto Sans KR', sans-serif;">${gm.m_id}님
						</p>
						<p style=" font-family: 'Noto Sans KR', sans-serif;">가입 날짜 : ${ gm.member_grade_date }</p>
						<div class="writelistbtn2">
						<c:if test="${ group.group_owner eq sessionScope.loginMember.m_id  }">
							<button class="rightbtn3"
								onclick="mGrade(${gm.group_no}, '${ gm.m_id }', 3);">추방하기</button>
						</c:if>
						</div>
						<br>
						<br>
					</c:if>
				</c:forEach>
				<hr class="hline">
				<br>
				<h3 style=" font-family: 'Noto Sans KR', sans-serif;">가입대기자 목록</h3>
				<br>
				<c:forEach var="gm" items="${gm}" varStatus="mem_status">
					<c:if test="${ gm.member_grade < 2 }">
						<p style=" font-family: 'Noto Sans KR', sans-serif;">${gm.m_id}:님</p>
						<p style=" font-family: 'Noto Sans KR', sans-serif;">가입 신청날짜 : ${ gm.member_grade_date }</p>
						<div class="writelistbtn2">
						<c:if test="${ group.group_owner eq sessionScope.loginMember.m_id  }">
							<button class="rightbtn3"
								onclick="mGrade(${gm.group_no}, '${ gm.m_id }', 1);">가입
								수락</button>
							<button class="rightbtn3"
								onclick="mGrade(${gm.group_no}, '${ gm.m_id }', 3);">가입
								거절</button>
						</c:if>
						</div>
						<br>
					</c:if>
				</c:forEach>
				<hr class="hline">
				<br>
			</div>
		</div>
	</div>
</body>
</html>