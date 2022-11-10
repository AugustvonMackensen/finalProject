<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=324b64b39cfcbbd4195127e6b989c7fd&libraries=services"></script>
<script type="text/javascript">
var markers = [];

var mapContainer = document.getElementById('map'),
	mapOption = {
		center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
	    level: 3 // 지도의 확대 레벨
	};

//지도 생성
var map = new kakao.maps.Map(mapContainer, mapOption);
</script>
</head>
<body>
검색 결과 예시창
<div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>
</div>
</body>
</html>