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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://www.youtube.com/iframe_api"></script>
<script type="text/javascript">
	$(document).ready(function () {
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		$.ajax({
			url : "${ctx}/ySearch",
			data : "keyword=어깨운동",
			type : "POST",
			beforeSend : function(xhr){
				xhr.setRequestHeader(header, token);
			},
			success : function (result) {
				var test = $(".test");
				var appendtext = "";
				$.each(result, function (idx, val) {
					test.empty();
					if(val != null) {
						appendtext += "<tr> <td>" + val.title + "</td> <td> <img src= '" + val.image + "'> </td> <td> <div id='player'></div></td>"
						test.append(appendtext);
					}
				});
			}
		});
	});
</script>
<title>Insert title here</title>
</head>
<body>
<%@ include file="header.jsp" %>
<table class="table table-striped table-bordered table-hover" id="dataTables-example">
	<thead>
        <tr>
            <th width="50%">평점</th>
            <th width="15%">이미지</th>
            <th width="35%">제목 / 영어제목</th>
        </tr>
    </thead>
    <tbody class="test">
    	<tr height="10">
			<th colspan="5">
				<p align="center">
					<b><span style="font-size: 20px;">검색어를 입력해주세요.</span></b>
					<video src="https://www.youtube.com/watch?v=cNDrl3vOZNs"></video>
				</p>
			</th>
		</tr>
    </tbody>
</table>
</body>
</html>