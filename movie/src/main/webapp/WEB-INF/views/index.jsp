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
	
	header {
		background-color: #000000;
	}
</style>
<meta charset="UTF-8">
<link rel="stylesheet" href="${ctx}/resources/css/carousel.css">
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
	<h3>액션</h3>
	<div class="wrapper">
  <section id="section1">
  <c:forEach items="${movieList}" var="list">
  	<c:choose>
  		<c:when test="${list.m_code > 0 && list.m_code <= 5 }">
  			<div class="item">
    			<img src="${ctx}/resources/images/${list.m_img}" alt="Describe Image" width="341px" height="192px">
		  	</div>
  		</c:when>
  	</c:choose>
  </c:forEach>
    <a href="#section3" class="arrow__btn">‹</a>
    <a href="#section2" class="arrow__btn">›</a>
  </section>
  <section id="section2">
  <c:forEach items="${movieList}" var="list">
  	<c:choose>
  		<c:when test="${list.m_code > 5 && list.m_code <= 10 }">
  			<div class="item">
    			<img src="${ctx}/resources/images/${list.m_img}" alt="Describe Image" width="341px" height="192px">
		  	</div>
  		</c:when>
  	</c:choose>
  </c:forEach>
    <a href="#section1" class="arrow__btn">‹</a>
    <a href="#section3" class="arrow__btn">›</a>
  </section>
  <section id="section3">
    <a href="#section2" class="arrow__btn">‹</a>
    <c:forEach items="${movieList}" var="list">
  	<c:choose>
  		<c:when test="${list.m_code > 10 && list.m_code <= 15 }">
  			<div class="item">
    			<img src="${ctx}/resources/images/${list.m_img}" alt="Describe Image" width="341px" height="192px">
		  	</div>
  		</c:when>
  	</c:choose>
  </c:forEach>
    <a href="#section1" class="arrow__btn">›</a>
  </section>
</div>
</div>
<br>
<hr>
<br>
<div class="container" style="margin-top: 10px; display: inline;">
	<h3>판타지</h3>
	<div class="wrapper">
  <section id="section4">
  <c:forEach items="${movieList}" var="list">
  	<c:choose>
  		<c:when test="${list.m_code > 0 && list.m_code <= 5 }">
  			<div class="item">
    			<img src="${ctx}/resources/images/${list.m_img}" alt="Describe Image" width="341px" height="192px">
		  	</div>
  		</c:when>
  	</c:choose>
  </c:forEach>
    <a href="#section6" class="arrow__btn">‹</a>
    <a href="#section5" class="arrow__btn">›</a>
  </section>
  <section id="section5">
  <c:forEach items="${movieList}" var="list">
  	<c:choose>
  		<c:when test="${list.m_code > 5 && list.m_code <= 10 }">
  			<div class="item">
    			<img src="${ctx}/resources/images/${list.m_img}" alt="Describe Image" width="341px" height="192px">
		  	</div>
  		</c:when>
  	</c:choose>
  </c:forEach>
    <a href="#section4" class="arrow__btn">‹</a>
    <a href="#section6" class="arrow__btn">›</a>
  </section>
  <section id="section6">
    <a href="#section5" class="arrow__btn">‹</a>
    <c:forEach items="${movieList}" var="list">
  	<c:choose>
  		<c:when test="${list.m_code > 10 && list.m_code <= 15 }">
  			<div class="item">
    			<img src="${ctx}/resources/images/${list.m_img}" alt="Describe Image" width="341px" height="192px">
		  	</div>
  		</c:when>
  	</c:choose>
  </c:forEach>
    <a href="#section4" class="arrow__btn">›</a>
  </section>
</div>
</div>
</body>
</html>