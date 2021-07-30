<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

</head>
<body>
<div id="map" style="width:100%;height:450px;"></div>
<div class="map_wrap">
    <div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>
    <div class="hAddr">
        <span id="centerAddr"></span>
    </div>
</div>
<input type="text" id="searchKeyword">
<input type="text" id="lat">
<input type="text" id="lng">
<button type="button" onclick="resSearch()">검색</button>
</body>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ef662570a1f847f41f5b1b2e24a22e6a&libraries=services"></script>
<script>

if (navigator.geolocation) {

navigator.geolocation.getCurrentPosition(function(position) {
    var lat = position.coords.latitude;
    var lon = position.coords.longitude;
    document.getElementById("lat").value = lat;
    document.getElementById("lng").value = lon;
	var mapContainer = document.getElementById('map');
	var geocoder = new kakao.maps.services.Geocoder();
	
	mapOption = { 
	    center: new kakao.maps.LatLng(lat, lon),
	    level: 3  
	}; 
	
	var map = new kakao.maps.Map(mapContainer, mapOption);
    var locPosition = new kakao.maps.LatLng(lat, lon);
    var marker = new kakao.maps.Marker({  
        map: map, 
        position: locPosition
    }); 
    
    map.setCenter(locPosition);
    
    searchAddrFromCoords(map.getCenter(), displayCenterInfo);
	function searchAddrFromCoords(position, callback) {
	    geocoder.coord2RegionCode(lon, lat, callback);         
	}
	
	function displayCenterInfo(result, status) {
	    if (status === kakao.maps.services.Status.OK) {
	        var infoDiv = document.getElementById('centerAddr');
			
	        for(var i = 0; i < result.length; i++) {
	            if (result[i].region_type === 'H') {
	            	document.getElementById("searchKeyword").value =result[i].address_name; 
	                infoDiv.innerHTML = result[i].address_name;
	                break;
	            }
	        }
	    }    
	}
  });
} // navigator end


// 지도를 생성합니다    
function resSearch() {
	var ps = new kakao.maps.services.Places();
	var lat = document.getElementById("lat").value;
	var lng = document.getElementById("lng").value;
	var searchKeyword = document.getElementById("searchKeyword").value;
	console.log(searchKeyword+"맛집");
	ps.keywordSearch(searchKeyword+"맛집", placesSearchCB); 
}

function placesSearchCB (data, status, pagination) {
    if (status === kakao.maps.services.Status.OK) {

        var bounds = new kakao.maps.LatLngBounds();

        for (var i=0; i<data.length; i++) {
            displayMarker(data[i]);    
            bounds.extend(new kakao.maps.LatLng(data[i].y, data[i].x));
        }       

        map.setBounds(bounds);
    } 
}
function displayMarker(place) {
    var marker = new kakao.maps.Marker({
        map: map,
        position: new kakao.maps.LatLng(place.y, place.x) 
    });

    kakao.maps.event.addListener(marker, 'click', function() {
        infowindow.setContent('<div style="padding:5px;font-size:12px;">' + place.place_name + '</div>');
        infowindow.open(map, marker);
    });
}

</script>
</html>