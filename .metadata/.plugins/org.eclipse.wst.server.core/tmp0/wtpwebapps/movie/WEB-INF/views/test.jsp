<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath == '/' ? '' : pageContext.request.contextPath }" scope="application"></c:set>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<style type="text/css">
	
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
if(navigator.mediaDevices && navigator.mediaDevices.getUserMedia) {
	navigator.mediaDevices.getUserMedia({ video: true }).then(function(stream) {
		var video = document.getElementById('video');
		video.srcObject = stream;
		video.play();
	});
}

var canvas = document.getElementById('canvas');
var video = document.getElementById('video');
</script>
<title>Test Page</title>
</head>
<body>
<%@ include file="header.jsp" %>
	<video id="video" width="320" height="240" autoplay></video>
	<canvas id="canvas" width="960" height="720"></canvas>
</body>
</html>