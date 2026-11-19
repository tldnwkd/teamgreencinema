package greencinema.control.inquiry;


import java.io.IOException;
import java.io.PrintWriter;

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
		
		
		if("admin".equals(chkId)) {
			
			
			InquiryDTO idto = idao.AdmingetOneInquiry(inquiryId);
			
			request.setAttribute("idto", idto);
			RequestDispatcher rd = request.getRequestDispatcher("/admin/admin-index.jsp?section=Admin-Inquiry-Insert.jsp");
			rd.forward(request, response);
			
		}else {
		
				
		if(type.equals("upd")) {
		InquiryDTO idto = idao.getOneInquiry(inquiryId, chkId);
		
		request.setAttribute("idto", idto);
		RequestDispatcher rd = request.getRequestDispatcher("index.jsp?section=cs/cs-index.jsp&csSection=inquiry&csView=edit");
		rd.forward(request, response);
		
		}else {
			
			InquiryDTO idto = idao.getOneInquiry(inquiryId,chkId);
			
			request.setAttribute("idto", idto);
			RequestDispatcher rd = request.getRequestDispatcher("index.jsp?section=cs/cs-index.jsp&csSection=inquiry&csView=detail");
			rd.forward(request, response);
			
			}
		}
		
	}
	
	private void alert(HttpServletResponse response, String msg, String location) throws IOException {
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.println("<script>");
		out.println("alert('" + msg + "');");
		if (location == null) {
			out.println("history.back();");
		} else {
			out.println("location.href='" + location + "';");
		}
		out.println("</script>");
	}

}