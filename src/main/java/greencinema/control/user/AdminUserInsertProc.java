package greencinema.control.user;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import greencinema.model.user.UserDAO;
import greencinema.model.user.UserDTO;

@WebServlet("/AdminUserInsertProc.do")
public class AdminUserInsertProc extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		reqPro(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		reqPro(request, response);
	}

	protected void reqPro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
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
