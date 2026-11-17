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

@WebServlet("/InquiryLoginchkProc.do")
public class InquiryLoginchkProc extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		reqPro(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		reqPro(request, response);
	}
	
	protected void reqPro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		// 세션이 없으면 새로 만들지 않고 null을 반환하도록 설정
		HttpSession session = request.getSession(false);

		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();

		if (session == null || session.getAttribute("id") == null) {
			out.println("<script>");
			out.println("alert('로그인 후 이용해주세요');");
			out.println("location.href='index.jsp?section=user/login.jsp';");
			out.println("</script>");
			out.flush();
			return; 
		}

		String chkId = (String) session.getAttribute("id");

		if (chkId.trim().isEmpty()) {
			out.println("<script>");
			out.println("alert('로그인 후 이용해주세요');");
			out.println("location.href='index.jsp?section=user/login.jsp';");
			out.println("</script>");
			out.flush();
			return;
		}
		
		RequestDispatcher rd = request.getRequestDispatcher("/index.jsp?section=inquiry/Inquiry.jsp");
		rd.forward(request, response);
	}
}