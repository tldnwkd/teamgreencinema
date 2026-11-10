package greencinema.control.reserve;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import greencinema.model.reserve.ReserveDAO;
import greencinema.model.reservejoin.ReservejoinDAO;
import greencinema.model.reservejoin.ReservejoinDTO;

@WebServlet("/reserveCompleteProc.do")
public class reserveCompleteProc extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		reqPro(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		reqPro(request, response);
	}

	protected void reqPro(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");

		// 로그인 체크를 위한 세션 확인 (비로그인 시 처리)
		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("id") == null) {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('세션이 만료되었습니다. 로그인 후 다시 예매 하세요.');");
			out.println("location.href='login.jsp';"); 
			out.println("</script>");
			return; // 예매 프로세스 중단
		}

		String id = (String) session.getAttribute("id");

		ReservejoinDAO rjdao = new ReservejoinDAO();
		ReserveDAO rdao = new ReserveDAO();

		String movieId = request.getParameter("movieId");
		String smallRegion = request.getParameter("smallRegion");
		String largeRegion = request.getParameter("large_region");
		String selectedDate = request.getParameter("selectedDate");
		String scheduleSTime = request.getParameter("scheduleSTime");
		String scheduleETime = request.getParameter("scheduleETime");
		int adultcount = Integer.parseInt(request.getParameter("adultcount"));
		int precount = Integer.parseInt(request.getParameter("precount"));
		String seats = request.getParameter("seats");
		int totalprice = Integer.parseInt(request.getParameter("totalprice"));
		int screenId = Integer.parseInt(request.getParameter("screenId"));
		int reseveId = rdao.reserveID() + 1;
		int payMethod = Integer.parseInt(request.getParameter("payMethod"));
		int scheduleId = Integer.parseInt(request.getParameter("scheduleId"));

		ReservejoinDTO rjdto = rjdao.getOneMovieList(movieId);
		ArrayList<ReservejoinDTO> rjlist = rjdao.getAllLargeTheater();
		ArrayList<ReservejoinDTO> rjlist02 = rjdao.getAllSmallTheater(largeRegion);
		ArrayList<ReservejoinDTO> rjlist03 = rjdao.getAllschedule(movieId, largeRegion, smallRegion, selectedDate);
		ArrayList<ReservejoinDTO> rjlist04 = rjdao.getSelectMovie(largeRegion, smallRegion);

		request.setAttribute("rjdto", rjdto);
		request.setAttribute("rjlist", rjlist);
		request.setAttribute("rjlist02", rjlist02);
		request.setAttribute("rjlist03", rjlist03);
		request.setAttribute("rjlist04", rjlist04);
		request.setAttribute("scheduleSTime", scheduleSTime);
		request.setAttribute("scheduleETime", scheduleETime);
		request.setAttribute("screenId", screenId);
		request.setAttribute("scheduleId", scheduleId);

		// DB Insert 실행 (로그인 검증을 이미 통과했으므로 안전하게 실행)
		rdao.insertPayment(reseveId, payMethod);
		rdao.insertReserve(id, adultcount, precount, totalprice);
		rdao.insertSeat(scheduleId, screenId, reseveId, seats);

		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.println("<script>");
		out.println("alert('예매가 완료되었습니다. 예매내역은 마이페이지에서 확인 가능합니다.');");
		out.println("location.href='index.jsp';");
		out.println("</script>");
	}
}