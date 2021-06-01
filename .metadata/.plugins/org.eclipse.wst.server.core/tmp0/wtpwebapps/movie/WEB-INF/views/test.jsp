<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath == '/' ? '' : pageContext.request.contextPath }" scope="application"></c:set>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 <meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="${ctx}/resources/css/test.css">
<script type="text/javascript" src="${ctx}/resources/js/test.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<title>Insert title here</title>
</head>
<body style="background-color: #000000;">
<%@ include file="header.jsp" %>
<div class="row">
    <h3 class="row_title">Trending Now</h3>
    <div class="row_posters" onscroll="getScrollVal()" style="margin-left: 20px; margin-top: 15px;">
      <c:forEach items="${movieList}" var="list" begin="1" end="30" step="1">
      <div class="wrap">
        <img src="${list.image}" alt="movieImage" class="row_poster" style="margin-left: 20px;">
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
</body>
</html>