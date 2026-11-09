package greencinema.control.inquiry;


import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
		String type ="";
		if(request.getParameter("btn") != null) {
		type = request.getParameter("btn");
		}
		
		
		
		if(type.equals("수정")) {
			
		InquiryDAO idao = new InquiryDAO();
		int inquiryId = Integer.parseInt(request.getParameter("inquiryId")) ;
		InquiryDTO idto = idao.getOneInquiry(inquiryId);
		
		request.setAttribute("idto", idto);
		RequestDispatcher rd = request.getRequestDispatcher("index.jsp?section=inquiry/OneInquiryUpdate.jsp");
		rd.forward(request, response);
		
		}else {
			
			InquiryDAO idao = new InquiryDAO();
			int inquiryId = Integer.parseInt(request.getParameter("inquiryId")) ;
			InquiryDTO idto = idao.getOneInquiry(inquiryId);
			
			request.setAttribute("idto", idto);
			RequestDispatcher rd = request.getRequestDispatcher("index.jsp?section=inquiry/OneInquiry.jsp");
			rd.forward(request, response);
			
		}
		
	}

}
