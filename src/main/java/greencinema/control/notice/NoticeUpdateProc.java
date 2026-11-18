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

@WebServlet("/NoticeUpdateProc.do")
public class NoticeUpdateProc extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		rePro(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		rePro(request, response);
	}
	protected void rePro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		NoticeDAO ndao = new NoticeDAO();
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		int noticeId = Integer.parseInt(request.getParameter("noticeId"));
		
		int result = ndao.NoticeUpdate(noticeId, title, content);
		
		if(result > 0) {
			request.setAttribute("msg", "수정이 완료되었습니다.");
			response.sendRedirect("OneNoticeProc.do?noticeId=" + noticeId);
		}
	}

}
