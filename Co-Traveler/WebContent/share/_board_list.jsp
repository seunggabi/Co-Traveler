<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ page import = "java.sql.*" %>   
<%@ page import="java.util.*" %> 
<%@include file="../share/_header.jsp" %>
<div class="bodyWrapper">
	<div class="boardWrapper">
		<h2><%=pageName%></h2>
		<%
			if(session.getAttribute("id") != null)
			{
		%>
		<div class="menu">
			<a href="/Co-Traveler/board/board_write.jsp?pageMode=<%=pageMode%>">
	   			<input type="button" class="btn btn-default" value="글쓰기">
	   		</a>
	   	</div>
		<%
			}
		%>
		<div class="borad">
			<table>
				<thead>
					<tr>
						<th class="num">번호</th>
						<th class="title">제목</th>
						<th class="author">작성자</th>
						<th class="wtime">작성일</th>
						<th class="cnt">조회수</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="board" items="${boards.list }" varStatus="i">
						<tr>
							<td>${boardListCnt - (boards.page-1)*10 - i.index }</td>
							<td><a href='/Co-Traveler/board?mode=view&b_id=${board.b_id }&pageMode=<%=pageMode%>'>${board.title}&nbsp;</a></td>
							<td>${board.u_id}</td>
							<td>${board.wtime}</td>
							<td>${board.cnt}</td>
						</tr>					
					</c:forEach>
				</tbody>
				<tfoot>
				</tfoot>
			</table>
		<div class="btnBox">
			<jsp:include page="../share/_page.jsp">
				<jsp:param name="currentPage" value="${boards.page}"/>
				<jsp:param name="url" value="board?mode=list&boardName=${boardName}"/>
				<jsp:param name="startPage" value="${boards.startPageNo}"/>
				<jsp:param name="endPage" value="${boards.endPageNo}"/>
				<jsp:param name="numPages" value="${boards.numPages}"/>
			</jsp:include>
		</div>
		</div>
	</div>
</div>	
<%@include file="../share/_footer.jsp" %>