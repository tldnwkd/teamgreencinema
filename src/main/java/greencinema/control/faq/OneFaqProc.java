package greencinema.control.faq;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import greencinema.model.faq.FaqDAO;
import greencinema.model.faq.FaqDTO;

@WebServlet("/OneFaqProc.do")
public class OneFaqProc extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		rePro(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		rePro(request, response);
	}

	protected void rePro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		String chkId = (String)session.getAttribute("id");
		int faqId = Integer.parseInt(request.getParameter("faq_id"));
		FaqDAO fdao = new FaqDAO();
		FaqDTO fOneList= fdao.OneFaq(faqId);
		request.setAttribute("fOneList", fOneList);
		
		if("admin".equals(chkId)) {
			
			String type = request.getParameter("type");
			
			if("upd".equals(type)) {
				
				RequestDispatcher rd = request.getRequestDispatcher("admin/admin-index.jsp?section=Admin-One-Faq-Update.jsp");
				rd.forward(request, response);
				}else {
					RequestDispatcher rd = request.getRequestDispatcher("admin/admin-index.jsp?section=Admin-One-Faq.jsp");
					rd.forward(request, response);
			}}else {
			RequestDispatcher rd = request.getRequestDispatcher("index.jsp?section=faq/OneFaq.jsp");
			rd.forward(request, response);
		}
	}
	
}
