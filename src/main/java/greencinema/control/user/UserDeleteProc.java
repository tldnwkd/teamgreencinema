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
		HttpSession session = request.getSession(false);
		String userId = sessionId(session);
		if (userId == null) {
			response.sendRedirect("index.jsp?section=user/login.jsp");
			return;
		}
		response.sendRedirect("MyPageProc.do?userId=" + userId + "&menu=delete");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");

		HttpSession session = request.getSession(false);
		String userId = sessionId(session);
		if (userId == null) {
			response.sendRedirect("index.jsp?section=user/login.jsp");
			return;
		}

		String userPw = request.getParameter("userPw");
		if (userPw == null || userPw.isEmpty()) {
			response.sendRedirect("index.jsp?section=user/delete-error.jsp");
			return;
		}

		UserDAO udao = new UserDAO();
		int result = udao.deleteUser(userId, userPw);

		if (result == 1) {
			session.invalidate();
			response.sendRedirect("index.jsp?section=user/user-delete.jsp");
			return;
		}

		response.sendRedirect("index.jsp?section=user/delete-error.jsp");
	}

	private String sessionId(HttpSession session) {
		if (session == null) {
			return null;
		}
		Object id = session.getAttribute("id");
		if (!(id instanceof String) || ((String) id).isEmpty()) {
			return null;
		}
		return (String) id;
	}
}
