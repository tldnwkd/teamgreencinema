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

@WebServlet("/MyInquiryOneProc.do")
public class MyInquiryOneProc extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		reqPro(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		reqPro(request, response);
	}

	// true면 이 메서드에서 이미 응답을 끝냈다.
	public boolean reqPro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession(false);
		String chkid = null;
		if(session != null) {
			chkid = (String)session.getAttribute("id");
		}
		if(chkid == null || chkid.equals("")) {
			alert(response, "로그인 후 이용해주세요", "index.jsp?section=user/login.jsp");
			return true;
		}

		String inquiryIdText = request.getParameter("inquiryId");
		int inquiryId = 0;
		try {
			inquiryId = Integer.parseInt(inquiryIdText);
		} catch (Exception e) {
			response.sendRedirect("MyPageProc.do?userId=" + chkid + "&menu=inquiry");
			return true;
		}

		InquiryDAO idao = new InquiryDAO();
		String btn = request.getParameter("btn");
		if(btn == null) {
			btn = "";
		}

		if(btn.equals("mydel")) {
			int result = idao.OneDelete(inquiryId, chkid);
			if(result > 0) {
				alert(response, "삭제되었습니다.", "MyPageProc.do?userId=" + chkid + "&menu=inquiry");
			}else {
				alert(response, "삭제에 실패했습니다.", "MyPageProc.do?userId=" + chkid + "&menu=inquiry");
			}
			return true;
		}

		if(btn.equals("myupdOk")) {
			String title = request.getParameter("inquiryTitle");
			String content = request.getParameter("inquiryContent");
			if(title == null) title = "";
			if(content == null) content = "";
			title = title.trim();
			content = content.trim();
			if(title.equals("")) {
				alert(response, "제목을 선택해주세요", null);
				return true;
			}
			if(title.length() > 30) {
				alert(response, "제목은 30자 이내로 입력해주세요", null);
				return true;
			}
			if(content.equals("")) {
				alert(response, "내용을 선택해주세요", null);
				return true;
			}
			InquiryDTO saved = idao.getOneInquiry(inquiryId, chkid);
			if(saved == null || saved.getAnswerStatus() == 1) {
				alert(response, "답변이 등록된 문의는 수정할 수 없습니다.", "MyPageProc.do?userId=" + chkid + "&menu=inquiry-one&inquiryId=" + inquiryId);
				return true;
			}
			int result = idao.getOneUpdate(title, content, inquiryId, chkid);
			if(result > 0) {
				alert(response, "수정이 완료되었습니다.", "MyPageProc.do?userId=" + chkid + "&menu=inquiry-one&inquiryId=" + inquiryId);
			}else {
				alert(response, "수정에 실패했습니다.", null);
			}
			return true;
		}

		InquiryDTO idto = idao.getOneInquiry(inquiryId, chkid);
		if(idto == null) {
			response.sendRedirect("MyPageProc.do?userId=" + chkid + "&menu=inquiry");
			return true;
		}
		request.setAttribute("idto", idto);
		if("inquiry-edit".equals(request.getParameter("menu")) && idto.getAnswerStatus() == 1) {
			request.setAttribute("mypageMenu", "inquiry-one");
		}
		return false;
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
