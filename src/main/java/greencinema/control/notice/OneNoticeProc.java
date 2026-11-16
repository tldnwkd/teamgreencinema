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

/**
 * Servlet implementation class OneNoticeProc
 */
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
		int notice_Id = Integer.parseInt(request.getParameter("notice_Id"));
		NoticeDAO ndao = new NoticeDAO();
		NoticeDTO nOneList= ndao.OneNotice(notice_Id);
		request.setAttribute("nOneList", nOneList);
		
		
		if("admin".equals(chkId)) {
			RequestDispatcher rd = request.getRequestDispatcher("admin/admin-index.jsp?section=Admin-One-Notice.jsp");
			rd.forward(request, response);
		}else {
			RequestDispatcher rd = request.getRequestDispatcher("index.jsp?section=notice/OneNotice.jsp");
			rd.forward(request, response);
		}
	}
	
}
