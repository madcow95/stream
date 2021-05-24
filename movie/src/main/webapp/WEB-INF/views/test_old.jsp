<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath == '/' ? '' : pageContext.request.contextPath }" scope="application"></c:set>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" href="${ctx}/resources/stage/css/styles.css">
<title>Insert title herea</title>
</head>
<body>
<h1>NETFLIX</h1>
<div class="wrapper">
  <section id="section1">
    <a href="#section3">‹</a>
      <div class="item">
        <img src="${ctx}/resources/images/1917.jpg" alt="Describe Image">
      </div>
      <div class="item">
        <img src="${ctx}/resources/images/1917.jpg" alt="Describe Image">
      </div>
      <div class="item">
        <img src="${ctx}/resources/images/1917.jpg" alt="Describe Image">
      </div>
      <div class="item">
        <img src="${ctx}/resources/images/1917.jpg" alt="Describe Image">
      </div>
      <div class="item">
        <img src="${ctx}/resources/images/1917.jpg" alt="Describe Image">
      </div>
    <a href="#section3">›</a>
  </section>
  <section id="section2">
    <a href="#section1">‹</a>
      <div class="item">
        <img src="${ctx}/resources/images/1917.jpg" alt="Describe Image">
      </div>
      <div class="item">
        <img src="${ctx}/resources/images/1917.jpg" alt="Describe Image">
      </div>
      <div class="item">
        <img src="${ctx}/resources/images/1917.jpg" alt="Describe Image">
      </div>
      <div class="item">
        <img src="${ctx}/resources/images/1917.jpg" alt="Describe Image">
      </div>
      <div class="item">
        <img src="${ctx}/resources/images/1917.jpg" alt="Describe Image">
      </div>
    <a href="#section3">›</a>
  </section>

  <section id="section3">
    <a href="#section2">‹</a>
      <div class="item">
        <img src="${ctx}/resources/images/1917.jpg" alt="Describe Image">
      </div>
      <div class="item">
        <img src="${ctx}/resources/images/1917.jpg" alt="Describe Image">
      </div>
      <div class="item">
        <img src="${ctx}/resources/images/1917.jpg" alt="Describe Image">
      </div>
      <div class="item">
        <img src="${ctx}/resources/images/1917.jpg" alt="Describe Image">
      </div>
      <div class="item">
        <img src="${ctx}/resources/images/1917.jpg" alt="Describe Image">
      </div>
    <a href="#section1">›</a>
  </section>
</div>
</body>
</html>