<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath == '/' ? '' : pageContext.request.contextPath }" scope="application"></c:set>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자유게시판</title>
<style type="text/css">
	#wrapper {
		padding-left: 5%;
		padding-right: 5%;
		padding-top: 5%;
	}
</style>
</head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
/* $(document).ready(function() {
	var result = "${result}";
	history.replaceState({}, null, null);
	
	function checkModal(result) {
		if (result === "" || history.state) {
			return;
		}

		if (parseInt(result) > 0) {
			$(".modal-body").html("게시글 " + parseInt(result) + " 번이 등록되었습니다.");
		}

		$("#myModal").modal("show");
    }
	
	$("#regBtn").on("click", function() {
		self.location = "${contextPath}/board/register";
	});
	
	
}); */
$(document).ready(function () {
var searchKey = $("input[name='keyword']");

function emptyCheck(keyword) {
	if(keyword != "") {
		$.ajax({
			type : "GET",
			url : "${ctx}/movie/boardSearchtest",
			data : "keyword="+keyword,
			contentType : "application/json; charset=UTF-8",
			success : function (result) {
				var list = result.searchList;
				var test1 = $(".test1");
				var test = $(".test");
				var appendtext = "";
				$.each(list, function (idx, val) {
					if(val != null) {
						appendtext += "<tr> <td>" + val.userRating + "</td> <td> <img src= '" + val.image + "'> </td> <td><a target='_blank' href='"+ val.link +"'> " + val.title + " / " + val.subtitle + "</a></td>";
						appendtext += "<td>"+ val.actor +"</td> <td> "+ val.director +"</td> </tr>";
						test.empty();
						test.append(appendtext);
					}
				});
				/* infoSend(list); */
			}
		});
	} else {
		return false;
	}
} // emptyCheck end

	searchKey.keyup(function () {
		var keyword = document.getElementById("searchKey").value;
		emptyCheck(keyword);
	});
});
</script>
<%@ include file="../header.jsp" %>
<body>
<div id="wrapper">
<h1>test page</h1>
        <div id="page-wrapper">
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">자유게시판</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <select class="form-control" name="selectBoard" id="selectBoard" onchange="window.location.href=this.value" style="margin-bottom: 5px; border: 1px solid #000000;">
			  <!-- <option>선택</option> -->
			  <option value="${ctx}/board/list">선택</option>
			  <option value="${ctx}/board/list" id="board">공지사항</option>
			  <option value="${ctx}/board/freeBoard" id="free">자유게시판</option>
			  <option value="${ctx}/board/movieBoard" id="movie">영화정보</option>
			  <option value="${ctx}/board/movieBoardtest" id="movie">영화정보_testVER</option>
			</select>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="table-responsive">
                            <table class="table table-striped table-bordered table-hover" id="dataTables-example">
                                <thead>
                                    <tr>
                                        <th width="5%">평점</th>
                                        <th width="15%">이미지</th>
                                        <th width="50%">제목 / 영어제목</th>
                                        <th width="15%">출연배우</th>
                                        <th width="15%">감독</th>
                                    </tr>
                                </thead>
                                <tbody class="test">
                               		<tr height="10">
										<th colspan="5">
											<p align="center">
												<b><span style="font-size: 20px;">검색어를 입력해주세요.</span></b>
											</p>
										</th>
									</tr>
                                </tbody>
                            </table>
                            <div style="margin: 0 auto; text-align: center;">
								<input type="text" name="keyword" id="searchKey" style="width: 10cm;" placeholder="검색어를 입력해주세요">
							</div>
                            <%-- <div class="panel-heading">
			            		<button id="regBtn" type="button" class="btn btn-default pull-right" style="border: 1px solid #000000;">글등록</button>
			            	</div>
                            <div class='center' >
								<ul class="pagination justify-content-center" >
									<c:if test="${pageMaker.prev}">
										<li class="page-item previous"><a class="page-link" href="${pageMaker.startPage -1}">Previous</a></li>
									</c:if>
									<c:forEach var="num" begin="${pageMaker.startPage}"	end="${pageMaker.endPage}">
										<li class="page-item  ${pageMaker.cri.pageNum == num ? "active":""} ">
											<a href="${num}" class="page-link">${num}</a>
										</li>
									</c:forEach>
									<c:if test="${pageMaker.next}">
										<li class="page-item next"><a class="page-link" href="${pageMaker.endPage +1 } ">Next</a></li>
									</c:if>
								</ul>
							</div>
							<div class="row" style="margin: 0 auto; text-align: center;">
								<div class="col-lg-12">
									<form id="searchForm" action="${ctx}/board/freeBoard" method="get">
										<select name="type" >
											<option value="" <c:out value="${pageMaker.cri.type == null?'selected':''}"/>>선택</option>
											<option value="T" <c:out value="${pageMaker.cri.type eq 'T'?'selected':''}"/>>제목</option>
											<option value="C" <c:out value="${pageMaker.cri.type eq 'C'?'selected':''}"/>>내용</option>
											<option value="W" <c:out value="${pageMaker.cri.type eq 'W'?'selected':''}"/>>작성자</option>
											<option value="TC" <c:out value="${pageMaker.cri.type eq 'TC'?'selected':''}"/>>제목 + 내용</option>
											<option value="TW" <c:out value="${pageMaker.cri.type eq 'TW'?'selected':''}"/>>제목 + 작성자</option>
										</select>
										<input type="text" style="width: 8cm;" name="keyword" placeholder="검색어를 입력하세요" value="${pageMaker.cri.keyword}">
										<button class="btn btn-default">검색</button>
									</form>
								</div>
							</div>
                            <form id='actionForm' action="${ctx}/board/freeBoard" method='get'>
								<input type='hidden' name='id' value='${sessionScope.memList.id}' id="id">
								<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum}'>
								<input type='hidden' name='amount' value='${pageMaker.cri.amount}'>
								<input type='hidden' name='type' value='${pageMaker.cri.type}'>
								<input type='hidden' name='keyword' value='${pageMaker.cri.keyword}'>
							</form> --%>
                            <!-- /.table-responsive -->
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
        </div>
        <!-- /#page-wrapper -->
    </div>
</body>
</html>