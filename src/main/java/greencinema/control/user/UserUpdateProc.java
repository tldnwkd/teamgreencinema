package greencinema.control.user;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import greencinema.model.user.UserDAO;
import greencinema.model.user.UserDTO;

@WebServlet("/UserUpdateProc.do")
public class UserUpdateProc extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		reqPro(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		reqPro(request, response);
	}
	
	protected void reqPro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		HttpSession session = request.getSession(false);
		String id = (String) session.getAttribute("id");
		
		String userName = request.getParameter("userName");
		String userBirth = request.getParameter("userBirth");
		String userEmail = request.getParameter("userEmail");
		String userPhone = request.getParameter("userPhone");
		
		System.out.println("id : " + id);
				
		if(userName != null || userBirth != null || userPhone != null) {
			UserDTO udto = new UserDTO();
			UserDAO udao = new UserDAO();
			udto.setUserName(userName);
			udto.setUserBirth(userBirth);
			udto.setUserEmail(userEmail);
			udto.setUserPhone(userPhone);
			udao.updateUser(udto, id);
			// todo 성공 alert처리 
			response.sendRedirect("MyPageProc.do?userId="+ id + "&amp;menu=info");
		} else {
			response.sendRedirect("MyPageProc.do?userId="+ id + "&amp;menu=info");
		}		
		
	}

}