package greencinema.control.user;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import greencinema.model.user.UserDAO;

@WebServlet("/UserDeleteProc.do")
public class UserDeleteProc extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		reqPro(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		reqPro(request, response);
	}
	
	protected void reqPro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");		
		
		String userId = request.getParameter("userId");
		String userPw = request.getParameter("userPw");
		
		UserDAO udao = new UserDAO();
		
		int result = udao.deleteUser(userId, userPw);
		
		if(result == 1) {
			HttpSession session = request.getSession(false);			
			session.setAttribute("id", "");			
			response.sendRedirect("index.jsp?section=user/user-delete.jsp");
			return;
		} else {
			response.sendRedirect("index.jsp?section=user/delete-error.jsp");
			return;
		}
				
	}

}
