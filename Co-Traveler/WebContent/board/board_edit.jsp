<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String pageMode = request.getParameter("pageMode");
	String boardName = "";
%>
<%@ include file="../share/_header.jsp" %>
<div class="bodyWrapper">
	<div class="boardWrapper">
		<!-- 스마트에디터 CSS, 자바스크립트 관련 자료 설정 -->
		<link href="/Co-Traveler/se2/css/smart_editor2.css" rel="stylesheet" type="text/css" />
		<form method="post" action="/Co-Traveler/board?mode=edit" name="f">
			<table border="1" cellspacing="0" style="width:100%">
				<tr>
					<td>제목</td>
					<td style="text-align:left !important"><input type="text" name="title" size=60 value="${board.title}" /></td>
				</tr>
				<tr>
					<td>내용</td>
					<td>
						<textarea name="content" id="content" style="width:100%;height:300px; display:block;">${board.content}</textarea>
					</td>
				</tr>
			</table>
			<input type="button" onclick="submit()" value="수정"></input>
			<input type="hidden" name="mode" value="edit"></input>
			<input type="hidden" name="b_id" value="${board.b_id}"></input>
		</form>
	</div>
</div>	
<%@include file="../share/_footer.jsp" %>