<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath == '/' ? '' : pageContext.request.contextPath }" scope="application"></c:set>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
	@media (max-width:991px) {
		li a {
			text-align: center;
		}
	}
</style>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="${ctx}/resources/css/styles.css" rel="stylesheet" />
<script src="${ctx}/resources/js/scripts.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://use.fontawesome.com/releases/v5.15.3/js/all.js" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js"></script>
</head>
<script type="text/javascript">
	$(document).ready(function () {
		$("#navbarDropdownPortfolio").on("click", function () {
			$(".dropdown-menu dropdown-menu-right").slideToggle();
		});
	});
</script>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
  <div class="container">
      <a class="navbar-brand" href="${ctx}/">MOVIE</a>
      <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
      <div class="collapse navbar-collapse" id="navbarResponsive">
          <ul class="navbar-nav ml-auto">
          	<c:choose>
				<c:when test="${empty memList}">
  					<li class="nav-item"><a class="nav-link" href="${ctx}/member/login">LOGIN</a></li>
           			<li class="nav-item"><a class="nav-link" href="${ctx}/member/contract">JOIN</a></li>
				</c:when>
				<c:otherwise>
           			<li class="nav-item"><a class="nav-link" href="${ctx}/member/mypage">${memList.name}님</a></li>
           			<li class="nav-item"><a class="nav-link" href="${ctx}/logout">LOGOUT</a></li>
           			<li class="nav-item"><a class="nav-link" href="${ctx}/member/mypage">MY PAGE</a></li>
				</c:otherwise>
			</c:choose>
	           	<li class="nav-item"><a href="${ctx}/board/list" class="nav-link" >BOARD</a></li>
            </ul>
        </div>
    </div>
</nav>
</body>
</html>