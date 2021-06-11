<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath == '/' ? '' : pageContext.request.contextPath }" scope="application"></c:set>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${ctx}/resources/css/contract.css">
<title>Insert title here</title>
</head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function () {
	$(".chkAll1").click(function() {
		$(".chkA1").prop("checked", this.checked);
	});
	
	$("#toJoin1").on("click", function () {
		if(document.getElementById("chk3").checked == true && document.getElementById("chk4").checked == true){
			document.getElementById("joinForm").action = "${ctx}/member/join";
			document.getElementById("joinForm").submit();
		} else {
			alert("약관에 동의해주세요");
		}
	});
	
	$("#toHome").on("click", function () {
		document.getElementById("joinForm").action = "/";
		document.getElementById("joinForm").submit();
	});
});
</script>
<body>
<%@ include file="../header.jsp" %>
<form action="" id="joinForm" name="frm" method="get" style="margin-bottom: 5%;">
		<ul class="join_box" style="margin-top: 20%;">
			<li class="checkBox check01">
				<ul class="clearfix">
					<li>이용약관, 개인정보 수집 및 이용, 위치정보 이용약관(선택), 프로모션 안내 메일 수신(선택)에 모두
						동의합니다.</li>
					<li class="checkAllBtn"><input type="checkbox" name="chkAll1"
						id="chk" class="chkAll1"></li>
				</ul>
			</li>
			<li class="checkBox check02">
				<ul class="clearfix">
					<li>이용약관 동의(필수)</li>
					<li class="checkBtn"><input type="checkbox" name="chk" id="chk3"
						class="chkA1"></li>
				</ul> <textarea name="" id="" readonly="readonly">여러분을 환영합니다.
OOO 서비스 및 제품(이하 ‘서비스’)을 이용해 주셔서 감사합니다. 본 약관은 다양한 OOO 서비스의 이용과 관련하여 OOO 서비스를 제공하는 OOO 주식회사(이하 ‘OOO’)와 이를 이용하는 OOO 서비스 회원(이하 ‘회원’) 또는 비회원과의 관계를 설명하며, 아울러 여러분의 OOO 서비스 이용에 도움이 될 수 있는 유익한 정보를 포함하고 있습니다.
       </textarea>
			</li>
			<li class="checkBox check03">
				<ul class="clearfix">
					<li>개인정보 수집 및 이용에 대한 안내(필수)</li>
					<li class="checkBtn"><input type="checkbox" name="chk" id="chk4"
						class="chkA1"></li>
				</ul> <textarea name="" id="" readonly="readonly">여러분을 환영합니다.
OOO 서비스 및 제품(이하 ‘서비스’)을 이용해 주셔서 감사합니다. 본 약관은 다양한 OOO 서비스의 이용과 관련하여 OOO 서비스를 제공하는 OOO 주식회사(이하 ‘OOO’)와 이를 이용하는 OOO 서비스 회원(이하 ‘회원’) 또는 비회원과의 관계를 설명하며, 아울러 여러분의 OOO 서비스 이용에 도움이 될 수 있는 유익한 정보를 포함하고 있습니다.
       </textarea>
			</li>
		</ul>
		<p style="margin: 0 auto; text-align: center;">
 		 <button type="button" class="btn btn-default btn-lg" id="toHome1" style="border: 1px solid #000000;">비동의</button>
		 <button type="button" class="btn btn-primary btn-lg" id="toJoin1" >동의</button>
		</p>
	</form>
</body>
</html>