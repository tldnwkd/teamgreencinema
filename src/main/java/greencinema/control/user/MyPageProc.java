package greencinema.control.user;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import greencinema.model.reserve.ReserveDTO;
import greencinema.model.user.UserDAO;

/**
 * Servlet implementation class MyPageProc
 */
@WebServlet("/MyPageProc.do")
public class MyPageProc extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		reqPro(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		reqPro(request, response);
	}
	
	protected void reqPro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		String userId = request.getParameter("userId");
		
		UserDAO udao = new UserDAO();
		// 예매내역 정보가져오기
		ArrayList<ReserveDTO> rList = udao.getReserveList(userId);	
		
		
		// 1:1문의 내역 정보가져오기
		
		
		
		
	}

}
