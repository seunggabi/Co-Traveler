<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%
	String pageMode = "mypage";
%>
<%@include file="../share/_header.jsp" %>
<script>
	function checkForm()
	{
		if(confirm("정말 탈퇴하시겠습니까?"))
		{
			document.withdrawal.submit();			
		}
	}
</script>
<%if(session.getAttribute("id") != null){ %>
<div class="bodyWrapper">
	<div id="myPageBox">
		<form name="withdrawal" method="POST" action="/Co-Traveler/user">
			<div class="input-group">
				<input type="hidden" name="id" value="<%=session.getAttribute("id")%>">
				<input type="hidden" name="mode" value="withdrawal">
	     		<input type="PASSWORD" name="pw" class="form-control">
	     		<span class="input-group-btn">
					<input type="button" class="btn btn-default" value="회원탈퇴" onclick="checkForm()"/>
	     		</span>
	   		</div>
	   	</form>
	   	<br/><br/><br/>	
	   	<a href="/Co-Traveler/user?mode=view&id=${sessionScope.id}">
	   		<input type="button" class="btn btn-default" value="정보수정"/>
	   	</a>
	   	<div id="myTrip">
	   		<div class="boardTitle"><h2>주최 여행 목록</h2></div>
			<table>
				<thead>
					<tr>
						<th class="num">번호</th>
						<th class="tripTitle">여행 제목</th>
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
							<td>${tripUserListCnt - (trips.page-1)*10 - i.index }</td>
							<td>${trip.title}</td>
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
			<div class="boardTitle"><h2>참가 여행 목록</h2></div>
			<table>
				<thead>
					<tr>
						<th class="num">번호</th>
						<th class="tripTitle">여행 제목</th>
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
					<c:forEach var="tripPartner" items="${tripPartners.list}" varStatus="i">
						<tr>
							<td>${tripJoinListCnt - (tripPartners.page-1)*10 - i.index }</td>
							<td>${tripPartner.title}</td>
							<td>${tripPartner.start}</td>
							<td>${tripPartner.dest}</td>
							<td>${tripPartner.tripnum}</td>
							<td>${tripPartner.content}</td>
							<td>${tripPartner.wdate}</td>
							<td>${tripPartner.sdate}</td>
							<td>${tripPartner.edate}</td>
							<td>
								<input type="button" value="조회" onClick="tripEdit('')"/><br/>
								<input type="button" value="취소" onClick="tripRemove('')"/>
							</td>
						</tr>					
					</c:forEach>
				</tbody>
				<tfoot>
				</tfoot>
			</table>
			<div class="btnBox">
				<jsp:include page="../share/_page.jsp">
					<jsp:param name="currentPage" value="${tripPartners.page}"/>
					<jsp:param name="addOption" value="upage"/>
					<jsp:param name="addValue" value="<%=request.getParameter(\"upage\")%>"/>
					<jsp:param name="listType" value="b"/>
					<jsp:param name="url" value="admin?mode=list"/>
					<jsp:param name="startPage" value="${tripPartners.startPageNo}"/>
					<jsp:param name="endPage" value="${tripPartners.endPageNo}"/>
					<jsp:param name="numPages" value="${tripPartners.numPages}"/>
				</jsp:include>
			</div>
	   	</div>
	</div>
</div>
<%} %>
<%@include file="../share/_footer.jsp" %>