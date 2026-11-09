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


@WebServlet("/InquiryInsertProc.do")
public class InquiryInsertProc extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		rePro(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	rePro(request, response);
	}
	protected void rePro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession(false);
			String chkid = (String) session.getAttribute("id");
			System.out.println(chkid);
			String type = (String)request.getParameter("btn");
		System.out.println("zz:"+type);
		InquiryDTO idto = new InquiryDTO();
		if(type.equals("문의")) {
		idto.setUserId(chkid);
		idto.setInquirySort(request.getParameter("inquirySort"));
		idto.setInquiryType(request.getParameter("inquiryType"));
		idto.setInquiryTitle(request.getParameter("inquiryTitle"));
		idto.setInquiryContent(request.getParameter("inquiryContent"));//잘못됨
		idto.setReceptionType(Integer.parseInt(request.getParameter("receptionType")));

		InquiryDAO idao = new InquiryDAO();
		boolean result =  idao.insert(idto);
		 System.out.println(result);

		 RequestDispatcher rd = request.getRequestDispatcher("InquiryProc.do");
		 rd.forward(request, response);
		}else if(type.equals("수정")) {

		}


	
	}
}
