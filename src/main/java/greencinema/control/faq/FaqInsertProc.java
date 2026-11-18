package greencinema.control.faq;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import greencinema.model.faq.FaqDAO;


@WebServlet("/FaqInsertProc.do")
public class FaqInsertProc extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		rePro(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		rePro(request, response);
	}
	protected void rePro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		int type =  Integer.parseInt(request.getParameter("faqType"));
		String inq = (String)request.getParameter("faqTitle"); 
		String content = (String)request.getParameter("faqContent"); 
		
		FaqDAO fdao = new FaqDAO();
		
		int result = fdao.FaqInsert(type, inq, content);
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		if(result > 0) {
			out.println("<script>");
			out.println("alert('FAQ 등록이 완료되었습니다.')");
			out.println("location.href='FaqProc.do';");
			out.println("</script>");
		}else {
			out.println("<script>");
			out.println("alert('FAQ 등록에 실패했습니다.')");
			out.println("history.go(-1)");
			out.println("</script>");
			
			
		}
		
	}





}
