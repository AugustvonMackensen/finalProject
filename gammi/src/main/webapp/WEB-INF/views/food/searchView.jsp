<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" errorPage="error.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="keyword" value="${ requestScope.keyword }" />
<c:set var="imgPath" value="${ requestScope.imgPath }" />
<!DOCTYPE html>
<html lang="ko">

<link
	href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@700&family=Noto+Sans+KR:wght@500;700&display=swap"
	rel="stylesheet">
<link rel="stylesheet" href="resources/css/craw_search.css"
	type="text/css">
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="resources/js/map.js"></script>
<link rel="stylesheet" href="resources/css/craw_search.css"
	type="text/css">
<style>
.v-line {
	margin-top: -20px;
	margin-left: 100px;
	border-left: thick solid #bfc9cd;
	height: 830px;
}
</style>

<script type="text/javascript">
	function imgSearch() {
		location.href = "imgSearch.do";
	}

	function keywordSearch() {
		var keyword = $("#keyword").val();
		location.href = "result.do?keyword=" + keyword;
	}

	function camSearch() {
		location.href = "camSearch.do";
	}
	
	$(function(){
		$("#keyword").keydown(function (key) {
		    if (key.keyCode == 13) {
		    	keywordSearch();
		    }
		});
		});
</script>
<body>
	<c:import url="/WEB-INF/views/common/menubar.jsp" />
	<div id="preloder">
		<div class="loader"></div>
	</div>
	<div>
		<div class="header__logo">
			<br> <br> <a href="./index.html"><h1
					style="font-family: 'CookieRun'; font-size: 50px; color: white; letter-spacing: 5px;">
					음식이 맛있다!<br>감미
				</h1></a><br> <br> <br>
			<div class="search-box">
				<input id="keyword" class="search-txt" type="text"
					value="${ keyword }" placeholder="음식을 입력해주세요.">
				<button type="button" class="btm_image" id="img_btn"
					onclick="camSearch();">
					<img class="btn_image2" src="resources/img/camera4.png">
				</button>
				<button type="button2" class="btm_image2" id="img_btn2"
					onclick="imgSearch();">
					<img class="btn_image3" src="resources/img/picture.png">
				</button>
				<input class="search-button" type="button" value="검색"
					onclick="keywordSearch();">
			</div>
		</div>
	</div>
	<br>
	<!-- 정보 없을때 -->
	<c:if test="${empty food_info }">
		<div style="display: grid;  place-items: center;  min-height: 40vh;">
				<h1 style=" font-family: 'Noto Sans KR', sans-serif;">
					해당하는 음식 정보가 존재하지 않습니다.
				</h1>
		</div>
	</c:if>
	<c:if test="${!empty food_info }">
	<div class="bgc">
		<div style="display: flex;">
			<div>
				<h3 style="font-family: 'CookieRun'; font-size: 30px;">${ keyword}에
					대한 정보를 확인해보세요!</h3>

				<div style="display: flex" class="craw_main">
					<img class="craw_img" src="${ food_info.recipe_img }">

					<p style="width: 800px; height: 500px; overflow: auto;">${ food_info.food_content }</p>
				</div>
			</div>

			<div style="width: 1100px; margin-left: 300px;">
				<h3 style="font-family: 'CookieRun'; font-size: 30px;">${ keyword}에
					대한 맛집 정보입니다!</h3>
				<br>
				<div id="map" style="width: 53%; height: 450px;"></div>
				<button
					style="color: white; border: 1px solid; width: 150px; height: 30px; background: #edbebe;"
					type="button" onclick="getCurrentPosBtn()" id="getMyPositionBtn">내
					위치 가져오기</button>
				<script type="text/javascript"
					src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9a6ce1083b2328d5c7a283595f746ae1&libraries=services"></script>
				<script>
					// 마커를 클릭하면 장소명을 표출할 인포윈도우 입니다
					var infowindow = new kakao.maps.InfoWindow({
						zIndex : 1
					});
					var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
					mapOption = {
						center : new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
						level : 2
					// 지도의 확대 레벨
					};
					// 지도를 생성합니다    
					var map = new kakao.maps.Map(mapContainer, mapOption);
					// 장소 검색 객체를 생성합니다
					var ps = new kakao.maps.services.Places();
					// 키워드로 장소를 검색합니다
					ps.keywordSearch('${keyword}', placesSearchCB);
					// 키워드 검색 완료 시 호출되는 콜백함수 입니다
					function placesSearchCB(data, status, pagination) {
						if (status === kakao.maps.services.Status.OK) {
							// 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
							// LatLngBounds 객체에 좌표를 추가합니다
							var bounds = new kakao.maps.LatLngBounds();
							for (var i = 0; i < data.length; i++) {
								displayMarker(data[i]);
								bounds.extend(new kakao.maps.LatLng(data[i].y,
										data[i].x));
							}
							// 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
							map.setBounds(bounds);
						}
					}
					// 지도에 마커를 표시하는 함수입니다
					function displayMarker(place) {

						// 마커를 생성하고 지도에 표시합니다
						var marker = new kakao.maps.Marker({
							map : map,
							position : new kakao.maps.LatLng(place.y, place.x)
						});
						// 마커에 클릭이벤트를 등록합니다
						kakao.maps.event
								.addListener(
										marker,
										'click',
										function() {
											// 마커를 클릭하면 장소명이 인포윈도우에 표출됩니다
											infowindow
													.setContent('<div style="padding:5px;font-size:12px;">'
															+ place.place_name
															+ '</div>');
											infowindow.open(map, marker);
										});
					}
				</script>
			</div>
		</div>
		<br>
		<br>
		<hr style="margin-top: -2px; border: 2px solid #bfc9cd;">
		<section>
			<br>
			<div>
				<h3 style="font-family: 'CookieRun'; font-size: 30px;">${ keyword }에
					대한 레시피 정보입니다!</h3>
				<div class="craw_recipe">
					<br> <br>
					<ul>
						<c:forEach var="recipe" items="${ recipe_list }"
							varStatus="recipe_status">
							<li class="model"><a target="_blank"
								href="${recipe.recipe_url }"> <img class="thumb"
									src="${recipe.recipe_img }">
									<div>
										<p class="overdiv">${ recipe.recipe_title }<br>조회수 :
											${recipe.recipe_readcount }회
										</p>
									</div>
							</a></li>
					</ul>
					</c:forEach>
				</div>
			</div>
		</section>
	</div>
	</c:if>
	<!-- Categories Section End -->
	<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>

</html>