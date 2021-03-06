<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath == '/' ? '' : pageContext.request.contextPath }" scope="application"></c:set>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript">
	function delBtn(id) {
		if(confirm("회원탈퇴?")) {
			location.href="${ctx}/admin/delMember?id="+id;
		} else {
			alert("탈퇴 취소");
		}
	}
</script>
<body>
<%@ include file="../header.jsp" %>
<div class="row" style="margin-left: 15%; margin-right: 15%; margin-top: 5%;">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="table-responsive">
				<table class="table table-striped table-bordered table-hover" id="dataTables-example">
					<thead>
						<tr>
                           <th>아이디</th>
                           <th>이름</th>
                           <th>이메일</th>
                           <th>가입일</th>
                           <th>최근접속일</th>
                           <th>관리</th>
                       </tr>
					</thead>
					<tbody>
						<c:forEach items="${memList}" var="member">
							<tr class="odd gradeX">
								<td>${member.id}</td>
								<td>${member.name }</td>
								<td>${member.email }</td>
								<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${member.regdate }"/></td>
								<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${member.lastlogin }"/></td>
								<td><button class="btn btn-danger btn-sm" onclick="delBtn('${member.id}')">삭제</button></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</div>
	<%-- <c:forEach items="${memList}" var="list">
		<table>
			<thead></thead>
		</table>
	</c:forEach> --%>
</body>
</html>