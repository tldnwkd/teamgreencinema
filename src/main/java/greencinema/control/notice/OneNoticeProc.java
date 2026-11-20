package greencinema.control.notice;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import greencinema.model.notice.NoticeDAO;
import greencinema.model.notice.NoticeDTO;


@WebServlet("/OneNoticeProc.do")
public class OneNoticeProc extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		rePro(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		rePro(request, response);
	}
	protected void rePro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		String chkId = (String)session.getAttribute("id");
		String noticeParam = request.getParameter("noticeId");
		if(noticeParam == null || noticeParam.trim().isEmpty()) {
			noticeParam = request.getParameter("notice_Id");
		}
		int noticeId = Integer.parseInt(noticeParam);
		NoticeDAO ndao = new NoticeDAO();
		String btn = request.getParameter("btn");
		if("admin".equals(chkId) && "upd".equals(btn)) {
			String title = request.getParameter("noticeTitle");
			String content = request.getParameter("noticeText");
			if(title == null) title = "";
			if(content == null) content = "";
			title = title.trim();
			content = content.trim();
			response.setContentType("text/html; charset=UTF-8");
			java.io.PrintWriter out = response.getWriter();
			if(title.equals("") || title.length() > 30 || content.equals("")) {
				out.println("<script>");
				out.println("alert('제목은 30자 이내, 내용은 비우지 말고 입력해주세요.');");
				out.println("history.back();");
				out.println("</script>");
				return;
			}
			int result = ndao.NoticeUpdate(noticeId, title, content);
			out.println("<script>");
			if(result > 0) {
				out.println("alert('공지 수정이 완료되었습니다.');");
				out.println("location.href='NoticeProc.do';");
			}else {
				out.println("alert('공지 수정에 실패했습니다.');");
				out.println("history.back();");
			}
			out.println("</script>");
			return;
		}
		NoticeDTO nOneList= ndao.OneNotice(noticeId);
		request.setAttribute("nOneList", nOneList);
		
		
		if("admin".equals(chkId)) {
			RequestDispatcher rd = request.getRequestDispatcher("admin/admin-index.jsp?section=Admin-One-Notice.jsp");
			rd.forward(request, response);
		}else {
			RequestDispatcher rd = request.getRequestDispatcher("index.jsp?section=cs/cs-index.jsp&csSection=notice&csView=detail");
			rd.forward(request, response);
		}
	}
	
}