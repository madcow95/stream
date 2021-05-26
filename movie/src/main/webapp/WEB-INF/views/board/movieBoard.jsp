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
	$(document).ready(function () {
		$("#click").on("click", function () {
			var keyword = document.frm.keyword.value;
			log.console(keyword);
			$.ajax({
				type : "get",
				url : "${ctx}/board/boardSearch",
				data : "keyword="+keyword,
				dataType : "json",
				success : function (items) {
					if(items != null) {
						document.frm.test.value = "asdf";
					}
				}
			});
		});
	});
</script>
<body>
<%@ include file="../header.jsp" %>
<form method="get" name="frm">
	검색 : <input type="text" name="keyword" id="keyword" >
	<input type="submit" value="검색" id="click">
	<input type="text" id="test" name="test">
</form>
</body>
</html>