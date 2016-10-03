<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%
	String pageMode = "userEdit";
%>
<%@include file="../share/_header.jsp" %>
<script>
	function formSubmit()
	{
		var form = document.registerForm;
		if(form.id.value == '')
		{
			alert('아이디가 입력되지 않았습니다.');
			form.id.focus();
			return;
		}
		if(form.pw.value == '')
		{
			alert('패스워드가 입력되지 않았습니다.');
			form.pw.focus();
			return;
		}
		if(form.name.value == '')
		{
			alert('이름이 입력되지 않았습니다.');
			form.name.focus();
			return;
		}
		if(form.gender.value == '')
		{
			alert('성별이 입력되지 않았습니다.');
			form.gender.focus();
			return;
		}
		if(form.email.value == '')
		{
			alert('Email이 입력되지 않았습니다.');
			form.email.focus();
			return;
		}
		if(form.tel.value == '')
		{
			alert('전화번호가 입력되지 않았습니다.');
			form.tel.focus();
			return;
		}
		form.submit(); 
	}
</script>
<div class="bodyWrapper">
	<div id="registerBox">
		<form name='registerForm' method="POST" action="/Co-Traveler/user">
			<h2 class="setup-form-title">정보수정</h2>
			<br />
			<dl class="form">
				<dt class="input-label">
					<label>ID</label>
				</dt>
				<dd>
					${user.id}
					<p class="note"></p>
				</dd>
			</dl>
			<dl class="form">
				<dt class="input-label">
					<label>New Password</label>
				</dt>
				<dd>
					<input name="pw" size="30" type="password">
					<p class="note"></p>
				</dd>
			</dl>
			<dl class="form">
				<dt class="input-label">
					<label>Name</label>
				</dt>
				<dd>
					<input name="name" size="30" type="text" value="${user.name}">
					<p class="note"></p>
				</dd>
			</dl>			
			<dl class="form">
				<dt class="input-label">
					<label>Gender</label>
				</dt>
				<dd>
					남
					<c:choose>
						<c:when test="${user.gender == 'M'}">
							<input name="gender" value="M" type="radio" checked=true>	
						</c:when>
						<c:otherwise>
							<input name="gender" value="M" type="radio">
						</c:otherwise>
					</c:choose>
					여
					<c:choose>
						<c:when test="${user.gender == 'F'}">
							<input name="gender" value="F" type="radio" checked=true>	
						</c:when>
						<c:otherwise>
							<input name="gender" value="F" type="radio">
						</c:otherwise>
					</c:choose>
					<p class="note"></p>
				</dd>
			</dl>
			<dl class="form">
				<dt class="input-label">
					<label>Email</label>
				</dt>
				<dd>
					<input name="email" size="30" type="text" value="${user.email}">
					<p class="note"></p>
				</dd>
			</dl>
			<dl class="form">
				<dt class="input-label">
					<label>Tel</label>
				</dt>
				<dd>
					<input name="tel" size="30" type="text" value="${user.tel}">
					<p class="note"></p>
				</dd>
			</dl>				
			<dl class="form">
				<dt class="input-label">
					<label>선호 출발지</label>
				</dt>
				<dd>
					<input name="start" size="30" type="text" value="${user.start}">
					<p class="note"></p>
				</dd>
			</dl>	
			<div class="btn">
				<button type="button" OnClick="formSubmit()">수정</button>
			</div>
			<input type="hidden" name="mode" value="edit" />
		</form>
	</div> <!-- /.setup-form-container -->
</div>
<%@include file="../share/_footer.jsp" %>