<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath == '/' ? '' : pageContext.request.contextPath }" scope="application"></c:set>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://www.youtube.com/iframe_api"></script>
<script type="text/javascript">
$(document).ready(function () {
	$("#navbarDropdownPortfolio").on("click", function () {
		$(".dropdown-menu dropdown-menu-right").slideToggle();
	});
	
	/* data : {
		part : 'snippet',
		maxResults : 1,
		order : 'viewCount',
		q : keyword,
		type : video,
		videoDefinition : high
	}, */
	
	var btn = $("button[name='test']");
	btn.on("click", function () {
		var key = "AIzaSyC19sN2x8XdweXrrAwD_GCAypPd3s9Gfzg";
		var keyword = $("input[name='keyword']").val();
		console.log("검색 키워드 >>>> "+keyword);
		var search = encodeURI(keyword);
		$.ajax({
			type : "GET",
			url : "https://www.googleapis.com/youtube/v3/search?key="+key,
			data : {
				part : 'snippet',
				order : 'viewCount',
				q : keyword,
			},
			success : function (result) {
				console.log(result.items[0].id.videoId);
				onYouTubeIframeAPIReady(result.items[0].id.videoId);
			}
			
		}); // ajax end
		
		var player;
		function onYouTubeIframeAPIReady(url) {
			console.log("hello" + url);
			player = new YT.Player('player', {
				videoId : url,
				width : "560",
				height : "349",
				playerVars : {
					'modestbranding' : 1,
					'autoplay' : 1,
					'controls' : 0,
					'showinfo' : 0,
					'rel' : 0,
					'loop' : 0,
					'playlist' : url
				},
				events: {
					'onReady' : onPlayerReady,
					'onStateChange' : onPlayerStateChange
				}
			});
		}

		function onPlayerReady(event) {
			event.target.playVideo();
		}
		
		function onPlayerStateChange() {
			if(player.getPlayerState() == 1) console.log("재생중");
			else if(player.getPlayerState() == 2) console.log("일시중지");
		}
	});
	
	
	
}); // ready end
	
</script>
<title>Test Page</title>
</head>
<body>
<%@ include file="header.jsp" %>
<input type="text" value="극한직업예고편" name="keyword">
<!-- <button id="search-button" name="test">test</button> -->
<button type="button" class="btn btn-primary" data-toggle="modal" data-target=".bs-example-modal-lg5" name="test">Large modal</button>
<div class="modal fade bs-example-modal-lg5" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div id="player"></div>
    </div>
  </div>
</div>
</body>
</html>