package greencinema.control.notice;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import greencinema.model.faq.FaqDAO;
import greencinema.model.notice.NoticeDAO;

@WebServlet("/NoticeInsertProc.do")
public class NoticeInsertProc extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		rePro(request, response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		rePro(request, response);
	}
	protected void rePro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String title = (String)request.getParameter("Noticetitle"); 
		String content = (String)request.getParameter("NoticeContent"); 
		
		NoticeDAO ndao = new NoticeDAO();
		
		int result = ndao.NoticeInsert(title, content);
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		if(result > 0) {
			out.println("<script>");
			out.println("alert('공지사항 등록이 완료되었습니다.')");
			out.println("location.href='NoticeProc.do';");
			out.println("</script>");
		}else {
			out.println("<script>");
			out.println("alert('공지사항 등록에 실패했습니다.')");
			out.println("history.go(-1)");
			out.println("</script>");
			
			
		}
		
		
		
	}
		
	}

