package servlet;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.NamingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.BoardDAO;
import bean.Board;
import bean.PageResult;

/**
 * Servlet implementation class User
 */
@WebServlet("/board")
public class BoardServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BoardServlet() {
        super();
    }

	private int getIntFromParameter(String str, int defaultValue) {
		int id;
		
		try {
			id = Integer.parseInt(str);
		} catch (Exception e) {
			id = defaultValue;
		}
		return id;
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mode = request.getParameter("mode");
		String actionUrl ="index.jsp";
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=utf-8");
		HttpSession session = request.getSession();
		

		if(mode.equals("list"))
		{		
			try 
			{
					String boardName = request.getParameter("boardName");
					int page = getIntFromParameter(request.getParameter("page"), 1);
					
					PageResult<Board> boards = BoardDAO.getPage(boardName, page, 10);
					request.setAttribute("boardName", boardName);
					request.setAttribute("boards", boards);
					request.setAttribute("boardListCnt", BoardDAO.boardListCnt(boardName));
					request.setAttribute("page", page);
					actionUrl = "view/"+boardName+".jsp";
			}
			catch (SQLException | NamingException e) {
				request.setAttribute("error", e.getMessage());
				e.printStackTrace();
				actionUrl = "action/error.jsp";
			}
		}
		else if(mode.equals("view"))
		{		
			int b_id = Integer.parseInt(request.getParameter("b_id"));
			try 
			{
				actionUrl = "board/board_view.jsp";
				Board b = BoardDAO.boardView(b_id);
				request.setAttribute("board", b);		
			}
			catch (NamingException | SQLException e) 
			{
				request.setAttribute("error", e.getMessage());
				e.printStackTrace();
				actionUrl = "action/error.jsp";
			}
		}
		else if(mode.equals("edit"))
		{
			int b_id = Integer.parseInt(request.getParameter("b_id"));
			try 
			{
				actionUrl = "board/board_edit.jsp";
				Board b = BoardDAO.boardView(b_id);
				request.setAttribute("board", b);		
			}
			catch (NamingException | SQLException e) 
			{
				request.setAttribute("error", e.getMessage());
				e.printStackTrace();
				actionUrl = "action/error.jsp";
			}
		}
		
		else if(mode.equals("delete"))
		{
			String u_id = (String) session.getAttribute("id");
			String b_id = request.getParameter("b_id");
			String adm = (String) session.getAttribute("adm");
			
			ArrayList<String> errorMsgs = new ArrayList<String>();
			try 
			{
				if (adm.equals("T"))
				{
					if(BoardDAO.removeBoard(b_id))
					{
						request.setAttribute("msg", " 삭제 완료");
						actionUrl = "action/success.jsp";
					}
				}
				else if (BoardDAO.removeBoard(b_id, u_id)) 
				{
					request.setAttribute("msg", " 삭제 완료");
					actionUrl = "action/success.jsp";
				}
				else
				{
					errorMsgs.add("삭제 실패");
					request.setAttribute("errorMsgs", errorMsgs);
					actionUrl = "action/error.jsp";
				}
			} 
			catch (SQLException
					| NamingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(actionUrl);
		dispatcher.forward(request,  response);
		
	}


	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Board b = null;
		String mode = request.getParameter("mode");
		String actionUrl ="index.jsp";
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=utf-8");
		HttpSession session = request.getSession();
		
		if(mode.equals("write"))
		{
			String id = (String) session.getAttribute("id");
			String title = request.getParameter("title");
			String content = request.getParameter("content");
			String boardName = request.getParameter("boardName");
			
			if(title != null) {
				title = new String(title.getBytes("8859_1"), "UTF-8");
			}
			if(content != null) {
				content = new String(content.getBytes("8859_1"), "UTF-8");
			}
			
			b = new Board(id, boardName, title, content);
			
			ArrayList<String> errorMsgs = new ArrayList<String>();
			try 
			{
				if (BoardDAO.writeBoard(b)) 
				{
					request.setAttribute("msg", " 작성 완료");
					actionUrl = "action/success.jsp";
				}
				else
				{
					errorMsgs.add("작성 실패");
					request.setAttribute("errorMsgs", errorMsgs);
					actionUrl = "action/error.jsp";
				}
			} 
			catch (SQLException
					| NamingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (NoSuchAlgorithmException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		else if(mode.equals("edit"))
		{
			int b_id = Integer.parseInt(request.getParameter("b_id"));
			String u_id = (String) session.getAttribute("id");
			String title = request.getParameter("title");
			String content = request.getParameter("content");
			String boardName = request.getParameter("boardName");
			
			if(title != null) {
				title = new String(title.getBytes("8859_1"), "UTF-8");
			}
			if(content != null) {
				content = new String(content.getBytes("8859_1"), "UTF-8");
			}
			
			b = new Board(b_id, u_id, boardName, title, content);
			
			ArrayList<String> errorMsgs = new ArrayList<String>();
			try 
			{
				if (BoardDAO.updateBoard(b))
				{
					request.setAttribute("msg", " 수정 완료");
					actionUrl = "action/success.jsp";
				}
				else
				{
					errorMsgs.add("작성 실패");
					request.setAttribute("errorMsgs", errorMsgs);
					actionUrl = "action/error.jsp";
				}
			} 
			catch (SQLException
					| NamingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (NoSuchAlgorithmException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		RequestDispatcher dispatcher = request.getRequestDispatcher(actionUrl);
		dispatcher.forward(request,  response);
	}

}
