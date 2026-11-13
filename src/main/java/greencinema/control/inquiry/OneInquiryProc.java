package greencinema.control.inquiry;


import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import greencinema.model.inquiry.InquiryDAO;
import greencinema.model.inquiry.InquiryDTO;



@WebServlet("/OneInquiryProc.do")
public class OneInquiryProc extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		rePro(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		rePro(request, response);
	}
	protected void rePro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession(false);
		String chkId = (String)session.getAttribute("id");
		String type ="";
		int inquiryId = Integer.parseInt(request.getParameter("inquiryId")) ;
		InquiryDAO idao = new InquiryDAO();
		if(request.getParameter("btn") != null) {
		type = request.getParameter("btn");
		System.out.println("type"+type);
		}
		
		
		if(type.equals("del")) {
			int result = idao.OneDelete(inquiryId, chkId);
			if(result > 0) {
					response.sendRedirect("InquiryProc.do");
					return;
			}
		}
		
		
		
		if(type.equals("upd")) {
		InquiryDTO idto = idao.getOneInquiry(inquiryId, chkId);
		
		request.setAttribute("idto", idto);
		RequestDispatcher rd = request.getRequestDispatcher("index.jsp?section=inquiry/OneInquiryUpdate.jsp");
		rd.forward(request, response);
		
		}else {
			
			InquiryDTO idto = idao.getOneInquiry(inquiryId,chkId);
			
			request.setAttribute("idto", idto);
			RequestDispatcher rd = request.getRequestDispatcher("index.jsp?section=inquiry/OneInquiry.jsp");
			rd.forward(request, response);
			
		}
		
	}

}