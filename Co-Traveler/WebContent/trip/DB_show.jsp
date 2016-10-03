<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*" import="java.util.*"%>
<%
	request.setCharacterEncoding("UTF-8");

	//DB connection ready
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	
	int result = 0;
	
	String dbUrl = "jdbc:mysql://54.68.109.68/project?characterEncoding=UTF-8";
	String dbUser = "seunggabi";
	String dbPassword = "co-traveler";
	
	String startPlace = "";
	String destPlace = "";
	String t_id="";
	String title = "";
	String start = "";
	String dest = "";
	int tripnum = 0;
	String content = "";
	String sdate = "";
	String edate = "";
	String geoX="";
	String geoY="";
	String tId="";
	String uId="";
	int maxNum = 0;
	int tNum = 0;
	String inTrip = "";
	
	try{
		Class.forName("com.mysql.jdbc.Driver");
		
		//DB Connection
		conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
 		startPlace = request.getParameter("p1");
 		destPlace = request.getParameter("p2");
 		
 		if(request.getMethod() == "POST"){
			tId = request.getParameter("t_id");
			uId = (String)session.getAttribute("id");
			
			stmt = conn.prepareStatement("SELECT tripnum FROM trip WHERE t_id=?");
			stmt.setString(1, tId);
			rs = stmt.executeQuery();
			if(rs.next()){	maxNum = rs.getInt(1);	}
			
			stmt = conn.prepareStatement("SELECT count(*) FROM trip_partner WHERE t_id=?");
			stmt.setString(1, tId);
			rs = stmt.executeQuery();
			if(rs.next()){	tNum = rs.getInt(1) + 1;	}
			
			if(maxNum <= tNum){
				%>
					<script type="text/javascript">
						alert("여행 정원 초과입니다");
						location.href="./show.jsp";
					</script><br />
				<% 
			} else{
				stmt = conn.prepareStatement("INSERT INTO trip_partner(t_id, u_id) VALUES(?, ?)");
				stmt.setString(1, tId);
				stmt.setString(2, uId);
			
				result = stmt.executeUpdate();
				if(result != 1){
					out.println("실패");
				} else{
				%>
					<script type="text/javascript">
						alert("여행 참가가 완료되었습니다!");
  					location.href="../show.jsp";
					</script><br />
				<% 
				}
			}
	}
    if(!(startPlace == null)){
    	destPlace="";
    	stmt = conn.prepareStatement("SELECT t_id, title, start, dest, tripnum, content, sdate, edate, spos_x, spos_y FROM trip WHERE start LIKE ?");
			stmt.setString(1, "%" + startPlace + "%");
			rs = stmt.executeQuery();
			
				while(rs.next()){
					t_id = rs.getString("t_id");
					title = rs.getString("title");
					start = rs.getString("start");
					dest = rs.getString("dest");
					tripnum = rs.getInt("tripnum");
					content = rs.getString("content");
					sdate = rs.getString("sdate");
					edate = rs.getString("edate");
					geoX = rs.getString("spos_x");
					geoY = rs.getString("spos_y");
					
					out.print(title + "," + start + "," + dest + "," + 
						String.valueOf(tripnum) + "," + content + "," + sdate + "," + edate + "," + geoX + "," + geoY + "," + t_id + ",");
				}
    } else if(destPlace != null){
    	startPlace="";
    	stmt = conn.prepareStatement("SELECT t_id, title, start, dest, tripnum, content, sdate, edate, dpos_x, dpos_y FROM trip WHERE dest LIKE ?");
			stmt.setString(1, "%" + destPlace + "%");
	
			rs = stmt.executeQuery();
			
			while(rs.next()){
				t_id = rs.getString("t_id");
				title = rs.getString("title");
				start = rs.getString("start");
				dest = rs.getString("dest");
				tripnum = rs.getInt("tripnum");
				content = rs.getString("content");
				sdate = rs.getString("sdate");
				edate = rs.getString("edate");
				geoX = rs.getString("dpos_x");
				geoY = rs.getString("dpos_y");
				out.println(title + "," + start + "," + dest + "," + 
						String.valueOf(tripnum) + "," + content + "," + sdate + "," + edate + "," + geoX + "," + geoY + "," + t_id + ",");
			}
    }	else{ 
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
    	}
		} catch(SQLException e){
					out.println("SQL error");
		} finally {
					if(rs != null) try{rs.close();} catch(SQLException e){}
					if(stmt != null) try{stmt.close();} catch(SQLException e){}
					if(conn != null) try{conn.close();} catch(SQLException e){}
		}
	%>
