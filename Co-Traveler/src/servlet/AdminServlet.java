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
import dao.TripDAO;
import dao.UserDAO;
import bean.Board;
import bean.PageResult;
import bean.Trip;
import bean.User;

/**
 * Servlet implementation class User
 */
@WebServlet("/admin")

public class AdminServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminServlet() {
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
		if(mode.equals("list"))
		{		
			try 
			{
					int userPage = getIntFromParameter(request.getParameter("upage"), 1);
					
					PageResult<User> users = UserDAO.getPage(userPage, 10);
					request.setAttribute("users", users);
					request.setAttribute("userListCnt", UserDAO.userListCnt());
					request.setAttribute("upage", userPage);
					
					int boardPage = getIntFromParameter(request.getParameter("bpage"), 1);
					PageResult<Board> boards = BoardDAO.getPage(boardPage, 10);
					request.setAttribute("boards", boards);
					request.setAttribute("boardListCnt", BoardDAO.boardListCnt());
					request.setAttribute("bpage", boardPage);
					
					int tripPage = getIntFromParameter(request.getParameter("tpage"), 1);
					PageResult<Trip> trips = TripDAO.getPage(tripPage, 10);
					request.setAttribute("trips", trips);
					request.setAttribute("tripListCnt", TripDAO.tripListCnt());
					request.setAttribute("tpage", tripPage);
					actionUrl = "view/admin.jsp";
			}
			catch (SQLException | NamingException e) {
				request.setAttribute("error", e.getMessage());
				e.printStackTrace();
				actionUrl = "action/error.jsp";
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
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(actionUrl);
		dispatcher.forward(request,  response);
	}

}
