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
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script type="text/javascript">
	Kakao.init("ef662570a1f847f41f5b1b2e24a22e6a");
	console.log(Kakao.isInitialized());
	function kakaologin() {
		Kakao.Auth.login({
			success : function (response) {
				Kakao.API.request({
					url : "/v2/user/me",
					success : function (response) {
						console.log(response);
						console.log(response.kakao_account);
						/* var kakaoInfo = new Object();
						kakaoInfo.name = response.kakao_account.profile.nickname;
						kakaoInfo.gender = response.kakao_account.gender;
						kakaoInfo.email = response.kakao_account.email;
						kakaoInfo.image = response.kakao_account.profile.profile_image_url; */
						document.getElementById("kakaoName").value = response.kakao_account.profile.nickname;
						document.getElementById("kakaoGender").value = response.kakao_account.gender;
						document.getElementById("kakaoEmail").value = response.kakao_account.email;
						document.getElementById("kakaoImage").value = response.kakao_account.profile.profile_image_url;
						document.getElementById("loginCategory").value = "k";
						/* document.kakaojoin.submit(); */
						1777238440
						1777238440
					},
					fail : function (error) {
						console.log(error);
					},
				});
			},
			fail : function (error) {
				console.log(error);
			},
		});
	}
	
	function kakaologout() {
		if (Kakao.Auth.getAccessToken()){
			Kakao.API.request({
				url : "/v1/user/unlink",
				success : function (response) {
					console.log(response)
				},
				fail : function (error) {
					console.log(error);
				}
			});
			Kakao.Auth.setAccessToken(undefined);
		}
	}
	function Naverlogin() {
		document.getElementById("loginCategory").value = "n";
	}
	function test() {
		alert(document.kakaojoin.kakaoName.value);
	}
</script>
<title>Insert title here</title>
</head>
<body>
<%@ include file="header.jsp" %>

<button name="kakaologin" onclick="test()">test</button>
<button name="kakaologin" onclick="kakaologin()"><img src="${ctx}/resources/images/kakaologin.png"></button>
<button name="kakaologin" onclick="Naverlogin()">??????????????????</button>
<button name="kakaologout" onclick="kakaologout()">????????? ????????????</button>
<form action="${ctx}/kakaojoin" name="kakaojoin" method="post">
	<input type="text" id="kakaoName" name="kakaoName">
	<input type="text" id="kakaoEmail" name="kakaoEmail">
	<input type="text" id="kakaoGender" name="kakaoGender">
	<input type="text" id="kakaoImage" name="kakaoImage">
	<input type="text" id="loginCategory" name="loginCategory">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" id="token">
</form>
</body>
</html>