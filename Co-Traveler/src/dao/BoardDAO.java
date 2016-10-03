package dao;

import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import bean.Board;
import bean.PageResult;

public class BoardDAO {
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
	
	public static void boardCntIncrement(int id) throws NamingException, SQLException
	{
		conn = null;
		PreparedStatement stmt = null;
		DataSource ds = getDataSource();
		
		try
		{
			conn =  ds.getConnection();
			stmt = conn.prepareStatement(
					"UPDATE board SET cnt = cnt+1 " +
					"WHERE b_id=?"
					);
			stmt.setInt(1, id);
			stmt.executeUpdate();	
		}
		catch (SQLException e)
		{					
		} 
		finally
		{
			if (stmt != null) try{stmt.close();} catch(SQLException e) {}
			if (conn != null) try{conn.close();} catch(SQLException e) {}
		}
	}
	
	public static Board boardView(int id) throws NamingException, SQLException
	{
		Board board = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		DataSource ds = getDataSource();
		
		try 
		{
			conn =  ds.getConnection();
			stmt = conn.prepareStatement(
					"SELECT * FROM board as b JOIN users as u ON u.id = b.u_id " +
					"WHERE b.b_id=?"
					);
			stmt.setInt(1, id);
			rs = stmt.executeQuery();							
		    while(rs.next())
		    {
		    	if(rs.getString("u.join_type").equals("site"))
		    	{
		    		board = new Board( rs.getInt("b.b_id")
		    			,rs.getString("b.name")
		    			,rs.getString("b.u_id")
		    			,rs.getString("b.title")
		    			,rs.getString("b.content")
		    			,rs.getString("b.wtime")
		    			,rs.getInt("b.cnt")

		    			);
		    		board.setWriter(rs.getString("u.id"));
		    	}
		    	else
		    	{
		    		board = new Board( rs.getInt("b.b_id")
		    			,rs.getString("b.name")
		    			,rs.getString("b.u_id")
		    			,rs.getString("b.title")
		    			,rs.getString("b.content")
		    			,rs.getString("b.wtime")
		    			,rs.getInt("b.cnt")

		    			);
		    		board.setWriter("<a href = 'https://www.facebook.com/app_scoped_user_id/"+rs.getString("b.u_id")+"'>"+rs.getString("u.name")+"</a>");
		    	}
		    	
		    	if(rs.getString("name").equals("notice"))
		    	{
		    		board.setKname("공지사항");
		    	}
		    	else if(rs.getString("name").equals("event"))
		    	{
		    		board.setKname("이벤트");
		    	}
		    	else if(rs.getString("name").equals("community"))
		    	{
		    		board.setKname("커뮤니티");
		    	}
		    	else
		    	{
		    		board.setKname(rs.getString("b.name"));
		    	}						
		    }		
		    boardCntIncrement(id);
		    return board;
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
		return board;
	}

	public static int boardListCnt(String boardName) throws NamingException
	{
		int cnt=0;
		
		PreparedStatement stmt = null;
		ResultSet rs = null;
		DataSource ds = getDataSource();
		
		try 
		{
			conn =  ds.getConnection();
			stmt = conn.prepareStatement(
					"SELECT count(*) AS total FROM board " +
					"WHERE name=?"
					);
			stmt.setString(1, boardName);
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
	
	public static int boardListCnt() throws NamingException
	{
		int cnt=0;
		
		PreparedStatement stmt = null;
		ResultSet rs = null;
		DataSource ds = getDataSource();
		
		try 
		{
			conn =  ds.getConnection();
			stmt = conn.prepareStatement(
					"SELECT count(*) AS total FROM board "
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
	public static boolean writeBoard(Board board) throws SQLException, NamingException, NoSuchAlgorithmException
	{
		int result = 0;
		
		PreparedStatement stmt = null;
		ResultSet rs = null;
		DataSource ds = getDataSource();
			
		try 
		{
			conn = ds.getConnection();
				    
			stmt = conn.prepareStatement(
					"INSERT INTO board " +
							"(name, title, content, u_id, wtime, cnt) " +
							"VALUES " +
							"(?, ?, ?, ?, NOW(), 0)" 
					);
			stmt.setString(1,  board.getName());
			stmt.setString(2,  board.getTitle());
			stmt.setString(3,  board.getContent());
			stmt.setString(4,  board.getU_id());
			
			result = stmt.executeUpdate();
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
		return (result == 1);
	}
	
	public static boolean updateBoard(Board board) throws SQLException, NamingException, NoSuchAlgorithmException
	{
		int result;
		
		PreparedStatement stmt = null;
		ResultSet rs = null;
		DataSource ds = getDataSource();
	    
		try {
			conn = ds.getConnection();

			// 질의 준비
			stmt = conn.prepareStatement(
					"UPDATE board " +
					"SET title=?, content=? " +
					"WHERE b_id=?"
					);
			stmt.setString(1,  board.getTitle());
			stmt.setString(2,  board.getContent());
			stmt.setInt(3,  board.getB_id());
			
			result = stmt.executeUpdate();
		} finally {
			// 무슨 일이 있어도 리소스를 제대로 종료
			if (rs != null) try{rs.close();} catch(SQLException e) {}
			if (stmt != null) try{stmt.close();} catch(SQLException e) {}
			if (conn != null) try{conn.close();} catch(SQLException e) {}
		}
		
		return (result == 1);		
	}
	
	public static boolean removeBoard(String b_id, String u_id) throws NamingException, SQLException {
		int result = 0;
		
		PreparedStatement stmt = null;
		ResultSet rs = null;
		DataSource ds = getDataSource();
		
		try {
			conn = ds.getConnection();

			// 질의 준비
			stmt = conn.prepareStatement("DELETE FROM board WHERE b_id=? AND u_id=?");
			stmt.setInt(1, Integer.parseInt(b_id));
			stmt.setString(2, u_id);
			
			// 수행
			result = stmt.executeUpdate();
		} finally {
			// 무슨 일이 있어도 리소스를 제대로 종료
			if (rs != null) try{rs.close();} catch(SQLException e) {}
			if (stmt != null) try{stmt.close();} catch(SQLException e) {}
			if (conn != null) try{conn.close();} catch(SQLException e) {}
		}
		
		return (result == 1);		
	}
	
	public static boolean removeBoard(String b_id) throws NamingException, SQLException {
		int result = 0;
		
		PreparedStatement stmt = null;
		ResultSet rs = null;
		DataSource ds = getDataSource();
		
		try {
			conn = ds.getConnection();

			// 질의 준비
			stmt = conn.prepareStatement("DELETE FROM board WHERE b_id=? ");
			stmt.setInt(1, Integer.parseInt(b_id));
			
			// 수행
			result = stmt.executeUpdate();
		} finally {
			// 무슨 일이 있어도 리소스를 제대로 종료
			if (rs != null) try{rs.close();} catch(SQLException e) {}
			if (stmt != null) try{stmt.close();} catch(SQLException e) {}
			if (conn != null) try{conn.close();} catch(SQLException e) {}
		}
		
		return (result == 1);		
	}
	
	public static PageResult<Board> getPage(String boardName, int page, int numItemsInPage) 
			throws SQLException, NamingException 
	{
		
		PreparedStatement stmt = null;
		ResultSet rs = null;
		DataSource ds = getDataSource();

		if (page <= 0) 
		{
			page = 1;
		}
		PageResult<Board> result = new PageResult<Board>(numItemsInPage, page);
		
		int startPos = (page - 1) * numItemsInPage;

    	try 
    	{ 
			result.setNumItems(boardListCnt(boardName));

			conn = ds.getConnection();

			// 질의 준비
			stmt = conn.prepareStatement("SELECT * FROM board as b JOIN users as u ON u.id = b.u_id WHERE b.name=? ORDER BY b.b_id DESC LIMIT " + startPos + ", " + numItemsInPage);
			stmt.setString(1, boardName);
			rs = stmt.executeQuery();	
			
			while(rs.next()) 
			{
				if(rs.getString("u.join_type").equals("site"))
				{
					result.getList().add(new Board( rs.getInt("b.b_id")
		    			,rs.getString("b.name")
		    			,rs.getString("b.u_id")
		    			,rs.getString("b.title")
		    			,rs.getString("b.content")
		    			,rs.getString("b.wtime")
		    			,rs.getInt("b.cnt")

		    			));
				}
				else
				{
					result.getList().add(new Board( rs.getInt("b.b_id")
		    			,rs.getString("b.name")
		    			,"<a href = 'https://www.facebook.com/app_scoped_user_id/"+rs.getString("b.u_id")+"'>"+rs.getString("u.name")+"</a>"
		    			,rs.getString("b.title")
		    			,rs.getString("b.content")
		    			,rs.getString("b.wtime")
		    			,rs.getInt("b.cnt")

		    			));
				}
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
	
	public static PageResult<Board> getPage(int page, int numItemsInPage) 
			throws SQLException, NamingException 
	{
		
		PreparedStatement stmt = null;
		ResultSet rs = null;
		DataSource ds = getDataSource();

		if (page <= 0) 
		{
			page = 1;
		}
		PageResult<Board> result = new PageResult<Board>(numItemsInPage, page);
		
		int startPos = (page - 1) * numItemsInPage;

    	try 
    	{ 
			result.setNumItems(boardListCnt());

			conn = ds.getConnection();

			// 질의 준비
			stmt = conn.prepareStatement("SELECT * FROM board as b JOIN users as u ON u.id = b.u_id ORDER BY b.b_id DESC LIMIT " + startPos + ", " + numItemsInPage);
			rs = stmt.executeQuery();	
			
			while(rs.next()) 
			{
				if(rs.getString("u.join_type").equals("site"))
				{
					result.getList().add(new Board( rs.getInt("b.b_id")
		    			,rs.getString("b.name")
		    			,rs.getString("b.u_id")
		    			,rs.getString("b.title")
		    			,rs.getString("b.content")
		    			,rs.getString("b.wtime")
		    			,rs.getInt("b.cnt")

		    			));
				}
				else
				{
					result.getList().add(new Board( rs.getInt("b.b_id")
		    			,rs.getString("b.name")
		    			,"<a href = 'https://www.facebook.com/app_scoped_user_id/"+rs.getString("b.u_id")+"'>"+rs.getString("u.name")+"</a>"
		    			,rs.getString("b.title")
		    			,rs.getString("b.content")
		    			,rs.getString("b.wtime")
		    			,rs.getInt("b.cnt")

		    			));
				}
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
