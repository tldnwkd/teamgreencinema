package greencinema.control.user;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import greencinema.model.user.UserDAO;
import greencinema.model.user.UserDTO;

@WebServlet("/UserProc.do")
public class UserProc extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		reqPro(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		reqPro(request, response);
	}

	protected void reqPro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String btn = request.getParameter("btn");
		String menu = request.getParameter("menu");

		if(btn != null || "write".equals(menu)) {
			writePro(request, response);
			return;
		}
		if(request.getParameter("user_Id") != null) {
			onePro(request, response);
			return;
		}
		String type = request.getParameter("type");
		if(type != null && !type.equals("")) {
			searchPro(request, response, type);
			return;
		}
		listPro(request, response);
	}

	private void listPro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String chkid = (String)session.getAttribute("id");

		int count = 0; // 전체 회원 수
		int pagesize = 10; // 한 화면에 그릴 페이지 수
		String pageNum = request.getParameter("pageNum");//화면에서 넘겨받을 pageNum값
		if(pageNum == null || pageNum.equals("")) { // 페이지 선택 안했을 경우 자동으로 1번 페이지 선택
			pageNum = "1";
		}

		int number = 0;
		int curretnPage = Integer.parseInt(pageNum); // 현재 페이지 위치

		UserDAO udao = new UserDAO();
		count = udao.userAllCount(); // 페이지 전체수 입력
		int StartRow = (curretnPage-1)*pagesize;//한 페이지에 출력할 개수

		ArrayList<UserDTO> uList = new ArrayList<UserDTO>();
		uList = udao.userAllList(StartRow, pagesize);

		number = count-StartRow; //페이지당 게시글 출력 번호
		setPage(request, count, pagesize, curretnPage, StartRow, number);
		request.setAttribute("uList", uList);

		if("admin".equals(chkid)) {
			RequestDispatcher rd = request.getRequestDispatcher("admin/admin-index.jsp?section=admin-user.jsp");
			rd.forward(request, response);
		}else {
			RequestDispatcher rd = request.getRequestDispatcher("/index.jsp");
			rd.forward(request, response);
		}
	}

	private void searchPro(HttpServletRequest request, HttpServletResponse response, String type) throws ServletException, IOException {
		String content = request.getParameter("content");
		if(content == null) {
			content = "";
		}
		if(!(type.equals("user_id") || type.equals("user_name") || type.equals("user_phone"))) {
			response.sendRedirect("UserProc.do");
			return;
		}

		int count = 0; // 전체 회원 수
		int pagesize = 10; // 한 화면에 그릴 페이지 수
		String pageNum = request.getParameter("pageNum");//화면에서 넘겨받을 pageNum값
		if(pageNum == null || pageNum.equals("")) { // 페이지 선택 안했을 경우 자동으로 1번 페이지 선택
			pageNum = "1";
		}

		int number = 0;
		int curretnPage = Integer.parseInt(pageNum); // 현재 페이지 위치

		UserDAO udao = new UserDAO();
		int StartRow = (curretnPage-1)*pagesize;//한 페이지에 출력할 개수
		count = udao.uCount(type, content); // 페이지 전체수 입력

		ArrayList<UserDTO> uList = new ArrayList<UserDTO>();
		uList = udao.userSearch(type, content, StartRow, pagesize);

		number = count-StartRow; //페이지당 게시글 출력 번호
		setPage(request, count, pagesize, curretnPage, StartRow, number);
		request.setAttribute("uList", uList);
		request.setAttribute("content", content);
		request.setAttribute("type", type);

		HttpSession session = request.getSession();
		String chkid = (String)session.getAttribute("id");
		if("admin".equals(chkid)) {
			RequestDispatcher rd = request.getRequestDispatcher("admin/admin-index.jsp?section=admin-user.jsp");
			rd.forward(request, response);
		}else {
			RequestDispatcher rd = request.getRequestDispatcher("/index.jsp");
			rd.forward(request, response);
		}
	}

	private void onePro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String chkid = (String)session.getAttribute("id");
		if(!"admin".equals(chkid)) {
			response.sendRedirect("index.jsp");
			return;
		}

		String userId = request.getParameter("user_Id");
		if(userId == null || userId.equals("")) {
			response.sendRedirect("UserProc.do");
			return;
		}

		UserDAO udao = new UserDAO();
		UserDTO udto = udao.getUser(userId);
		if(udto.getUserId() == null) {
			response.sendRedirect("UserProc.do");
			return;
		}
		if(udto.getUserBirth() != null && udto.getUserBirth().length() >= 10) {
			udto.setUserBirth(udto.getUserBirth().substring(0, 10));
		}

		request.setAttribute("udto", udto);
		RequestDispatcher rd = request.getRequestDispatcher("admin/admin-index.jsp?section=admin-user-form.jsp");
		rd.forward(request, response);
	}

	private void writePro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String chkid = (String)session.getAttribute("id");
		if(!"admin".equals(chkid)) {
			response.sendRedirect("index.jsp");
			return;
		}

		String btn = request.getParameter("btn");
		if(btn == null) {
			RequestDispatcher rd = request.getRequestDispatcher("admin/admin-index.jsp?section=admin-user-form.jsp");
			rd.forward(request, response);
			return;
		}

		UserDAO udao = new UserDAO();

		if(btn.equals("del")) {
			String userId = request.getParameter("userId");
			if(userId == null || userId.equals("")) {
				alert(response, "회원 정보가 없습니다.", "UserProc.do");
				return;
			}
			if(userId.equals("admin")) {
				alert(response, "관리자 계정은 탈퇴 처리할 수 없습니다.", "UserProc.do?user_Id=admin");
				return;
			}
			int result = udao.withdrawUser(userId);
			if(result == 1) {
				response.sendRedirect("UserProc.do");
			}else {
				alert(response, "탈퇴 처리에 실패했습니다.", "UserProc.do?user_Id=" + userId);
			}
			return;
		}

		if(btn.equals("ins") || btn.equals("upd")) {
			String userId = request.getParameter("userId");
			String userPw = request.getParameter("userPw");
			String userName = request.getParameter("userName");
			String userBirth = request.getParameter("userBirth");
			String userEmail = request.getParameter("userEmail");
			String userPhone = request.getParameter("userPhone");
			String userDelete = request.getParameter("userDelete");

			if(userId == null) userId = "";
			if(userPw == null) userPw = "";
			if(userName == null) userName = "";
			if(userBirth == null) userBirth = "";
			if(userEmail == null) userEmail = "";
			if(userPhone == null) userPhone = "";
			userId = userId.trim();
			userPw = userPw.trim();
			userName = userName.trim();
			userBirth = userBirth.trim();
			userEmail = userEmail.trim();
			userPhone = userPhone.trim();

			if(userId.equals("") || userId.length() > 20) {
				alert(response, "아이디는 1~20자로 입력해주세요.", null);
				return;
			}
			if(userName.equals("") || userName.length() > 20) {
				alert(response, "이름은 1~20자로 입력해주세요.", null);
				return;
			}
			if(userBirth.length() != 10) {
				alert(response, "생년월일을 선택해주세요.", null);
				return;
			}
			if(userPhone.equals("") || userPhone.length() > 15) {
				alert(response, "연락처는 1~15자로 입력해주세요.", null);
				return;
			}
			if(userEmail.length() > 30) {
				alert(response, "이메일은 30자 이내로 입력해주세요.", null);
				return;
			}

			UserDTO udto = new UserDTO();
			udto.setUserId(userId);
			udto.setUserPw(userPw);
			udto.setUserName(userName);
			udto.setUserBirth(userBirth);
			udto.setUserEmail(userEmail);
			udto.setUserPhone(userPhone);

			if(btn.equals("ins")) {
				if(userPw.equals("") || userPw.length() > 15) {
					alert(response, "비밀번호는 1~15자로 입력해주세요.", null);
					return;
				}
				if(udao.idCheck(userId)) {
					alert(response, "이미 사용 중인 아이디입니다.", null);
					return;
				}
				boolean ok = udao.adminInsert(udto);
				if(ok) {
					response.sendRedirect("UserProc.do");
				}else {
					alert(response, "회원 등록에 실패했습니다.", null);
				}
				return;
			}

			if(userPw.length() > 15) {
				alert(response, "비밀번호는 15자 이내로 입력해주세요.", null);
				return;
			}
			int del = 0;
			if("1".equals(userDelete)) {
				del = 1;
			}
			if(userId.equals("admin")) {
				del = 0;
			}
			udto.setUserDelete(del);
			boolean changePw = !userPw.equals("");
			int result = udao.adminUpdate(udto, changePw);
			if(result == 1) {
				response.sendRedirect("UserProc.do?user_Id=" + userId);
			}else {
				alert(response, "회원 수정에 실패했습니다.", null);
			}
		}
	}

	private void setPage(HttpServletRequest request, int count, int pagesize, int curretnPage, int StartRow, int number) {
		int pageCount = 0; //페이지 개수
		int pageBlock = 3; //한 화면에 출력할 페이지 개수
		int startpage = 1; //한 화면 시작 페이지 수
		int endpage = 0; //마지막 페이지 수

		if(count > 0) {
			pageCount = count/pagesize + (count % pagesize == 0 ? 0:1);
			if(curretnPage % pageBlock != 0) {
				startpage = (curretnPage / pageBlock)*pageBlock+1;
			}else {
				startpage = ((curretnPage/ pageBlock)-1)*pageBlock+1;
			}
			endpage = startpage + pageBlock -1;
			if(endpage > pageCount) {
				endpage = pageCount;
			}
		}
		request.setAttribute("StartRow", StartRow);
		request.setAttribute("pageCount", pageCount);
		request.setAttribute("pagesize", pagesize);
		request.setAttribute("count", count);
		request.setAttribute("number", number);
		request.setAttribute("startpage", startpage);
		request.setAttribute("endpage", endpage);
		request.setAttribute("pageBlock", pageBlock);
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
