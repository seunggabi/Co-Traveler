<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%
	String pageMode = "admin";
	Boolean adm = false;
%>
<%
	if(session.getAttribute("id") != null)
	{
		if(session.getAttribute("adm").equals("T"))
		{
			adm = true;
		}
	}
	if(adm == false)
	{
%>
<script>
	alert('관리자만 접근할 수 있습니다.');
	history.back();
</script>
<%
		return;
	}
%>
<%@include file="../share/_header.jsp" %>
<script>
	function boardRemove(b_id)
	{
		if(confirm("정말 삭제하시겠습니까?"))
		{
			location.href = "/Co-Traveler/board?mode=delete&b_id="+b_id;
		}
	}
	function boardEdit(b_id)
	{
		location.href = "/Co-Traveler/board?pageMode=${board.kname}&mode=edit&b_id="+b_id;	
	}
	function userRemove(u_id)
	{
		if(confirm("정말 삭제하시겠습니까?"))
		{
			location.href = "/Co-Traveler/user?mode=withdrawal&id="+u_id;
		}
	}
	function userEdit(u_id)
	{
		location.href = "/Co-Traveler/user?mode=view&id="+u_id;	
	}
	function tripRemove(t_id)
	{
	}
	function tripEdit(t_id)
	{
	}
</script>
<div class="bodyWrapper">
	<div class="boardWrapper">
		<div class="borad">
			<div class="boardTitle"><h2>회원 목록</h2></div>		
				<table>
					<thead>
						<tr>
							<th class="joinType">번호</th>
							<th class="joinType">가입종류</th>
							<th class="userId">아이디</th>
							<th class="userName">이름</th>
							<th class="gender">성별</th>
							<th class="email">이메일</th>
							<th class="tel">전화번호</th>
							<th class="start">선호 출발지</th>
							<th class="manage">관리</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="user" items="${users.list}" varStatus="i">
							<tr>
								<td>${userListCnt - (users.page-1)*10 - i.index }</td>
								<td>${user.join_type}</td>
								<td>${user.id}</td>
								<td>${user.name}</td>
								<td>${user.gender}</td>
								<td>${user.email}</td>
								<td>${user.tel}</td>
								<td>${user.start}</td>
								<td>
									<input type="button" value="수정" onClick="userEdit('${user.id}')"/>
									<input type="button" value="삭제" onClick="userRemove('${user.id}')"/>
								</td>
							</tr>					
						</c:forEach>
					</tbody>
					<tfoot>
					</tfoot>
				</table>
				<div class="btnBox">
					<jsp:include page="../share/_page.jsp">
						<jsp:param name="currentPage" value="${users.page}"/>
						<jsp:param name="addOption" value="bpage"/>
						<jsp:param name="addValue" value="<%=request.getParameter(\"bpage\")%>"/>
						<jsp:param name="listType" value="u"/>					
						<jsp:param name="url" value="admin?mode=list"/>
						<jsp:param name="startPage" value="${users.startPageNo}"/>
						<jsp:param name="endPage" value="${users.endPageNo}"/>
						<jsp:param name="numPages" value="${users.numPages}"/>
					</jsp:include>
				</div>
				<div class="boardTitle"><h2>게시글 목록</h2></div>
				<table>
					<thead>
						<tr>
							<th class="num">번호</th>
							<th class="category">카테고리</th>
							<th class="title">제목</th>
							<th class="author">작성자</th>
							<th class="wtime">작성일</th>
							<th class="cnt">조회수</th>
							<th class="manage">관리</th>						
						</tr>
					</thead>
					<tbody>
						<c:forEach var="board" items="${boards.list}" varStatus="i">
							<tr>
								<td>${boardListCnt - (boards.page-1)*10 - i.index }</td>
								<td>${board.name}</td>
								<td><a href='/Co-Traveler/board?mode=view&b_id=${board.b_id}&pageMode=<%=pageMode%>'>${board.title}&nbsp;</a></td>
								<td>${board.u_id}</td>
								<td>${board.wtime}</td>
								<td>${board.cnt}</td>
								<td>
									<input type="button" value="수정" onClick="boardEdit('${board.b_id}')"/>
									<input type="button" value="삭제" onClick="boardRemove('${board.b_id}')"/>
								</td>
							</tr>					
						</c:forEach>
					</tbody>
					<tfoot>
					</tfoot>
				</table>
				<div class="btnBox">
					<jsp:include page="../share/_page.jsp">
						<jsp:param name="currentPage" value="${boards.page}"/>
						<jsp:param name="addOption" value="upage"/>
						<jsp:param name="addValue" value="<%=request.getParameter(\"upage\")%>"/>
						<jsp:param name="listType" value="b"/>
						<jsp:param name="url" value="admin?mode=list"/>
						<jsp:param name="startPage" value="${boards.startPageNo}"/>
						<jsp:param name="endPage" value="${boards.endPageNo}"/>
						<jsp:param name="numPages" value="${boards.numPages}"/>
					</jsp:include>
				</div>
				<div class="boardTitle"><h2>여행 목록</h2></div>
				<table>
					<thead>
						<tr>
							<th class="num">번호</th>
							<th class="tripTitle">여행 제목</th>
							<th class="master">주최자</th>
							<th class="start">출발지</th>
							<th class="dest">목적지</th>
							<th class="tripnum">인원</th>
							<th class="content">내용</th>
							<th class="wdate">등록일자</th>
							<th class="sdate">출발일자</th>
							<th class="edate">종료일자</th>	
							<th class="manage">관리</th>			
						</tr>
					</thead>
					<tbody>
						<c:forEach var="trip" items="${trips.list}" varStatus="i">
							<tr>
								<td>${tripListCnt - (trips.page-1)*10 - i.index }</td>
								<td><a href='#'>${trip.title}&nbsp;</a></td>
								<td>${trip.u_id}</td>
								<td>${trip.start}</td>
								<td>${trip.dest}</td>
								<td>${trip.tripnum}</td>
								<td>${trip.content}</td>
								<td>${trip.wdate}</td>
								<td>${trip.sdate}</td>
								<td>${trip.edate}</td>
								<td>
									<input type="button" value="조회" onClick="tripEdit('')"/><br/>
									<input type="button" value="삭제" onClick="tripRemove('')"/>
								</td>
							</tr>					
						</c:forEach>
					</tbody>
					<tfoot>
					</tfoot>
				</table>
				<div class="btnBox">
					<jsp:include page="../share/_page.jsp">
						<jsp:param name="currentPage" value="${trips.page}"/>
						<jsp:param name="addOption" value="upage"/>
						<jsp:param name="addValue" value="<%=request.getParameter(\"upage\")%>"/>
						<jsp:param name="listType" value="b"/>
						<jsp:param name="url" value="admin?mode=list"/>
						<jsp:param name="startPage" value="${trips.startPageNo}"/>
						<jsp:param name="endPage" value="${trips.endPageNo}"/>
						<jsp:param name="numPages" value="${trips.numPages}"/>
					</jsp:include>
				</div>
			</div>
		</div>
	</div>
</div>	
<%@include file="../share/_footer.jsp" %>