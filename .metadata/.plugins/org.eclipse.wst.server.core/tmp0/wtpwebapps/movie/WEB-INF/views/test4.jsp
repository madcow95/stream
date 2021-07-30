<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath == '/' ? '' : pageContext.request.contextPath }" scope="application"></c:set>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function () {
		$("button[name='end']").on("click", function () {
			var set = $("input[name='set']").val();
			var count = $("input[name='count']").val();
			var test = $(".test");
			var appendtext = "";
			
			var form = $("form[name=recordForm]");
			
			var setField = document.createElement("input");
			setField.setAttribute("type", "text");
			setField.setAttribute("id", "set"+set);
			setField.setAttribute("value", set);
			
			var countField = document.createElement("input");
			countField.setAttribute("type", "text");
			countField.setAttribute("id", "count"+set);
			countField.setAttribute("value", count);
			
			document.recordForm.appendChild(setField);
			document.recordForm.appendChild(countField);
			
			if(set > 10) {
				$("input[name='set']").val(10);
				alert("세트는 10개가 최대입니다");
			} else {
				appendtext = "<tr><td>"+set+"</td><td>"+count+"</td></tr>";
				/* appendtext = "<tr><td><input type='text' id='setCount"+set+"' value='"+set+"'>"+set+"</td><td><input type='text' id='countCount"+set+"' value='"+count+"'>"+count+"</td></tr>"; */
				test.append(appendtext);
				$("input[name='set']").val(Number(set)+1);
				$("input[name='count']").val("");
				var testSet = document.getElementById("set"+set).value;
				var testCount = document.getElementById("count"+set).value;
				/* var healthList=new Array();
				healthList[set]={
					set:testSet,
					count:testCount
				}
				for(var i = 1; i < healthList.length; i++){
					console.log(healthList[i]);
				} */
				
			}
		}); // end btn click end
		
		$("button[name='healthList']").on("click", function () {
			/* var recordList = */ 
			$.ajax({
				url : "${ctx}/record",
				data : ,
				contentType : "application/json; charset=UTF-8",
			});
		});
	});
</script>
<body>
<%@ include file="header.jsp" %>
<input type="text" name="set" value="1"><br>
<input type="text" name="count"><br>
<button name="end">입력</button>
<table class="table table-striped table-bordered table-hover" id="dataTables-example">
	<thead>
        <tr>
            <td>세트</td>
            <td>개수</td>
        </tr>
    </thead>
    <tbody class="test">
    </tbody>
</table>
<form action="${ctx}/record" name="recordForm" method="post">
	
</form>
<button name="healthList">기록</button>
</body>
</html>