<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String pageMode = request.getParameter("pageMode");
	String boardName = "";
%>
<%@ include file="../share/_header.jsp" %>
<%
	if(pageMode.equals("event") || pageMode.equals("notice"))
	{
		if(!session.getAttribute("adm").equals("T"))
		{
%>
<script>
	alert("관리자만 쓸 수 있습니다.");
	history.back();
</script>
<%
		return;
		}
	}
%>
<div class="bodyWrapper">
	<div class="boardWrapper">
		<!-- 스마트에디터 CSS, 자바스크립트 관련 자료 설정 -->
		<form method="post" action="/Co-Traveler/board" name="f">
			<table border="1" style="width:100%">
				<tr>
					<td>제목</td>
					<td style="text-align:left !important"><input type="text" name="title" size=60/></td>
				</tr>
				<tr>
					<td>내용</td>
					<td>
						<textarea name="content" id="content" style="width:100%;height:300px; display:block;"></textarea>
					</td>
				</tr>
			</table>
			<input type="button" onclick="submit()" value="저장"></input>
			<input type="hidden" name="mode" value="write"></input>
			<input type="hidden" name="boardName" value="<%=pageMode %>"/>
		</form>
	</div>
</div>	
<%@include file="../share/_footer.jsp" %>