<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath == '/' ? '' : pageContext.request.contextPath }" scope="application"></c:set>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	.row {
		padding-left: 5%;
		padding-right: 5%;
		padding-top: 5%;
	}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function () {
		var operForm = $("#operForm")
		$("button").on("click", function (e) {
			e.preventDefault();
			
			var operation = $(this).data("oper");
			
			if(operation === "list"){
				document.getElementById("frm").action="${ctx}/board/list";
			} else if (operation === "remove") {
				document.getElementById("frm").action="${ctx}/board/remove";
				document.getElementById("frm").submit();
			}
			document.getElementById("frm").submit();
		});
	});
</script>
</head>
<body>
<%@ include file="../header.jsp" %>
<div class="row">
  <div class="col-lg-12">
    <div class="panel panel-default">

      <!-- /.panel-heading -->
      <div class="panel-body">

        <form role="form" action="${ctx}/board/modify" method="post" id="frm">
          <div class="form-group">
            <label>Articleno</label> <input class="form-control" name='articleno' value="${boardList.articleno }" disabled="disabled">
          </div>
          <div class="form-group">
            <label>Subject</label> <input class="form-control" name='subject' value="${boardList.subject }" >
          </div>

          <div class="form-group">
            <label>Content</label>
            <textarea class="form-control" rows="3" name='content' >${boardList.content }</textarea>
          </div>

          <div class="form-group">
            <label>ID</label> <input class="form-control" name='id' value="${boardList.id }" disabled="disabled">
          </div>
          <div class="form-group">
            <label>RegDate</label> <input class="form-control" name='reg_date' value="${boardList.reg_date }" disabled="disabled">
          </div>
          <div class="form-group" style="margin: 0 auto; text-align: center;">
	          <button class="btn btn-primary" data-oper="modify">Modify</button>
	          <button data-oper="remove" class="btn btn-danger">Remove</button>
	          <button data-oper="list" class="btn btn-default">List</button>
          </div>
          	<input type="hidden" id="articleno" name="articleno" value="${boardList.articleno}">
          	<input type="hidden" id="readcount" name="readcount" value="${boardList.readcount}">
          	<input type="hidden" id="filename" name="filename" value="${boardList.filename}">
          	<input type="hidden" id="id" name="id" value="${boardList.id}">
          	<input type="hidden" id="pageNum" name="pageNum" value="${cri.pageNum}">
          	<input type="hidden" id="type" name="type" value="${cri.type}">
          	<input type="hidden" id="keyword" name="keyword" value="${cri.keyword}">
        </form>

      </div>
      <!--  end panel-body -->

    </div>
    <!--  end panel-body -->
  </div>
  <!-- end panel -->
</div>
</body>
</html>