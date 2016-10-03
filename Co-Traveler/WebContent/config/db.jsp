<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*" import="java.util.*" 
    import="org.apache.commons.lang3.StringUtils"%>
<%
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	
	String dbUrl = "jdbc:mysql://localhost:3306/project";
	String dbUser = "root";
	String dbPassword = "autoset";
	
	request.setCharacterEncoding("utf-8");
%>