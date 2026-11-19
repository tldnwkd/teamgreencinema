package greencinema.control.notice;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import greencinema.model.notice.NoticeDAO;

@WebServlet("/NoticeDeleteProc.do")
public class NoticeDeleteProc extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		rePro(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		rePro(request, response);
	}

	protected void rePro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		String chkId = (String) session.getAttribute("id");
		int noticeId = Integer.parseInt(request.getParameter("noticeId")); 

		NoticeDAO ndao = new NoticeDAO();

		if ("admin".equals(chkId)) {
			int result = ndao.deleteNotice(noticeId);
			
			if(result ==1) {
				alert(response, "삭제 처리가 완료되었습니다.", "NoticeProc.do");
				return;
			}else {
				 response.setContentType("text/html; charset=UTF-8");
				 PrintWriter out = response.getWriter();
				 out.println("<script>");
				 out.println("alert('삭제 실패');");
				 out.println("location.href='NoticeDeleteProc.do?noticeId='"+noticeId+"';");
				 out.println("</script>");
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