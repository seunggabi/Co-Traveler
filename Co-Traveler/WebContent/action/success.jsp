<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String pageMode = "success";
%>
<%@ page import = "java.sql.*" %>   
<%@ page import="java.util.*" %> 
<%@include file="../share/_header.jsp" %>
<div class="bodyWrapper">
 		<div class="alert alert-success">
 			${msg}
 		</div>
	 	<div class="form-action">
	 		<a href="/Co-Traveler/index.jsp" class="btn">메인으로</a>
	 	</div>
</div>
<%@include file="../share/_footer.jsp" %>