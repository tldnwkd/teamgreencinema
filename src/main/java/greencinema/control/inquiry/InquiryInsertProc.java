package greencinema.control.inquiry;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import greencinema.model.inquiry.InquiryDAO;
import greencinema.model.inquiry.InquiryDTO;

@WebServlet("/InquiryInsertProc.do")
public class InquiryInsertProc extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		rePro(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		rePro(request, response);
	}

	protected void rePro(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession(false);
		String chkid = (String) session.getAttribute("id");
		String type = request.getParameter("btn");
		String content = request.getParameter("inquiryContent");
		String title = request.getParameter("inquiryTitle");
		System.out.println(chkid);
		System.out.println("zz:" + type);
		InquiryDTO idto = new InquiryDTO();
		if (type.equals("inq")) {
			idto.setUserId(chkid);
			idto.setInquirySort(request.getParameter("inquirySort"));
			idto.setInquiryType(request.getParameter("inquiryType"));
			idto.setInquiryTitle(request.getParameter("inquiryTitle"));
			idto.setInquiryContent(request.getParameter("inquiryContent"));// �߸���
			idto.setReceptionType(Integer.parseInt(request.getParameter("receptionType")));

			InquiryDAO idao = new InquiryDAO();
			boolean result = idao.insert(idto);
			System.out.println(result);

			if (result) {
				response.sendRedirect("InquiryProc.do");
			}
		} else if (type.equals("updOk")) {
			InquiryDAO idao = new InquiryDAO();
			int inquiryId = Integer.parseInt(request.getParameter("inquiryId"));
			int result = idao.getOneUpdate(title, content, inquiryId, chkid);
			System.out.println(result);
			if (result > 0) {
				response.sendRedirect("OneInquiryProc.do?inquiryId=" + inquiryId);
			}

		}

	}
}