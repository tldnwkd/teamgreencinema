package greencinema.control.faq;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import greencinema.model.faq.FaqDAO;
import greencinema.model.notice.NoticeDAO;

@WebServlet("/FaqUpdateProc.do")
public class FaqUpdateProc extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		rePro(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		rePro(request, response);
	}
	protected void rePro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		FaqDAO fdao = new FaqDAO();
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		int faqId = Integer.parseInt(request.getParameter("faq_id"));
		int faqType = Integer.parseInt(request.getParameter("type"));

		int result = fdao.FaqUpdate(faqId, faqType, title, content);

		if(result > 0) {
			request.setAttribute("msg", "수정이 완료되었습니다.");
			response.sendRedirect("OneFaqProc.do?faq_id=" + faqId);
		}
	}

}
