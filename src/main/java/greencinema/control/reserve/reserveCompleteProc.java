package greencinema.control.reserve;

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

		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("id") == null) {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('세션이 만료되었습니다. 로그인 후 다시 예매 하세요.');");
			out.println("location.href='index.jsp';"); 
			out.println("</script>");
			return;
		}

		String id = (String) session.getAttribute("id");

		ReservejoinDAO rjdao = new ReservejoinDAO();
		ReserveDAO rdao = new ReserveDAO();

		String movieId = request.getParameter("movieId");
		String smallRegion = request.getParameter("smallRegion");
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

		rdao.insertPayment(reseveId, payMethod);
		rdao.insertReserve(id, adultcount, precount, totalprice);
		rdao.insertSeat(scheduleId, screenId, reseveId, seats);

		ReservejoinDTO rjdto = rjdao.getOneMovieList(movieId);

		request.setAttribute("rjdto", rjdto);
		request.setAttribute("smallRegion", smallRegion);
		request.setAttribute("selectedDate", selectedDate);
		request.setAttribute("scheduleSTime", scheduleSTime);
		request.setAttribute("scheduleETime", scheduleETime);
		request.setAttribute("adultcount", adultcount);
		request.setAttribute("precount", precount);
		request.setAttribute("seats", seats);
		request.setAttribute("totalprice", totalprice);
		request.setAttribute("isReservedSuccess", true);

		RequestDispatcher rd = request.getRequestDispatcher("index.jsp?section=reserve/reserve-complete.jsp");
		rd.forward(request, response);
	}
}