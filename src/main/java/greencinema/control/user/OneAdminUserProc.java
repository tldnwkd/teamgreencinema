package greencinema.control.user;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import greencinema.model.user.UserDAO;
import greencinema.model.user.UserDTO;

@WebServlet("/OneAdminUserProc.do")
public class OneAdminUserProc extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		reqPro(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		reqPro(request, response);
	}

	protected void reqPro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		String chkid = (String)session.getAttribute("id");
		if(!"admin".equals(chkid)) {
			response.sendRedirect("index.jsp");
			return;
		}

		String userId = request.getParameter("user_Id");
		if(userId == null || userId.equals("")) {
			response.sendRedirect("UserProc.do");
			return;
		}

		UserDAO udao = new UserDAO();
		UserDTO udto = udao.getUser(userId);
		if(udto.getUserId() == null) {
			response.sendRedirect("UserProc.do");
			return;
		}
		if(udto.getUserBirth() != null && udto.getUserBirth().length() >= 10) {
			udto.setUserBirth(udto.getUserBirth().substring(0, 10));
		}

		request.setAttribute("udto", udto);
		RequestDispatcher rd = request.getRequestDispatcher("admin/admin-index.jsp?section=admin-user-form.jsp");
		rd.forward(request, response);
	}

}
