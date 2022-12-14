<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<link rel="stylesheet" href="resources/css/band-clone.css"
	type="text/css">
<style>
</style>
</head>
<body>

	<c:import url="/WEB-INF/views/common/menubar.jsp" />
	<c:if test="${ group.group_ok eq 'Y' }">
		<div style="background-color: #F7F8F9;">
			<c:import url="/WEB-INF/views/common/somoimsidebar.jsp" />
			<div
				style="padding: 1px 16px; height: 800px; display: flex; margin-left: 20%; max-width: 1100px;">
				<br>
				<br>
				<div>
					<div class="gal_width">
						<br>
						<br>
						<h4 style="font-family: 'CookieRun';">'${ group.group_name }'
							모임에 오신것을 환영합니다.</h4>
						<h4 style="font-family: 'CookieRun';">멤버관리를 통해 자기만의 소모임을
							만들어보세요!</h4>
						<br>
						<div class="thumb">
							<c:if test="${ empty groups.group_img }">
								<img class="thumb" src="resources/img/banner.png" alt="무사진">
							</c:if>
							<c:if test="${ !empty groups.group_img }">
								<img class="thumb"
									src="resources/groupImg/${ groups.group_img }">
							</c:if>
						</div>
						<br>
						<div>
							<c:if test="${ group.group_owner eq member.m_id }">
								<button class="rightbtn2"
									onclick="javascript:location.href='delGroup.do?gno=${ group.group_no }'">
									<span class="tooltip3">그룹 해체<span class="tooltip-text">그룹이
											삭제됩니다.<br>모임장만 가능합니다.
									</span></span>
								</button>
							</c:if>
						</div>
						<div>
							<div style="margin : 10px;">
								<h3 style="font-family: 'Noto Sans KR', sans-serif;">
									<span class="tooltip2">모임장<span class="tooltip-text">멤버들을
											관리할 사람을 말합니다.</span></span> : ${ group.group_owner }
								</h3>
							</div>
							<div style="margin : 10px;">
								<h3 style="font-family: 'Noto Sans KR', sans-serif;">모임 소개
									: ${ group.group_info }</h3>
							</div>
							<div style="margin : 10px;">
								<h3 style="font-family: 'Noto Sans KR', sans-serif;">모임 개설일
									: ${ group.group_date }</h3>
							</div>
						<div style="margin : 10px;">
								<h3 style="font-family: 'Noto Sans KR', sans-serif;">
									<span class="tooltip2">현재가입된인원<span class="tooltip-text">가입가능한
											인원은 최대 10명입니다.</span></span> : ${memberCount }
								</h3>
							</div>
						</div>
						<br>

					</div>
				</div>
				<br>
			</div>
	</c:if>
	<c:if test="${ group.group_ok eq 'N' }">
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<h1>현재 모임 사용이 정지 되었습니다. 위반 사항 확인 중입니다.</h1>
		<div class="writelistbtn">
			<button class="rightbtn3"
				onclick="javascript:location.href='group.do'">목록으로 돌아가기</button>
		</div>
	</c:if>
	<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>