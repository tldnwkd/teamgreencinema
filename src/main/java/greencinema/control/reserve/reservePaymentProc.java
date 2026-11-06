package greencinema.control.reserve;

import java.io.IOException;
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

@WebServlet("/reservePaymentProc.do")
public class reservePaymentProc extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		reqPro(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		reqPro(request, response);
	}
	
	protected void reqPro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		ReservejoinDAO rjdao = new ReservejoinDAO();
		ReserveDAO rdao = new ReserveDAO();
		
		String movieId = request.getParameter("movieId");
		String smallRegion = request.getParameter("smallRegion"); 
		String largeRegion = request.getParameter("large_region");
		String selectedDate = request.getParameter("selectedDate");
		String scheduleSTime = request.getParameter("scheduleSTime");
		String scheduleETime = request.getParameter("scheduleETime");
		String adultcount= request.getParameter("adultcount");
		int precount = Integer.parseInt(request.getParameter("precount"));
		String seats = request.getParameter("seats");
		String screenId = request.getParameter("screenId");
		
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
		request.setAttribute("adultcount", adultcount);
		request.setAttribute("precount", precount);
		request.setAttribute("seats", seats);
		request.setAttribute("screenId", screenId);
	
		
		RequestDispatcher rd = request.getRequestDispatcher("index.jsp?section=payment/payment.jsp");
		rd.forward(request, response);
	}


}
