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
		HttpSession session = request.getSession();
		String chkId = (String) session.getAttribute("id");
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		if (!"admin".equals(chkId)) {
			out.println("<script>");
			out.println("alert('관리자만 등록할 수 있습니다.');");
			out.println("history.back();");
			out.println("</script>");
			return;
		}

		String title = request.getParameter("Noticetitle");
		String content = request.getParameter("NoticeContent");
		if (title == null) title = "";
		if (content == null) content = "";
		title = title.trim();
		content = content.trim();
		if (title.equals("") || title.length() > 30 || content.equals("")) {
			out.println("<script>");
			out.println("alert('제목은 30자 이내, 내용은 비우지 말고 입력해주세요.');");
			out.println("history.back();");
			out.println("</script>");
			return;
		}

		NoticeDAO ndao = new NoticeDAO();
		int result = ndao.NoticeInsert(title, content);
		if (result > 0) {
			out.println("<script>");
			out.println("alert('공지 등록이 완료되었습니다.');");
			out.println("location.href='NoticeProc.do';");
			out.println("</script>");
		} else {
			out.println("<script>");
			out.println("alert('공지 등록에 실패했습니다.');");
			out.println("history.go(-1);");
			out.println("</script>");
		}
	}
}
