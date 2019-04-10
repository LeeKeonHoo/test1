<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src = "./resources/js/jquery-3.3.1.min.js"></script>
	<script type="text/javascript">
	$(function(){
		$("#writeBtn").click(function(){
			$("#writeok").attr("action","writeok").attr("method","post").submit(); 

			//이런 방법도 있다 1
//			$("#writeok").attr("action","writeok");
//			$("#writeok").attr("method","post");
//			$("#writeok").submit();
			//이런 방법도 있다 2
//			document.writeok.action = "writeok";
//			document.writeok.method = "post";
//			document.writeok.submit();

		})
		
		$("#modifyBtn").click(function(){
			$("#writeok").attr("action","modify").attr("method","post").submit(); 
		})
	})
	</script>

</head>
<body>
${content}
	<form id="writeok" name="writeok">
	<input type="hidden" name = "seq" id="seq" value="${content.seq }">
	작성자 : <input type = "text" name="name" id="name" value="${content.memName }"><br />
	아이디 : <input type = "text" name="id" id="id" value="${content.memId }"><br />	
	제목 : <input type = "text" name="title" id="title" value="${content.boardSubject }"><br />
	내용 : <br />
	<textarea rows="10" cols= "30" name="content" id="content">${content.boardContent }</textarea><br />
	</form>
	<div>
	<c:choose>
		<c:when test = "${empty content }">
			<input type="button" value="입력" name="writeBtn" id="writeBtn">	
		</c:when>
		<c:otherwise>
			<input type="button" value="수정" name="modifyBtn" id="modifyBtn">	
		</c:otherwise>
	</c:choose>
	<input type="button" value="취소" name="bakBtn" id="bakBtn" onclick="location.href='list'">	
	</div>
</body>
</html>