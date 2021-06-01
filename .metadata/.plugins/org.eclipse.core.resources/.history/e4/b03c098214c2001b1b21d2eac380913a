<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctx" value="${pageContext.request.contextPath == '/' ? '' : pageContext.request.contextPath }" scope="application"></c:set>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="${ctx}/resources/js/movieBoard.js"></script>
<script type="text/javascript">
	/* $(document).ready(function () {
		var searchBtn = $("input[name='search']");
		
		function emptyCheck(keyword) {
			if(keyword != "") {
				$.ajax({
					url : "${ctx}/movie/boardSearch",
					data : "keyword="+keyword,
					type : "GET",
					contentType : "application/json; charset=UTF-8",
					success : function (result) {
						for(var i = 0; i < result.length; i++) {
							$(".test").html("<c:forEach items='${"+ result +"}' var='"+list+"'> <ul> <li>${'"+result[i].title+"'}</li> <li>${'"+result[i].subtitle+"'}</li> </ul> </c:forEach>");
							var title = result[i].title;
							var subtitle = result[i].subtitle;
							var actor = result[i].actor;
							var link = result[i].link;
							var userRating = result[i].userRating;
							console.log(title);
						}
						
					}
				});
			} else {
				alert("검색값을 입력해주세요");
				return false;
			}
		}
		
		searchBtn.on("click", function () {
			var keyword = document.getElementById("keyword").value;
			emptyCheck(keyword);
		});
	}); */
</script>
<body>
<%@ include file="../header.jsp" %>
<form action="${ctx}/movie/boardSearch" method="get">
	<input type="text" name="keyword">
	<input type="submit" value="검색" name="search">
</form>
<c:choose>
	<c:when test="${!empty movieList}">
		<c:forEach items="${movieList}" var="list">
			<ul>
				<li>${list.title}</li>
				<li>${list.subtitle}</li>
				<li>${list.userRating}</li>
				<li><img src="${list.image}"></li>
			</ul>
		</c:forEach>
	</c:when>
</c:choose>
<div class="test">
	
</div>
<div>
	
</div>
</body>
</html>