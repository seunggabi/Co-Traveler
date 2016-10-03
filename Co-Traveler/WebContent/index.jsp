<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String pageMode = "index";
%>
<%@include file="share/_header.jsp" %>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="common/js/bjqs-1.3.min.js"></script>
<script type="text/javascript">
	jQuery(document).ready(function($) {
		$('#banner-slide').bjqs({
			animtype      : 'fade',
			height        : 700,
			width         : 1000,
			responsive    : true,
			randomstart   : true
		});
	});
</script>
<div class="bodyWrapper">
	<div class="mainWrapper">
		<div class="animation_canvas">
			<div id="banner-slide">
				<ul class="bjqs">
					<li><img src="common/img/1.jpg" alt="이미지" /></li>
					<li><img src="common/img/2.jpg" alt="이미지" /></li>
					<li><img src="common/img/3.jpg" alt="이미지" /></li>
					<li><img src="common/img/4.jpg" alt="이미지" /></li>
					<li><img src="common/img/5.jpg" alt="이미지" /></li>
				</ul>
			</div>
		</div>
	</div>
</div>
<%@include file="share/_footer.jsp" %>