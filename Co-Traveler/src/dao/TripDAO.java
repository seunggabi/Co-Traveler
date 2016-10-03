package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import bean.PageResult;
import bean.Trip;
import bean.User;

public class TripDAO {
	private static Connection conn;

	public static DataSource getDataSource() throws NamingException {
		Context initCtx = null;
		Context envCtx = null;

		// Obtain our environment naming context
		initCtx = new InitialContext();
		envCtx = (Context) initCtx.lookup("java:comp/env");

		// Look up our data source
		return (DataSource) envCtx.lookup("jdbc/WebDB");
	}
	
	public static int tripListCnt() throws NamingException
	{
		int cnt=0;
		
		PreparedStatement stmt = null;
		ResultSet rs = null;
		DataSource ds = getDataSource();
		
		try 
		{
			conn =  ds.getConnection();
			stmt = conn.prepareStatement(
					"SELECT count(*) AS total FROM trip "
					);
			rs = stmt.executeQuery();
			
		    while(rs.next())
		    {                
		    	cnt = rs.getInt("total");
		    }
		}
		catch (SQLException e)
		{					
		} 
		finally
		{
			if (rs != null) try{rs.close();} catch(SQLException e) {}
			if (stmt != null) try{stmt.close();} catch(SQLException e) {}
			if (conn != null) try{conn.close();} catch(SQLException e) {}
		}
		return cnt;
	}
	
	public static int tripUserListCnt(String id) throws NamingException
	{
		int cnt=0;
		
		PreparedStatement stmt = null;
		ResultSet rs = null;
		DataSource ds = getDataSource();
		
		try 
		{
			conn =  ds.getConnection();
			stmt = conn.prepareStatement(
					"SELECT count(*) AS total FROM trip WHERE u_id = ?"
					);
			stmt.setString(1, id);
			rs = stmt.executeQuery();
		    while(rs.next())
		    {                
		    	cnt = rs.getInt("total");
		    }
		}
		catch (SQLException e)
		{					
		} 
		finally
		{
			if (rs != null) try{rs.close();} catch(SQLException e) {}
			if (stmt != null) try{stmt.close();} catch(SQLException e) {}
			if (conn != null) try{conn.close();} catch(SQLException e) {}
		}
		return cnt;
	}
	
	public static int tripPartnerListCnt(String id) throws NamingException
	{
		int cnt=0;
		
		PreparedStatement stmt = null;
		ResultSet rs = null;
		DataSource ds = getDataSource();
		
		try 
		{
			conn =  ds.getConnection();
			stmt = conn.prepareStatement(
					"SELECT count(*) AS total FROM trip_partner WHERE u_id = ?"
					);
			stmt.setString(1, id);
			rs = stmt.executeQuery();
		    while(rs.next())
		    {                
		    	cnt = rs.getInt("total");
		    }
		}
		catch (SQLException e)
		{					
		} 
		finally
		{
			if (rs != null) try{rs.close();} catch(SQLException e) {}
			if (stmt != null) try{stmt.close();} catch(SQLException e) {}
			if (conn != null) try{conn.close();} catch(SQLException e) {}
		}
		return cnt;
	}
	
	public static PageResult<Trip> getPage(int page, int numItemsInPage) 
			throws SQLException, NamingException 
	{
		User user = new User();
		String u_id = "";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		DataSource ds = getDataSource();

		if (page <= 0) 
		{
			page = 1;
		}
		PageResult<Trip> result = new PageResult<Trip>(numItemsInPage, page);
		
		int startPos = (page - 1) * numItemsInPage;

    	try 
    	{ 
			result.setNumItems(tripListCnt());

			conn = ds.getConnection();

			// 질의 준비
			stmt = conn.prepareStatement("SELECT * FROM trip AS t JOIN users AS u ON t.u_id = u.id ORDER BY t.t_id DESC LIMIT " + startPos + ", " + numItemsInPage);
			rs = stmt.executeQuery();	
			
			while(rs.next()) 
			{
				if(rs.getString("u.join_type").equals("facebook"))
				{
					user = new User(rs.getString("u.id"), rs.getString("u.name"));
					u_id = user.facebookUserName();
				}
				else
				{
					u_id = rs.getString("u.u_id");
				}
				result.getList().add(new Trip(rs.getInt("t.t_id")
						,u_id
						,rs.getString("t.title")
						,rs.getString("t.start")
						,rs.getString("t.dest")
						,rs.getInt("t.tripnum")
						,rs.getString("t.content")
						,rs.getString("t.wdate")
						,rs.getString("t.sdate")
						,rs.getString("t.edate")
						,rs.getString("t.spos_x")
						,rs.getString("t.spos_y")
						,rs.getString("t.dpos_x")
						,rs.getString("t.dpos_y")));
			}
		}
    	finally 
		{
			if (rs != null) try{rs.close();} catch(SQLException e) {}
			if (stmt != null) try{stmt.close();} catch(SQLException e) {}
			if (conn != null) try{conn.close();} catch(SQLException e) {}
		}
		
		return result;		
	}        
	public static PageResult<Trip> getUserPage(int page, int numItemsInPage, String id) 
			throws SQLException, NamingException 
	{
		User user = new User();
		String u_id = "";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		DataSource ds = getDataSource();

		if (page <= 0) 
		{
			page = 1;
		}
		PageResult<Trip> result = new PageResult<Trip>(numItemsInPage, page);
		
		int startPos = (page - 1) * numItemsInPage;

    	try 
    	{ 
			result.setNumItems(tripListCnt());

			conn = ds.getConnection();

			// 질의 준비
			stmt = conn.prepareStatement("SELECT * FROM trip AS t JOIN users AS u ON t.u_id = u.id WHERE u.id = ? ORDER BY t.t_id DESC LIMIT " + startPos + ", " + numItemsInPage);
			stmt.setString(1, id);
			rs = stmt.executeQuery();	
			
			while(rs.next()) 
			{
				if(rs.getString("u.join_type").equals("facebook"))
				{
					user = new User(rs.getString("u.id"), rs.getString("u.name"));
					u_id = user.facebookUserName();
				}
				else
				{
					u_id = rs.getString("u.u_id");
				}
				result.getList().add(new Trip(rs.getInt("t.t_id")
						,u_id
						,rs.getString("t.title")
						,rs.getString("t.start")
						,rs.getString("t.dest")
						,rs.getInt("t.tripnum")
						,rs.getString("t.content")
						,rs.getString("t.wdate")
						,rs.getString("t.sdate")
						,rs.getString("t.edate")
						,rs.getString("t.spos_x")
						,rs.getString("t.spos_y")
						,rs.getString("t.dpos_x")
						,rs.getString("t.dpos_y")));
			}
		}
    	finally 
		{
			if (rs != null) try{rs.close();} catch(SQLException e) {}
			if (stmt != null) try{stmt.close();} catch(SQLException e) {}
			if (conn != null) try{conn.close();} catch(SQLException e) {}
		}
		
		return result;		
	}
	public static PageResult<Trip> getUserPartnerPage(int page, int numItemsInPage, String id) 
			throws SQLException, NamingException 
	{
		User user = new User();
		String u_id = "";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		DataSource ds = getDataSource();

		if (page <= 0) 
		{
			page = 1;
		}
		PageResult<Trip> result = new PageResult<Trip>(numItemsInPage, page);
		
		int startPos = (page - 1) * numItemsInPage;

    	try 
    	{ 
			result.setNumItems(tripListCnt());

			conn = ds.getConnection();

			// trip partner, trip, user 유저에서 정보가져오고 해야됨 정보가져올때 계정 필요없으니 그냥 두게만 조인하면될까?
			stmt = conn.prepareStatement("SELECT * FROM trip_partner AS tp JOIN trip AS t ON tp.t_id = t.t_id WHERE tp.u_id = ? ORDER BY tp_id DESC LIMIT " + startPos + ", " + numItemsInPage);
			stmt.setString(1, id);
			rs = stmt.executeQuery();	
			
			while(rs.next()) 
			{
				u_id = rs.getString("t.u_id");
				result.getList().add(new Trip(rs.getInt("t.t_id")
						,u_id
						,rs.getString("t.title")
						,rs.getString("t.start")
						,rs.getString("t.dest")
						,rs.getInt("t.tripnum")
						,rs.getString("t.content")
						,rs.getString("t.wdate")
						,rs.getString("t.sdate")
						,rs.getString("t.edate")
						,rs.getString("t.spos_x")
						,rs.getString("t.spos_y")
						,rs.getString("t.dpos_x")
						,rs.getString("t.dpos_y")));
			}
		}
    	finally 
		{
			if (rs != null) try{rs.close();} catch(SQLException e) {}
			if (stmt != null) try{stmt.close();} catch(SQLException e) {}
			if (conn != null) try{conn.close();} catch(SQLException e) {}
		}
		
		return result;		
	}
}
