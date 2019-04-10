<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css"
	type="text/css">
<script src="./resources/js/jquery-3.3.1.min.js"></script>
<script src="./resources/js/jquery-ui.js"></script>
<script type="text/javascript">
	$(function() {
			$("#delete").click(function() {
				$("#checkdelete").attr("action", "delete").attr("method", "post").submit();
			})
			
			//전체 체크
			$("#checkboxleader").click(function() {
				if ($("#checkboxleader").is(':checked')) {
					for (i = 0; i < checkbox.length; i++) {
						checkbox[i].checked = true;
					}
				} else {
					for (i = 0; i < checkbox.length; i++) {
						checkbox[i].checked = false;
					}
				}
			})
			
			//검색
			$("#searchBtn").click(function() {
				$.ajax({
					type : "get",
					url : "/spring/searchAjax",
					//data: { "option" : $("#option").val(),"search" : $("#search").val() },
					data : $("#searchFrm").serialize(),
					success : function(data) {
						$("#list").html(data);
					},
					error : function(request, status, error) {
						//alert(params);
						alert("code : " + request.status + "\n"
							+ "message : "
							+ request.responseText + "\n"
							+ "error:" + error);
					}
				})
//			$("#searchFrm").attr("action","list").attr("method","post").submit();
			})

			//날짜
			$("#startdate").datepicker({
				dateFormat : 'yy-mm-dd'
				});
			$("#enddate").datepicker({
				dateFormat : 'yy-mm-dd'
				});
		})
		
		function goPage(pageNo){
			location.href = "list?pageNo="+pageNo;
		}
</script>
</head>
<body>
		<h2>게시판 목록</h2>
		<button onclick="location='write'">글작성</button>
		<button id="delete" name="delete">삭제</button>

		<form id="searchFrm" name="searchFrm">
		<div>
			<select id="option" name="option">
				<option value="1">전체</option>
				<option value="2">작성자</option>
				<option value="3">제목</option>
				<option value="4">제목+내용</option>
			</select>
			<input type="text" id="search" name="search">
			<input type="text" id="startdate" name="startdate" autocomplete="off">~
			<input type="text" id="enddate" name="enddate" autocomplete="off">
		</div>
		</form>

		<button id="searchBtn" name="searchBtn">검색</button>
		<table width="500" cellpadding="0" cellspacing="0" border="1">
			<thead>
			<tr>
				<td>
				<input type="checkbox" id="checkboxleader" name="checkboxleader">
				</td>
				<td>번호</td>
				<td>작성자</td>
				<td>제목</td>
				<td>작성일</td>
				<td>수정일</td>
				<td>조회수</td>
			<tr>
			</thead>
				<form id="checkdelete" name="checkdelete">

				<tbody id="list">
					<c:forEach items="${list }" var="dto">
						<tr>
							<td><input type="checkbox" id="checkbox" name="checkbox"
								value="${dto.seq }"></td>
							<td>${dto.seq }</td>
							<td>${dto.memName }(${dto.memId })</td>
							<td><a href="content_view?seq=${dto.seq }">${dto.boardSubject }</a></td>
							<td><fmt:formatDate value="${dto.regDate }"
									pattern="yyyy-MM-dd" /></td>
							<td><fmt:formatDate value="${dto.uptDate }"
									pattern="yyyy-MM-dd" /></td>
							<td>${dto.viewCnt }</td>
						<tr>
					</c:forEach>
				</tbody>
					
				</form>
				
			<tfoot>
			<tr>
				<td colspan="7">
					<div class="paginate">
			
						값 : ${pageMap.curBlock }
						<c:if test="${pageMap.currentPage > 1}">
							<a href="javascript:goPage('1')">[처음]</a>
						</c:if>
						<c:if test="${pageMap.curPage > 1}">
		                    <a href="javascript:goPage('${pageMap.prevPage}')">[이전]</a>
		                </c:if>
	                
		                <!-- **하나의 블럭에서 반복문 수행 시작페이지부터 끝페이지까지 -->
		                <c:forEach var="num" begin="${pageMap.blockBegin}" end="${pageMap.blockEnd}">
		                    <!-- **현재페이지이면 하이퍼링크 제거 -->
		                    <c:choose>
		                        <c:when test="${num == pageMap.currentPage}">
		                            <span style="color: red">${num}</span>&nbsp;
		                        </c:when>
		                        <c:otherwise>
		                            <a href="javascript:goPage('${num}')">${num}</a>&nbsp;
		                        </c:otherwise>
		                    </c:choose>
		                </c:forEach>
		                
		                <!-- **다음페이지 블록으로 이동 : 현재 페이지 블럭이 전체 페이지 블럭보다 작거나 같으면 [다음]하이퍼링크를 화면에 출력 -->
		                <c:if test="${pageMap.curPage <= pageMap.totBlock}">
		                    <a href="javascript:goPage('${pageMap.nextPage}')">[다음]</a>
		                </c:if>
		                
		                <!-- **끝페이지로 이동 : 현재 페이지가 전체 페이지보다 작거나 같으면 [끝]하이퍼링크를 화면에 출력 -->
		                <c:if test="${pageMap.curPage <= pageMap.totalCount}">
		                    <a href="javascript:goPage('${pageMap.totalCount}')">[끝]</a>
		                </c:if>
					</div>
				</td>
			</tr>
		</tfoot>
		
		</table>
		<form id="uploadFrm" name="uploadFrm" enctype="multipart/form-data">
		<input type="file" name="file" id="file" multiple>
		</form>
		<input type="button" name = "uploadBtn" id="uploadBtn" value="upload">
		
			<br />
			
					<select name="foood" id = "foood">
							<option selected>-선택-</option>
							<option value='korea'>한식</option>
							<option value='china'>중식</option>
							<option value='japan'>일식</option>
					</select>
			<div id="food">		
					<select name="menu">
							<option selected>-선택-</option>
					</select>
			</div>
		
			<script>
			//업로드 그림제한
			$("#file").change(function() {
				
				alert("test");
			})
			
			//업로드 버튼 
			$("#uploadBtn").click(function() {
				$("#uploadFrm").attr("action", "upload").attr("method", "post").submit();
			})
			
			//검색
			$("#foood").change(function() {
				$.ajax({
					type : "get",
					url : "/spring/food",
					data: { "food" : $("#foood").val() },
					success : function(data) {
						$("#food").html(data);
					},
					error : function(request, status, error) {
						//alert(params);
						alert("code : " + request.status + "\n"
							+ "message : "
							+ request.responseText + "\n"
							+ "error:" + error);
					}
				})
			})
			</script>
	
</body>
</html>