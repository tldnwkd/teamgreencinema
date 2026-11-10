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

import greencinema.model.reservejoin.ReservejoinDAO;
import greencinema.model.reservejoin.ReservejoinDTO;

@WebServlet("/selectSeatReserveProc.do")
public class selectSeatReserveProc extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		reqPro(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		reqPro(request, response);
	}
	
	protected void reqPro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		HttpSession session = request.getSession(false);
		Object idObj = (session != null) ? session.getAttribute("id") : null;

		// 세션이 없거나, id가 null이거나, 공백/빈 문자열인 경우 모두 차단
		if (session == null || idObj == null || idObj.toString().trim().isEmpty()) {
		    response.setContentType("text/html; charset=UTF-8");
		    PrintWriter out = response.getWriter();
		    out.println("<script>");
		    out.println("alert('세션이 만료되었습니다. 로그인 후 다시 예매 하세요.');");
		    out.println("location.href='index.jsp?section=user/login.jsp';");
		    out.println("</script>");
		    return;
		}
		
		ReservejoinDAO rjdao = new ReservejoinDAO();	
		
		String movieId = request.getParameter("movieId");
		String largeRegion = request.getParameter("large_region");
		String smallRegion = request.getParameter("smallRegion"); 
		String selectedDate = request.getParameter("selectedDate");
		String scheduleSTime = request.getParameter("scheduleSTime");
		String scheduleETime = request.getParameter("scheduleETime");
		int screenId = Integer.parseInt(request.getParameter("screenId")); 
		
		// 💡 상영 회차 고유 ID 파라미터 수신 및 형변환
		String scheduleIdStr = request.getParameter("scheduleId");
		int scheduleId = (scheduleIdStr != null && !scheduleIdStr.isEmpty()) ? Integer.parseInt(scheduleIdStr) : 0;
			
		ReservejoinDTO rjdto = rjdao.getOneMovieList(movieId);
		ArrayList<ReservejoinDTO> rjlist = rjdao.getAllLargeTheater();
		ArrayList<ReservejoinDTO> rjlist02 = rjdao.getAllSmallTheater(largeRegion);
		ArrayList<ReservejoinDTO> rjlist03 = rjdao.getAllschedule(movieId, largeRegion, smallRegion, selectedDate);
		ArrayList<ReservejoinDTO> rjlist04 = rjdao.getSelectMovie(largeRegion, smallRegion);		
		
		// 💡 회차 ID를 기준으로 해당 회차의 예매 완료된 좌석 조회
		ArrayList<ReservejoinDTO> rjlist05 = rjdao.getAllseat(scheduleId, screenId);
		
		System.out.println("--- [좌석 조회 파라미터 확인] ---");
	    System.out.println("movieId: " + movieId);
	    System.out.println("smallRegion: " + smallRegion);
	    System.out.println("selectedDate: " + selectedDate);
	    System.out.println("scheduleSTime: " + scheduleSTime);
	    System.out.println("scheduleId: " + scheduleId);
	    System.out.println("이미 예매된 좌석 수: " + rjlist05.size());
			
		request.setAttribute("rjdto", rjdto);
		request.setAttribute("rjlist", rjlist);
		request.setAttribute("rjlist02", rjlist02);
		request.setAttribute("rjlist03", rjlist03);
		request.setAttribute("rjlist04", rjlist04);
		request.setAttribute("rjlist05", rjlist05); 
		request.setAttribute("scheduleSTime", scheduleSTime);
		request.setAttribute("scheduleETime", scheduleETime);
		request.setAttribute("screenId", screenId);
		request.setAttribute("scheduleId", scheduleId); // 💡 JSP 및 다음 프로세스로 넘길 속성 추가

		RequestDispatcher rd = request.getRequestDispatcher("index.jsp?section=reserve/reserve-seat.jsp");
		rd.forward(request, response);		
	}
}