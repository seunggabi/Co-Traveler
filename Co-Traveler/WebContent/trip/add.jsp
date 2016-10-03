<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.sql.*" import="java.util.*"
	import="java.text.*"%>
<%
	if(session.getAttribute("id") == null)
	{
%>
<script>
	alert('회원만 여행을 등록할 수 있습니다.');
	history.back();
</script>
<%
	return;
	}
	
	String pageMode = "trip";

	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	
	String dbUrl = "jdbc:mysql://54.68.109.68/project?characterEncoding=UTF-8";
	String dbUser = "seunggabi";
	String dbPassword = "co-traveler";
	
	int result = 0;
	
	try{
		Class.forName("com.mysql.jdbc.Driver");
		
		//DB Connection
		conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
	
%>
<%@include file="../share/_header.jsp" %>
<link rel="stylesheet" href="map/googlemap.css" type="text/css">
<script type="text/javascript"
	src="http://maps.googleapis.com/maps/api/js?
	key=AIzaSyBEJKMd2ye82eIix9TBpMo9ZzOWcfNgFoo&sensor=TRUE">
</script>
<script src="https://maps.googleapis.com/maps/api/js?v=3.exp&libraries=places"></script>
<script type="text/javascript" src="./map/googlemaps.js"></script>
<script type="text/javascript" src="./map/httpRequest.js"></script>
<script src="./map/jquery-2.1.1.min.js"></script>
<script>
	//submit 메소드
	function formSubmit()
	{
		var sp1 = document.getElementById('sp1');
		var sp2 = document.getElementById('sp2');
		var sp3 = document.getElementById('sp3');
		var sp4 = document.getElementById('sp4');
		sp1.value = sendLocation('sX');
		sp2.value = sendLocation('sY');
		sp3.value = sendLocation('eX');
		sp4.value = sendLocation('eY');
		document.tripForm.submit();
	}
</script>
	<div id="wrap">
		<div id="map"></div>
		<div id="enroll">
			<% if(request.getMethod() == "POST"){
					request.setCharacterEncoding("UTF-8");
	
					String title = request.getParameter("trip_title");
					String start = request.getParameter("trip_start");
					String dest = request.getParameter("trip_dest");
					String numTrip = request.getParameter("num_member");
					String content = request.getParameter("content");
					String sYear = request.getParameter("syear");
					String sMonth = Integer.parseInt(request.getParameter("smonth")) > 10? 
							request.getParameter("smonth") : "0"+request.getParameter("smonth");
					String sDay = Integer.parseInt(request.getParameter("sday")) > 10? 
							request.getParameter("sday") : "0"+request.getParameter("sday");
					String eYear = request.getParameter("eyear");
					String eMonth = Integer.parseInt(request.getParameter("emonth")) > 10? 
							request.getParameter("emonth") : "0"+request.getParameter("emonth");
					String eDay = Integer.parseInt(request.getParameter("eday")) > 10? 
							request.getParameter("eday") : "0"+request.getParameter("eday");
					String userId = (String)session.getAttribute("id");
					String userName = (String)session.getAttribute("name");
					String startX = String.valueOf(request.getParameter("sp1"));
					String startY = String.valueOf(request.getParameter("sp2"));
					String destX = String.valueOf(request.getParameter("sp3"));
					String destY = String.valueOf(request.getParameter("sp4"));
					//SimpleDateFormat dateFormatter = new SimpleDateFormat("yyyyMMdd");
					String sDate = sYear + sMonth + sDay;
					String eDate = eYear + eMonth + eDay;
					
					stmt = conn.prepareStatement("INSERT INTO trip(u_id, title, start, dest, tripnum, content, sdate, edate, spos_x, spos_y, dpos_x, dpos_y)VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
					
					stmt.setString(1, userId);
					stmt.setString(2, title);
					stmt.setString(3, start);
					stmt.setString(4, dest);
					stmt.setString(5, numTrip);
					stmt.setString(6, content);
					stmt.setString(7, sDate);
					stmt.setString(8, eDate);
					stmt.setString(9, startX);
					stmt.setString(10, startY);
					stmt.setString(11, destX);
					stmt.setString(12, destY);
					
					result = stmt.executeUpdate();
					if(result != 1){
						out.println("실패");
					}
				} else { 
					String userId = (String)session.getAttribute("id");
					String userName = (String)session.getAttribute("name");
					String userLink = userId;
					if(session.getAttribute("join_type") != null)
					{
						if(session.getAttribute("join_type").equals("facebook"))
						{
							userLink = "<a href = 'https://www.facebook.com/app_scoped_user_id/"+userId+"'>"+userName+"</a>";
						}
					}
					%>
			<form name="tripForm" class="form-trip" method="post">
				<table>
					<tr>
						<th>주최</th>
						<td><%=userLink%></td>
					</tr>
					<tr>
						<th>Trip</th>
						<td><input type="text" name="trip_title"></td>
					</tr>
					<tr>
						<th>출발지</th>
						<td><input type="text" name="trip_start" id="tstart"></td>
					</tr>
					<tr>
						<th>도착지</th>
						<td><input type="text" name="trip_dest" id="tdest"></td>
					</tr>
					<tr>
						<th>출발일</th>
						<td>
							<input type="text" class="year" name="syear" id="syear" >
							<input type="text" class="date" name="smonth" id="smonth" onChange="isValidMonth(this)">
							<input type="text" class="date" name="sday" id="sday" onChange="isValidDay(syear, smonth, this)">
						</td>
					</tr>
					<tr>
						<th>종료일</th>
						<td>
							<input type="text" class="year" name="eyear" id="eyear">
							<input type="text" class="date" name="emonth" id="emonth" onChange="isValidMonth(this)">
							<input type="text" class="date" name="eday" id="eday" onChange="isValidDay(eyear, emonth, this)">
						</td>
					</tr>
					<tr>
						<th>모집인원</th>
						<td><select name="num_member">
								<option value="2">2</option>
								<option value="3">3</option>
								<option value="4">4</option>
								<option value="5">5</option>
								<option value="6">6</option>
								<option value="7">7</option>
								<option value="8">8</option>
								<option value="9">9</option>
								<option value="10">10</option>
						</select></td>
					</tr>
					<tr>
						<td>내용</td>
						<th><textarea rows="10" cols="15" name="content" ></textarea></th>
					</tr>
				</table>
				<input type="hidden" id="sp1" name="sp1" value=""/>
				<input type="hidden" id="sp2" name="sp2" value=""/>
				<input type="hidden" id="sp3" name="sp3" value=""/>
				<input type="hidden" id="sp4" name="sp4" value=""/>
				<input type="button" onClick="formSubmit()" value="여행 등록">
			</form>
			<% }
			} catch(SQLException e){
					out.println("SQL error");
			} finally {
					if(rs != null) try{rs.close();} catch(SQLException e){}
					if(stmt != null) try{stmt.close();} catch(SQLException e){}
					if(conn != null) try{conn.close();} catch(SQLException e){}
			} %>
		</div>
		</div>
<%@include file="../share/_footer.jsp" %>
<script type="text/javascript">
/*
* 유효한(존재하는) 월(月)인지 체크
*/
function isValidMonth(mm) {
   var m = parseInt(mm,10);
   return (m >= 1 && m <= 12);
}

/**
 * 유효한(존재하는) 일(日)인지 체크
 */
function isValidDay(yyyy, mm, dd) {
    var m = parseInt(mm,10) - 1;
    var d = parseInt(dd,10);
 
    var end = new Array(31,28,31,30,31,30,31,31,30,31,30,31);
    if ((yyyy % 4 == 0 && yyyy % 100 != 0) || yyyy % 400 == 0) {
        end[1] = 29;
    }
 
    return (d >= 1 && d <= end[m]);
}
</script>