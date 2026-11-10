package greencinema.control.user;

import java.io.IOException;
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

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		String userId = session == null ? null : (String) session.getAttribute("id");
		if (userId == null || userId.isEmpty()) {
			response.sendRedirect("index.jsp?section=user/login.jsp");
			return;
		}
		response.sendRedirect(infoUrl(request, null));
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");

		HttpSession session = request.getSession(false);
		String userId = session == null ? null : (String) session.getAttribute("id");
		if (userId == null || userId.isEmpty()) {
			response.sendRedirect("index.jsp?section=user/login.jsp");
			return;
		}

		String currentPw = request.getParameter("currentPw");
		String userPw = request.getParameter("userPw");
		String userPwChk = request.getParameter("userPwChk");

		if (isBlank(currentPw) || isBlank(userPw) || isBlank(userPwChk)
				|| userPw.length() > 15 || userPwChk.length() > 15) {
			response.sendRedirect(infoUrl(request, "pwError=empty"));
			return;
		}

		if (!userPw.equals(userPwChk)) {
			response.sendRedirect(infoUrl(request, "pwError=mismatch"));
			return;
		}

		UserDAO udao = new UserDAO();
		if (!udao.loginCheck(userId, currentPw)) {
			response.sendRedirect(infoUrl(request, "pwError=current"));
			return;
		}

		if (!udao.updatePassword(userId, userPw)) {
			response.sendRedirect(infoUrl(request, "pwError=fail"));
			return;
		}

		response.sendRedirect(infoUrl(request, "pwChanged=1"));
	}

	private String infoUrl(HttpServletRequest request, String result) {
		HttpSession session = request.getSession(false);
		String userId = session == null ? "" : (String) session.getAttribute("id");
		if (userId == null) {
			userId = "";
		}
		String url = "MyPageProc.do?userId=" + URLEncoder.encode(userId, StandardCharsets.UTF_8) + "&menu=info";
		if (result != null && !result.isEmpty()) {
			url += "&" + result;
		}
		return url;
	}

	private boolean isBlank(String value) {
		return value == null || value.trim().isEmpty();
	}
}
