<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath == '/' ? '' : pageContext.request.contextPath }" scope="application"></c:set>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
	.carousel-item {
	  height: 50vh;
	  min-height: 350px;
	  background: no-repeat center center scroll;
	  -webkit-background-size: cover;
	  -moz-background-size: cover;
	  -o-background-size: cover;
	  background-size: cover;
	}
</style>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
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
      <div class="carousel-item active" style="background-image: url(${ctx}/resources/images/익스트랙션가로.jpg)">
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
      <div class="carousel-item" style="background-image: url(${ctx}/resources/images/존윅가로.jpg)">
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
<div class="container" style="margin-top: 10px; display: inline;">
	<div class="row text-center text-lg-left" >
		<c:forEach items="${movieList}" var="movie">
	    	<div class="col-lg-3 col-md-4 col-6">
	     		<a href="#" class="d-block mb-4 h-100">
	            	<img class="img-fluid img-thumbnail" src="${ctx}/resources/images/${movie.m_img}" width="411.5" height="572.34">
	            </a>
    		</div>
		</c:forEach>
	</div>
</div>
</body>
</html>