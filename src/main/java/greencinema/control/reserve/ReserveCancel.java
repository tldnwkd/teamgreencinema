package greencinema.control.reserve;

import java.io.IOException;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import greencinema.model.reserve.ReserveDAO;

@WebServlet("/ReserveCancel.do")
public class ReserveCancel extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		reqPro(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		reqPro(request, response);
	}
	
	protected void reqPro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		String reserveId = request.getParameter("reserveId");		
		
		HttpSession session = request.getSession(false);
		
		String userId = (String) session.getAttribute("id"); 
		
		System.out.println("userId : " + userId);
		System.out.println("reserveId : " + reserveId);
		
		ReserveDAO rdao = new ReserveDAO();
		
		rdao.cancelReserve(reserveId);
		
		response.sendRedirect("MyPageProc.do?userId=" + userId + "&cancelled=1");
		return;
	}
	
	
}
