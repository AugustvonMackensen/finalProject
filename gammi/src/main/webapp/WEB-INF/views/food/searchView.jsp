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
	var input = document.getElementById('searchKeyword').value;
	location.href="result.do?keyword=" + input;
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
	
		//검색된 장소 위치를 기준으로 지도 범위 재설정
		bounds.extend(placePosition);
		
		//마커와 검색결과 항목에 마우스를 가져다대면
		//해당 장소의 인포윈도우에 장소명 표시
		//mouseout 시 인포윈도우 닫음
		(function(marker, title){
			kakao.maps.event.addListen(marker, 'mouseover', function(){
				displayInfowindow(marker, title);
			});
			kakao.maps.event.addListen(marker, 'mouseout', function(){
				infowindow.close();
			});
			
			item.onmouseover = function(){
				displayInfoWindow(marker, title);
			};
			
			item.onmouseout = function(){
				infowindow.close();
			};
		})(marker, places[i].place_name);
		
		fragment.appendChild(item);
	}
	
	//검색결과 항목 목록 element에 추가
	list.appendChild(fragment);
	
	//검색된 장소 위치를 기준으로 지도 범위 재설정
	map.setBounds(bounds);
}

//검색결과 항목 element 반환 함수
function getListItem(index, places){
	var li = document.createElement('li'),
	itemStr = '<div class="info">' + 
				'\n <h5>' + places.place_name + '</h5>';
	
	if(places.road_address_name){
		itemStr += '\n <span>' + places.road_address_name + '</span>'
				+ '<span>' + places.address_name + '</span>';
	}else {
		itemStr += '\n <span>' + places.address_name + '</span>';
	}
	
	li.innerHTML = itemStr
	li.className = 'item';
	
	return li;
}

//마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
function addMarker(position, idx, title) {
    var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
        imageSize = new kakao.maps.Size(36, 37),  // 마커 이미지의 크기
        imgOptions =  {
            spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
            spriteOrigin : new kakao.maps.Point(0, (idx*46)+10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
            offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
        },
        markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
            marker = new kakao.maps.Marker({
            position: position, // 마커의 위치
            image: markerImage 
        });

    marker.setMap(map); // 지도 위에 마커를 표출합니다
    markers.push(marker);  // 배열에 생성된 마커를 추가합니다

    return marker;
}

// 지도 위에 표시되고 있는 마커를 모두 제거합니다
function removeMarker() {
    for ( var i = 0; i < markers.length; i++ ) {
        markers[i].setMap(null);
    }   
    markers = [];
}

// 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
function displayPagination(pagination) {
    var paginationEl = document.getElementById('pagination'),
        fragment = document.createDocumentFragment(),
        i; 

    // 기존에 추가된 페이지번호를 삭제합니다
    while (paginationEl.hasChildNodes()) {
        paginationEl.removeChild (paginationEl.lastChild);
    }

    for (i=1; i<=pagination.last; i++) {
        var el = document.createElement('a');
        el.href = "#";
        el.innerHTML = i;

        if (i===pagination.current) {
            el.className = 'on';
        } else {
            el.onclick = (function(i) {
                return function() {
                    pagination.gotoPage(i);
                }
            })(i);
        }

        fragment.appendChild(el);
    }
    paginationEl.appendChild(fragment);
}

// 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
// 인포윈도우에 장소명을 표시합니다
function displayInfowindow(marker, title) {
    var content = '<div style="padding:5px;z-index:1;">' + title + '</div>';

    infowindow.setContent(content);
    infowindow.open(map, marker);
}

 // 검색결과 목록의 자식 Element를 제거하는 함수입니다
function removeAllChildNods(el) {   
    while (el.hasChildNodes()) {
        el.removeChild (el.lastChild);
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