<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String pageMode = "register";
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
		if(!ValidateEmail(form.email.value))
		{
			return;
		}
		form.submit(); 
	}
	function ValidateEmail(mail)   
	{  
		if (/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/.test(mail))  
		{  
			return true;  
		}  
	    alert("정확한 이메일을 입력해주세요~^^")  
	    return false;  
	}
</script>
<div class="bodyWrapper">
	<div id="registerBox">
		<form name='registerForm' method="POST" action="/Co-Traveler/user">
			<h2 class="setup-form-title">회원가입</h2>
			<br />
			<dl class="form">
				<dt class="input-label">
					<label>ID</label>
				</dt>
				<dd>
					<input name="id" size="30" type="text">
					<p class="note"></p>
				</dd>
			</dl>
			<dl class="form">
				<dt class="input-label">
					<label>Password</label>
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
					<input name="name" size="30" type="text">
					<p class="note"></p>
				</dd>
			</dl>			
			<dl class="form">
				<dt class="input-label">
					<label>Gender</label>
				</dt>
				<dd>
					남
					<input name="gender" value="M" type="radio">
					여
					<input name="gender" value="F" type="radio">
					<p class="note"></p>
				</dd>
			</dl>
			<dl class="form">
				<dt class="input-label">
					<label>Email</label>
				</dt>
				<dd>
					<input name="email" size="30" type="email" onBlur="ValidateEmail(this.value)">
					<p class="note"></p>
				</dd>
			</dl>
			<dl class="form">
				<dt class="input-label">
					<label>Tel</label>
				</dt>
				<dd>
					<input name="tel" size="30" type="text">
					<p class="note"></p>
				</dd>
			</dl>
			<dl class="form">
				<dt class="input-label">
					<label>선호 출발지</label>
				</dt>
				<dd>
					<input name="start" size="30" type="text">
					<p class="note"></p>
				</dd>
			</dl>
			<div class="btn">
				<button type="button" OnClick="formSubmit()">가입</button>
			</div>
			<input type="hidden" name="mode" value="join" />
			<input type="hidden" name="join_type" value="site" />
		</form>
	</div> <!-- /.setup-form-container -->
</div>
<%@include file="../share/_footer.jsp" %>