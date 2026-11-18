package greencinema.control.inquiry;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import greencinema.model.inquiry.InquiryDAO;
import greencinema.model.inquiry.InquiryDTO;

@WebServlet("/MyInquiryInsertProc.do")
public class MyInquiryInsertProc extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		reqPro(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		reqPro(request, response);
	}

	public void reqPro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession(false);
		String chkid = null;
		if(session != null) {
			chkid = (String)session.getAttribute("id");
		}
		if(chkid == null || chkid.equals("")) {
			alert(response, "로그인 후 이용해주세요", "index.jsp?section=user/login.jsp");
			return;
		}

		String inquirySort = request.getParameter("inquirySort");
		String inquiryType = request.getParameter("inquiryType");
		String inquiryTitle = request.getParameter("inquiryTitle");
		String inquiryContent = request.getParameter("inquiryContent");
		String receptionType = request.getParameter("receptionType");

		if(inquirySort == null) inquirySort = "";
		if(inquiryType == null) inquiryType = "";
		if(inquiryTitle == null) inquiryTitle = "";
		if(inquiryContent == null) inquiryContent = "";
		if(receptionType == null) receptionType = "";
		inquirySort = inquirySort.trim();
		inquiryType = inquiryType.trim();
		inquiryTitle = inquiryTitle.trim();
		inquiryContent = inquiryContent.trim();

		if(inquirySort.equals("") || inquirySort.equals("선택")) {
			alert(response, "문의 분류를 입력해주세요", null);
			return;
		}
		if(inquiryType.equals("") || inquiryType.equals("선택")) {
			alert(response, "문의 종류를 입력해주세요", null);
			return;
		}
		if(inquiryTitle.equals("")) {
			alert(response, "제목을 선택해주세요", null);
			return;
		}
		if(inquiryTitle.length() > 30) {
			alert(response, "제목은 30자 이내로 입력해주세요", null);
			return;
		}
		if(inquiryContent.equals("")) {
			alert(response, "내용을 선택해주세요", null);
			return;
		}
		if(!(receptionType.equals("1") || receptionType.equals("2"))) {
			alert(response, "수신 방법을 선택해주세요", null);
			return;
		}

		InquiryDTO idto = new InquiryDTO();
		idto.setUserId(chkid);
		idto.setInquirySort(inquirySort);
		idto.setInquiryType(inquiryType);
		idto.setInquiryTitle(inquiryTitle);
		idto.setInquiryContent(inquiryContent);
		idto.setReceptionType(Integer.parseInt(receptionType));

		InquiryDAO idao = new InquiryDAO();
		boolean result = idao.insert(idto);
		if(result) {
			alert(response, "등록이 완료되었습니다.", "MyPageProc.do?userId=" + chkid + "&menu=inquiry");
		}else {
			alert(response, "문의 등록에 실패했습니다.", null);
		}
	}

	private void alert(HttpServletResponse response, String msg, String location) throws IOException {
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.println("<script>");
		out.println("alert('" + msg + "');");
		if(location == null) {
			out.println("history.back();");
		}else {
			out.println("location.href='" + location + "';");
		}
		out.println("</script>");
	}

}
