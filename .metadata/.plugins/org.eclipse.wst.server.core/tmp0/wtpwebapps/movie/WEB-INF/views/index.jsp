<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath == '/' ? '' : pageContext.request.contextPath }" scope="application"></c:set>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
	.carousel-item {
	  height: 75vh;
	  min-height: 500px;
	  background: no-repeat center center scroll;
	  -webkit-background-size: cover;
	  -moz-background-size: cover;
	  -o-background-size: cover;
	  background-size: cover;
	  
	  	}
	
	header {
		background-color: #000000;
	}
</style>
<meta charset="UTF-8">
<meta name="_csrf" content="${_csrf.token}">
<meta name="_csrf_header" content="${_csrf.headerName}">
<link rel="stylesheet" href="${ctx}/resources/css/carousel.css">
<link rel="stylesheet" href="${ctx}/resources/css/test.css">
<link rel="stylesheet" href="${ctx}/resources/css/test1.css">
<script type="text/javascript" src="${ctx}/resources/js/test.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/test1.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://www.youtube.com/iframe_api"></script>
<script type="text/javascript">
		/* function test(title) {
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			$.ajax({
				url : "${ctx}/movie/youtube",
				type : "post",
				beforeSend : function(xhr) {
					xhr.setRequestHeader(header, token);
				},
				data : JSON.stringify(title),
				contentType : "application/json; charset=UTF-8",
				success : function (result) {
					console.log(result);
				}
			});
		} */
		var player;
		function test(title) {
			var key = "AIzaSyC19sN2x8XdweXrrAwD_GCAypPd3s9Gfzg";
			var keyword = title + " 예고편";
			console.log("검색 키워드 >>>> "+keyword);
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
			
			
			function onYouTubeIframeAPIReady(url) {
				console.log("ready url >>>> "+url);
				player = new YT.Player('player', {
					videoId : url,
					width : "560",
					height : "349",
					playerVars : {
						'modestbranding' : 1,
						'autoplay' : 1,
						'controls' : 1,
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
			} // apiready end
		
		function onPlayerReady(event) {
			event.target.playVideo();
		}
		
		function onPlayerStateChange() {
			if(player.getPlayerState() == 1) console.log("재생중");
			else if(player.getPlayerState() == 2) console.log("일시중지");
		}
		
		} // test end
		
		
			
		
	/* $(document).ready(function () {
		let timeout;
		var video = $("img[name='movieImg1']");
		
		video.mouseenter(function () {
			timeout = window.setTimeout(() => {
				console.log(title.title);
			});
		})
		
		
		video.mouseout(function () {
			window.clearTimeout(timeout);
		});
	}); */

</script>
<title>Insert title here</title>
</head>
<body style="background-color: #000000;">
<%@ include file="header.jsp" %>
<header>
  <div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
    <ol class="carousel-indicators">
      <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
      <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
      <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
    </ol>
    <div class="carousel-inner" role="listbox" >
      <!-- Slide One - Set the background image for this slide in the line below -->
      <div class="carousel-item active" style="background-image: url(${ctx}/resources/images/익스트랙션배경.jpg)">
        <div class="carousel-caption d-none d-md-block">
          <h3 class="display-4">익스트랙션</h3>
          <p class="lead">마약집안 아들래미 구출작전</p>
        </div>
      </div>
      <!-- Slide Two - Set the background image for this slide in the line below -->
      <div class="carousel-item" style="background-image: url(${ctx}/resources/images/신세계가로.jpg)">
        <div class="carousel-caption d-none d-md-block">
          <h3 class="display-4">신세계</h3>
          <p class="lead">경찰의 이중생활</p>
        </div>
      </div>
      Slide Three - Set the background image for this slide in the line below
      <div class="carousel-item" style="background-image: url(${ctx}/resources/images/존윅.PNG)">
        <div class="carousel-caption d-none d-md-block">
          <h3 class="display-4">존윅</h3>
          <p class="lead">애견인의 복수</p>
        </div>
      </div>
    </div> 
    <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
          <span class="carousel-control-prev-icon" aria-hidden="true"></span>
          <span class="sr-only">Previous</span>
        </a>
    <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
          <span class="carousel-control-next-icon" aria-hidden="true"></span>
          <span class="sr-only">Next</span>
        </a>
  </div>
</header>
<div class="row" style="margin-left: 45px;">
    <h3 class="row_title" style="margin-left: 5%; margin-bottom: 0; color: #ffffff;">평점순</h3>
    <div class="row_posters" onscroll="getScrollVal()" style="margin-left: 20px;">
      <c:forEach items="${movieList}" var="list" begin="1" end="30" step="1">
      <div class="wrap">
        <img src="${list.image}" alt="movieImage" class="row_poster" style="margin-left: 20px;" name="movieImg1" onclick="test('${list.title}')">
        <div class="poster_info">
        </div>
      </div>
      </c:forEach>
      <div class="space"></div>
      <div class="left_arrow scroll_button" onclick="scrollL()">
        <i class="arrow left"></i>
      </div>
      <div class="right_arrow scroll_button" onclick="scrollR()">
        <i class="arrow right"></i>
      </div>
    </div>
</div>

<%-- <div class="row1">
    <h3 class="row_title1" style=" color: #ffffff;">평점순</h3>
    <div class="row_posters1" onscroll="getScrollVal1()" >
      <c:forEach items="${movieList}" var="list" begin="31" end="50" step="1">
      <div class="wrap1">
        <img src="${list.image}" alt="movieImage" class="row_poster1" style="margin-left: 20px;" name="movieImg2">
        <div class="poster_info1">
        </div>
      </div>
      </c:forEach>
      <div class="space1"></div>
      <div class="left_arrow1 scroll_button1" onclick="scrollL1()">
        <i class="arrow1 left1"></i>
      </div>
      <div class="right_arrow1 scroll_button1" onclick="scrollR1()">
        <i class="arrow1 right1"></i>
      </div>
    </div>
</div> --%>


<!-- <div class="modal fade bs-example-modal-lg5" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content"> -->
      <div id="player" style="margin-left: 15%;"></div>
    <!-- </div>
  </div>
</div> -->
</body>
</html>