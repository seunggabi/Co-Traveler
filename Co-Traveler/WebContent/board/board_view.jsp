<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%
	String pageMode = request.getParameter("pageMode");
%>
<%@ include file="../share/_header.jsp" %>
<script>
	function rm(b_id)
	{
		if(confirm("정말 삭제하시겠습니까?"))
		{
			location.href = "/Co-Traveler/board?mode=delete&b_id="+b_id;
		}
	}
	function ed(b_id)
	{
		location.href = "/Co-Traveler/board?pageMode=${board.kname}&mode=edit&b_id="+b_id;	
	}
</script>
<div class="bodyWrapper">
	<div class="boardWrapper">
		<div class="boradContent">
				<div class="boardTitle"><h2>[${board.kname}]&nbsp;&nbsp;&nbsp;${board.title}</h2></div>
				<div class="boardAuthor">
					작성자 : ${board.writer}
					<c:set var="adm" value="T" />
					<c:if test="${(sessionScope.id == board.u_id) || (sessionScope.adm == adm)}">
						<input type="button" value="수정" onClick="ed('${board.b_id}')"/>
						<input type="button" value="삭제" onClick="rm('${board.b_id}')"/>
					</c:if>
				</div>
				<br /><br />
				<div>${board.content}</div>				
		</div>
	</div>
</div>	
<%@include file="../share/_footer.jsp" %>