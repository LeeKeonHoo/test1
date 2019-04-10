<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
    <c:choose>
		<c:when test = "${map.food == 'korea'}">
					<select name="menu">
							<option selected>-선택-</option>
							<option>순두부찌개</option>
							<option>김치찌개</option>
							<option>된장찌개</option>
							<option>순대국</option>
					</select>
		</c:when>
		<c:when test = "${map.food == 'china'}">
					<select name="menu">
							<option selected>-선택-</option>
							<option>짜장면</option>
							<option>짬뽕</option>
							<option>탕수육</option>
							<option>팔보채</option>
					</select>
		</c:when>
		<c:when test = "${map.food == 'japan'}">
					<select name="menu">
							<option selected>-선택-</option>
							<option>초밥</option>
							<option>규동</option>
							<option>타코야끼</option>
							<option>라멘</option>
					</select>
		</c:when>
		<c:otherwise>
					<select name="menu">
							<option selected>-선택-</option>
					</select>
		</c:otherwise>

	</c:choose>

					