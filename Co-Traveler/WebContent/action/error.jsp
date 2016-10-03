<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String pageMode = "error";
%>
<%@ page import = "java.sql.*" %>   
<%@ page import="java.util.*" %> 
<%@include file="../share/_header.jsp" %>
<div class="bodyWrapper">
		<div class="alert alert-error">
			<h3>Errors:</h3>
			<ul>
				<c:forEach var="msg" items="${errorMsgs}">
					<li><c:out value="${msg}"/></li>
				</c:forEach>
			</ul>
		</div>
 	<div class="form-action">
 		<a onclick="history.back();" class="btn">뒤로 돌아가기</a>
	</div>
</div>
<%@include file="../share/_footer.jsp" %>