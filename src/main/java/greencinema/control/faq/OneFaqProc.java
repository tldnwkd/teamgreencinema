package greencinema.control.faq;

import java.io.IOException;
import java.io.PrintWriter;

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
		String btn = request.getParameter("btn");
		System.out.println("btn value : " + btn);
		if("admin".equals(chkId) && "update".equals(btn)) {
			String typeText = request.getParameter("faqType");
			String title = request.getParameter("faqTitle");
			String content = request.getParameter("faqContent");
			if(title == null) title = "";
			if(content == null) content = "";
			title = title.trim();
			content = content.trim();
			int type = 0;
			try {
				type = Integer.parseInt(typeText);
			} catch (Exception e) {
				type = 0;
			}
			response.setContentType("text/html; charset=UTF-8");
			java.io.PrintWriter out = response.getWriter();
			if(!(type >= 1 && type <= 5) || title.equals("") || content.equals("")) {
				out.println("<script>");
				out.println("alert('종류, 제목, 내용을 입력해주세요.');");
				out.println("history.back();");
				out.println("</script>");
				return;
			}
			int result = fdao.FaqUpdate(faqId, type, title, content);
			out.println("<script>");
			if(result > 0) {
				out.println("alert('FAQ 수정이 완료되었습니다.');");
				out.println("location.href='FaqProc.do'");
			}else {
				out.println("alert('FAQ 수정에 실패했습니다.');");
				out.println("history.back();");
			}
			out.println("</script>");
			return;
		}
		FaqDTO fOneList= fdao.OneFaq(faqId);
		request.setAttribute("fOneList", fOneList);
		
		if("admin".equals(chkId)) {
			System.out.println("chkId=?"+chkId);

			String type = request.getParameter("btn");
			System.out.println("type02=?"+type);
			
			if("upd".equals(type)) {
				RequestDispatcher rd = request.getRequestDispatcher("admin/admin-index.jsp?section=Admin-One-Faq-Update.jsp");
				rd.forward(request, response);
				}
			if("del".equals(type)) {
				int result = fdao.FaqDelete(faqId);
				if(result > 0) {
					alert(response, "삭제가 완료되었습니다", "FaqProc.do");
				}
			}
			else {
					RequestDispatcher rd = request.getRequestDispatcher("admin/admin-index.jsp?section=Admin-One-Faq.jsp");
					rd.forward(request, response);
			}}else {
			RequestDispatcher rd = request.getRequestDispatcher("index.jsp?section=cs/cs-index.jsp&csSection=faq&csView=detail");
			rd.forward(request, response);
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
