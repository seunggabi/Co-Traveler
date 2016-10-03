<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String mode = pageMode;
	if(mode == "")
	{
		mode = "index";
	}
%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Co-Traveler</title>
		<link rel="stylesheet" href="/Co-Traveler/common/css/common.css">
		<link rel="stylesheet" href="/Co-Traveler/common/css/base.css">
		<link rel="stylesheet" href="/Co-Traveler/bootstrap/css/bootstrap.min.css">
		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
		<script src="/Co-Traveler/bootstrap/js/bootstrap.min.js"></script>	
	</head>
	<body>
		<div id="header">
			<div class="navbar navbar-inverse navbar-fixed-top">
				<div class="container">
					<div class="navbar-header">
						<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
							<span class="icon-bar"></span>
							<span class="icon-bar"></span>
							<span class="icon-bar"></span>
							<span class="icon-bar"></span>
						</button>
						<a class="navbar-brand" href="/Co-Traveler/index.jsp">Co-Traveler</a>
					</div>
					<div class="collapse navbar-collapse">
						<ul class="nav navbar-nav">
							<li<%if(mode.equals("trip")){%> class="active"<%}%>><a href="/Co-Traveler/trip/show.jsp">여행</a></li>
							<li<%if(mode.equals("notice")){%> class="active"<%}%>><a href="/Co-Traveler/board?mode=list&boardName=notice">공지사항</a></li>
							<li<%if(mode.equals("event")){%> class="active"<%}%>><a href="/Co-Traveler/board?mode=list&boardName=event">이벤트</a></li>
							<li<%if(mode.equals("community")){%> class="active"<%}%>><a href="/Co-Traveler/board?mode=list&boardName=community">커뮤니티</a></li>
							<li<%if(mode.equals("mypage")){%> class="active"<%}%>><a href="/Co-Traveler/user?mode=my">나의 여행 일지</a></li>
							<% 
								if(session.getAttribute("id") != null)
								{
									if(session.getAttribute("adm").equals("T"))
									{
							%>
							<li<%if(mode.equals("admin")){%> class="active"<%}%>><a href="/Co-Traveler/admin?mode=list" class='red'>관리</a></li>
							<%
									}
								}
							%>
						</ul>
						<form class="navbar-form navbar-right" action="/Co-Traveler/user" method="POST">
						<%
							if(session.getAttribute("id") == null)
							{
						%>
							<div class="form-group">
								<input name='id' type="text" placeholder="ID" class="form-control">
							</div>
							<div class="form-group">
								<input name='pw' type="password" placeholder="Password" class="form-control">
							</div>
							<div class="form-group">
								<button type="submit" class="btn btn-success">Sign in</button>
							</div>
							<div class="form-group">
								<a href="/Co-Traveler/user/user_register.jsp"><button type="button" class="btn btn-success">Sign up</button></a>
							</div>
							<div class="form-group">
								<a href="/Co-Traveler/user/facebook.jsp"><img src="/Co-Traveler/common/img/fb.png" alt="페이스북 가입 및 로그인" /></a>
							</div>							
							<input type="hidden" name="mode" value="login" />
						<%
							}
							else
							{
						%>
							<button type="submit" class="btn btn-success">Logout</button>
							<input type="hidden" name="mode" value="logout" />
						<%
							}
						%>
						</form>
					</div>
				</div>
			</div>
		</div>
