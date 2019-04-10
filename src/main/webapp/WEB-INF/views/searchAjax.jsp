<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:forEach items="${list }" var="dto">
	<tr>
		<td><input type="checkbox" id="checkbox" name="checkbox"
			value="${dto.seq }"></td>
		<td>${dto.seq }</td>
		<td>${dto.memName }(${dto.memId })</td>
		<td><a href="content_view?seq=${dto.seq }">${dto.boardSubject }</a></td>
		<td><fmt:formatDate value="${dto.regDate }" pattern="yyyy-MM-dd" /></td>
		<td><fmt:formatDate value="${dto.uptDate }" pattern="yyyy-MM-dd" /></td>
		<td>${dto.viewCnt }</td>
	<tr>
</c:forEach>