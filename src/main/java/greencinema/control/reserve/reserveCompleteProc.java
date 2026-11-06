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
		int adultcount= Integer.parseInt(request.getParameter("adultcount"));
		int precount = Integer.parseInt(request.getParameter("precount"));
		String seats = request.getParameter("seats");
		int totalprice = Integer.parseInt(request.getParameter("totalprice"));
		int screenId = Integer.parseInt(request.getParameter("screenId"));
		int reseveId = rdao.reserveID()+1;
		int payMethod = Integer.parseInt(request.getParameter("payMethod"));
		
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
		
		HttpSession session = request.getSession(false);
		String id = (String)session.getAttribute("id");
		System.out.println("예매 아이디:"+reseveId);
		System.out.println("결제방식:"+payMethod);
		System.out.println("아이디:"+id);
		System.out.println("성인숫자:"+adultcount);
		System.out.println("청소년숫자:"+precount);
		System.out.println("총금액:"+totalprice);
		System.out.println("스크린 아이디:"+screenId);
		System.out.println("예매 아이디:"+reseveId);
		System.out.println("좌석이름:"+seats);
		if(session !=null) {
			rdao.insertPayment(reseveId, payMethod);
			rdao.insertReserve(id, adultcount, precount, totalprice);
			rdao.insertSeat(screenId, reseveId, seats);
			response.setContentType("text/html; charset=UTF-8");
		    PrintWriter out = response.getWriter();
		    out.println("<script>");
		    out.println("alert('예매가 완료되었습니다');");
		    out.println("location.href='index.jsp';"); 
		    out.println("</script>");
		}
		
		
	}

}
