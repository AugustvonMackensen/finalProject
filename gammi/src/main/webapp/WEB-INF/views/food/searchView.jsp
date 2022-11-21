<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="keyword" value="${ requestScope.keyword }" />
<c:set var="imgPath" value="${ requestScope.imgPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<script type="text/javascript" src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.1.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=324b64b39cfcbbd4195127e6b989c7fd&libraries=services"></script>
<script type="text/javascript">
function imgSearch(){
	location.href="imgSearch.do";
}

function keywordSearch(){
	location.href="result.do";
}

function camSearch(){
	location.href="camSearch.do";
}

var markers = [];

var mapContainer = document.getElementById('map'),
	mapOption = {
		center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
	    level: 3 // 지도의 확대 레벨
	};

//지도 생성
var map = new kakao.maps.Map(mapContainer, mapOption);

//장소 검색 객체
var ps = new kakao.maps.services.Places();

//검색 결과 목록이나 마커 클릭 시 장소명을 표출할 인포윈도우 생성
var infowindow = new kakao.maps.InfoWindow({zIndex: 1})

searchPlaces();

function searchPlaces(){
	var keyword = document.getElementById('keyword').value;
	
	if(!keyword.replace(/^\s+|\s+$/g, '')){
		alert('키워드를 입력해주세요!');
		return false;
	}
	
	//장소검색 요청
	ps.keywordSearch(keyword, placeSearch);
}

function placeSearch(data, status. pagination){
	if(status == kakao.maps.services.Status.OK){
		//정상적 검색이 완료되면 검색 목록과 마커 표출
		displayPlaces(data);
		
		//페이지 번호 표출
		displayPagination(pagination);
		
	}else if(status == kakao.maps.services.Status.ZERO_RESULT){
		document.getElementById('restaurantMap-wrap').innerHTML = "주변 식당 검색 결과가 없습니다.";
	
	}else if(status == kakao.maps.services.Status.ERROR){
		alert("검색 결과 중 오류가 발생했습니다.")
	}
}

//주변위치 검색 결과 목록과 마커 표출
function displayPlaces(places){
	
	var list = document.getElementById('placesList');
	bounds = new kakao.maps.LatLngBounds();
	listStr = '';
	
	//검색 결과 목록에 추가된 항목들 제거
	removeAllChildNods(list);
	
	//마커 제거
	removeMarker();
	
	for (var i=0; i < places.length; i++){
		//마커 생성
		var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x),
			marker = addMarker(placePosition, i),
			item = getListItem(i, places[i])
	}
	
	//검색된 장소 위치를 기준으로 지도 범위 재설정
	bounds.extend(placePosition);
	
	//마커와 검색결과 항목에 마우스를 가져다대면
	//해당 장소의 인포윈도우에 장소명 표시
	//mouseout 시 인포윈도우 닫음
	(function(marker, title)){
		kakao.maps.event.addListen(marker, 'mouseover', function(){
			displayInfowindow(marker, title);
		})
		kakao.maps.event.addListen(marker, 'mouseout', function(){
			infowindow.close();
		})
	}
}

</script>
</head>
<body>
<div class="search-box">
	<input id="keyword" class="search-txt" type="text" value="${ keyword }" placeholder="음식을 입력해주세요.">
	<button type="button" class="btm_image" id="img_btn" onclick="camSearch();">
		<img class="btn_image2" src="resources/img/camera4.png">
	</button>
	<button type="button" class="btm_image2" id="img_btn2"
		onclick="imgSearch();">
		<img class="btn_image3" src="resources/img/picture.png">
	</button>
	<input class="search-button" type="button" value="검색"
		onclick="keywordSearch();">
</div>
<img src="${ imgPath }">
검색 결과 예시창
<div id="restaurantMap-wrap" class="restaurantMap-wrap">
	<div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>
	
	<div id="restaurant_menu">
		<div class="option">
			<ul id="placesList"></ul>
			<div id="pagination"></div>
		</div>
	</div>
</div>
</body>
</html>