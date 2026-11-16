package greencinema.control.user;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import greencinema.model.user.UserDAO;

@WebServlet("/UserPwUpdateProc.do")
public class UserPwUpdateProc extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		reqPro(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		reqPro(request, response);
	}

	protected void reqPro(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession(false);
		String userId = session == null ? null : (String) session.getAttribute("id");
		if (userId == null || userId.isEmpty()) {
			response.sendRedirect("index.jsp?section=user/login.jsp");
			return;
		}

		String currentPw = request.getParameter("currentPw");
		String userPw = request.getParameter("userPw");
		String userPwChk = request.getParameter("userPwChk");

		if ((currentPw == null || currentPw.isEmpty()) || (userPw == null || userPw.isEmpty())
				|| (userPwChk == null || userPwChk.isEmpty()) || userPw.length() > 15 || userPwChk.length() > 15) {
			response.sendRedirect("index.jsp?section=user/my-page-err.jsp");
			return;
		}

		if (!userPw.equals(userPwChk)) {
			response.sendRedirect("index.jsp?section=user/my-page-err.jsp");
			return;
		}

		UserDAO udao = new UserDAO();
		if (!udao.loginCheck(userId, currentPw)) {
			response.sendRedirect("index.jsp?section=user/my-page-err.jsp");
			return;
		}

		if (!udao.updatePassword(userId, userPw)) {
			response.sendRedirect("index.jsp?section=user/my-page-err.jsp");
			return;
		}

		response.sendRedirect("MyPageProc.do?userId=" + userId);
	}

}
