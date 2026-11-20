package greencinema.control.user;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import greencinema.model.inquiry.InquiryDTO;
import greencinema.model.reserve.ReserveDTO;
import greencinema.model.user.MyPageDTO;
import greencinema.model.user.UserDAO;
import greencinema.model.user.UserDTO;

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

		// 마이페이지 문의 작성
		if("myinq".equals(request.getParameter("btn"))) {
			new greencinema.control.inquiry.MyInquiryInsertProc().reqPro(request, response);
			return;
		}

		// 마이페이지 문의 상세, 수정, 삭제
		String inquiryMenu = request.getParameter("menu");
		String inquiryBtn = request.getParameter("btn");
		if("inquiry-one".equals(inquiryMenu) || "inquiry-edit".equals(inquiryMenu)
				|| "mydel".equals(inquiryBtn) || "myupdOk".equals(inquiryBtn)) {
			if(new greencinema.control.inquiry.MyInquiryOneProc().reqPro(request, response)) {
				return;
			}
		}
		
		HttpSession session = request.getSession(false);
		String userId = (String)session.getAttribute("id");
		
		UserDAO udao = new UserDAO();
		
		UserDTO userDto = udao.getUser(userId);		
		ArrayList<MyPageDTO> mydto = udao.getMyPage(userId);				
		
				
		// 예매내역 정보가져오기
		ArrayList<ReserveDTO> reserveList = udao.getReserveList(userId);
		
				
		// 1:1문의 내역 정보가져오기
		ArrayList<InquiryDTO> inquiryList = udao.getInquiryList(userId);
		
		InquiryDTO inquiry = udao.getInquiry(userId);
				
		request.setAttribute("reserveList", reserveList);
		
		request.setAttribute("inquiryList", inquiryList);
		request.setAttribute("inquiry", inquiry);
		request.setAttribute("mypage", mydto);
		request.setAttribute("userInfo", userDto);
		
		RequestDispatcher rd = request.getRequestDispatcher("/index.jsp?section=user/my-page-index.jsp");
		
		rd.forward(request, response);
		
	}

}
