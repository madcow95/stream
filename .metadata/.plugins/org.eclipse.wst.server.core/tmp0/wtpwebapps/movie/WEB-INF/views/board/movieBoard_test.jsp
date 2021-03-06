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
				test.empty();
					if(val != null) {
						appendtext += "<tr> <td>" + val.userRating + "</td> <td> <img src= '" + val.image + "'> </td> <td><a target='_blank' href='"+ val.link +"'> " + val.title + " / " + val.subtitle + "</a></td>";
						appendtext += "<td>"+ val.actor +"</td> <td> "+ val.director +"</td> </tr>";
						test.append(appendtext);
					}
				});
			}
		});
	} else {
		return false;
	}
} 
	searchKey.keyup(function () {
		var keyword = document.getElementById("searchKey").value;
		emptyCheck(keyword);
	});
});
</script>
<%@ include file="../header.jsp" %>
<body>
<div id="wrapper">
        <div id="page-wrapper">
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">실시간 검색</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <select class="form-control" name="selectBoard" id="selectBoard" onchange="window.location.href=this.value" style="margin-bottom: 5px; border: 1px solid #000000;">
			  <!-- <option>선택</option> -->
			  <option value="${ctx}/board/list">선택</option>
			  <option value="${ctx}/board/list" id="board">공지사항</option>
			  <option value="${ctx}/board/freeBoard" id="free">자유게시판</option>
			  <option value="${ctx}/board/movieBoard" id="movie">영화정보</option>
			  <option value="${ctx}/board/movieBoardtest" id="movie">실시간 영화검색</option>
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