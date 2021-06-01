<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>Login Page</h1>
	<h2><c:out value="${error }"></c:out></h2>
	<h2><c:out value="${logout}"></c:out></h2>
	
	<form method="post" action="/login">
		
		<div>
			<input type="text" name="username">
		</div>
		<div>
			<input type="password" name="password">
		</div>
		<div>
			<input type="submit">
		</div>
		<input type="hidden" value="${_csrf.token}" name="${_csrf.parameterName }">
	</form>
</body>
</html>