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
	  height: 50vh;
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

		var player;
		function test(title, rating) {
			var key = "AIzaSyD6Gzk_-YieLA_oo0v_m1WyyM63QWoBUbo";
			var keyword = title + " 예고편";
			$.ajax({
				type : "GET",
				url : "https://www.googleapis.com/youtube/v3/search?key="+key,
				data : {
					part : 'snippet',
					order : 'viewCount',
					q : keyword,
					maxResults:1,
				},
				success : function (result) {
					onYouTubeIframeAPIReady(result.items[0].id.videoId);
					change(title, rating);
				}
			}); // ajax end
			
			function change(title, rating) {
				document.getElementById("header").value = title + "예고편";
				document.getElementById("footer").value = rating;
			}
			
			function onYouTubeIframeAPIReady(url) {
				player = new YT.Player('player', {
					videoId : url,
					width : "600",
					height : "450",
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
		
		function memManage() {
			location.href="${ctx}/admin/memberManager"
		}
		function boardManage() {
			location.href="${ctx}/admin/boardManager"
		}
		
	$(document).ready(function () {
		
		$("img[name='movieImg1']").on("click", function () {
			
			$("button[name='test']").click();
			this.clean();
			this.click();
		});
		
		$("button[name='realExit']").on("click", function () {
			$("form[name='realExitForm']").submit();
		});
		
	});
	
</script>
<title>Insert title here</title>
</head>
<body style="background-color: #000000;">
<%@ include file="header.jsp" %>
<header>
<sec:authorize access="hasRole('ROLE_MEMBER')">
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
</sec:authorize>
</header>
<sec:authorize access="hasRole('ROLE_MEMBER')">
	<div class="row" style="margin-left: 45px;">
	    <h3 class="row_title" style="margin-left: 5%; margin-bottom: 0; color: #ffffff;">평점순</h3>
	    <div class="row_posters" onscroll="getScrollVal()" style="margin-left: 20px;">
	      <c:forEach items="${movieList}" var="list" begin="1" end="30" step="1">
	      <div class="wrap">
	        <img src="${list.image}" alt="movieImage" class="row_poster" style="margin-left: 20px;" name="movieImg1" onclick="test('${list.title}', '${list.userRating}')">
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
</sec:authorize>
<sec:authorize access="isAnonymous()">
	<div style="margin-top:  25%;">
		<h1>로그인을 하고 서비스를 이용해주세요</h1>
	</div>
</sec:authorize>
<sec:authorize access="hasRole('ROLE_EXIT')">
	<div style="margin-top:  15%;">
		<h1>다시 돌아오셨네요.</h1><br>
		<h1>아이디를 활성화하면 다시 서비스를 이용할수 있습니다.</h1>
		<button style="margin-left: 47%;" data-toggle="modal" data-target=".bs-example-modal-lg11">아이디 활성화</button>
	</div>
</sec:authorize>
<sec:authorize access="hasRole('ROLE_ADMIN')">
	<div style="margin-top: 25%;">
		<h1>관리자님 환영합니다.</h1>
		<button style="margin-left: 25%" onclick="memManage()">회원관리</button>
		<button onclick="boardManage()">게시글관리</button>
	</div>
</sec:authorize>

<button name="test" data-toggle="modal" data-target=".bs-example-modal-lg8" style="display: none;"></button>
<div class="modal fade bs-example-modal-lg8" id="playerModal" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg" >
    <div class="modal-content" style="background-color: #000000;">
    <div class="modal-header">
    	<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
    </div>
	<div id="player"></div>
		<div style="margin: 0 auto; text-align: center;">
			<b style="color: #ffffff; font-size: 11px">제목 : </b><input type="text" id="header"value="" style="text-align: center; font-size: 11px; width: 8cm; border: 0px #ffffff;" > <br>
			<b style="color: #ffffff; font-size: 11px">평점 : </b><input type="text" id="footer" value="" style="text-align: center; font-size:11px; border: 0px #ffffff;">
		</div>
    </div>
  </div>
</div>
<div class="modal fade bs-example-modal-lg11" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg" >
    <div class="modal-content">
		<div class="container">
			<div class="row">
				<div class="col-sm-9 col-md-7 col-lg-5 mx-auto">
					<div class="card card-signin my-5">
						<div class="card-body">
							<h5 class="card-title text-center">회원 활성화</h5>
							<form action="${ctx}/member/exitCancel" method="post" name="realExitForm">
								<div class="form-group">
									<input type="text" name="cancleId" class="form-control" placeholder="ID" value="${mDto.id}" readonly="readonly" style="font-size: 14px;">
								</div>
								<div class="form-group">
									<input type="password" name="canclePwd" class="form-control" placeholder="비밀번호를 입력해주세요" style="font-size: 14px;">
								</div>
								<button class="btn btn-lg btn-primary btn-block text-uppercase" type="button" name="realExit">아이디 활성화</button>
								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
    </div>
  </div>
</div>
</body>
</html>