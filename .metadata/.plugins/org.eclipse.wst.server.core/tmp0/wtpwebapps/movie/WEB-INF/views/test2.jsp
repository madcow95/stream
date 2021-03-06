<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath == '/' ? '' : pageContext.request.contextPath }" scope="application"></c:set>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="_csrf" content="${_csrf.token}">
<meta name="_csrf_header" content="${_csrf.headerName}">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function () {
		var shoulder = $("input[name='shoulder']");
		var back = $("input[name='back']");
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		$("button[name='sBtn']").on("click", function () {
			$.ajax({
				url : "${ctx}/shop",
				data : "data="+shoulder.val() + "어깨운동",
				beforeSend : function(xhr){
					xhr.setRequestHeader(header, token);
				},
				type : "post",
				success : function (result) {
					console.log("어깨운동 상품들" + result);
					document.getElementById("info1").value = result.title;
					document.getElementById("info2").src= result.image;
					document.getElementById("info3").value = result.lprice;
				}
			});
		});
		$("button[name='bBtn']").on("click", function () {
			$.ajax({
				url : "${ctx}/shop",
				data : "data="+back.val() + "등운동",
				beforeSend : function(xhr){
					xhr.setRequestHeader(header, token);
				},
				type : "post",
				success : function (result) {
					console.log("등운동 상품들" + result);
					document.getElementById("info1").value = result.title;
					document.getElementById("info2").src= result.image;
					document.getElementById("info3").value = result.lprice;
				}
			});
		});
	});
</script>
</head>
<body>
<%@ include file="header.jsp" %>
<button name="sBtn">어깨</button>
<button name="bBtn">등</button>
<input type="text" id="info1">
<img id="info2" width="100" height="100">
<input type="text" id="info3">
</body>
</html>