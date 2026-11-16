package greencinema.control.reserve;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import greencinema.model.reservejoin.ReservejoinDAO;
import greencinema.model.reservejoin.ReservejoinDTO;

@WebServlet("/selectMovieReserveProc.do")
public class selectMovieReserveProc extends HttpServlet {
	
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

		if (session == null || idObj == null || idObj.toString().trim().isEmpty()) {
		    response.setContentType("text/html; charset=UTF-8");
		    PrintWriter out = response.getWriter();
		    out.println("<script>");
		    out.println("alert('로그인 후 이용 가능합니다.');");
		    out.println("location.href='index.jsp?section=user/login.jsp';");
		    out.println("</script>");
		    return;
		}
		
		ReservejoinDAO rjdao = new ReservejoinDAO();
		
		String movieId = request.getParameter("movieId");
		
		if (movieId == null || movieId.trim().isEmpty() || movieId.equals("null")) {
		    movieId = "1"; // 선택 영화 없을경우 1번 영화 기본선택 추가
		}

		String largeRegion = request.getParameter("large_region");
		String smallRegion = request.getParameter("smallRegion"); 
		String selectedDate = request.getParameter("selectedDate");
		String scheduleSTime = request.getParameter("scheduleSTime");
		String screenId = request.getParameter("screenId");
		
		// 이미 지역이나 날짜가 파라미터에 채워져 있다면 리다이렉트 루프를 돌지 않고 바로 뷰로 진행
		boolean needsRedirect = false;
		
		if (largeRegion == null || largeRegion.trim().isEmpty() ||
		    smallRegion == null || smallRegion.trim().isEmpty() ||
		    selectedDate == null || selectedDate.trim().isEmpty()) {
		    
		    ReservejoinDTO firstSchedule = rjdao.getFirstScheduleInfo(movieId);
		    if (firstSchedule != null) {
		        if (largeRegion == null || largeRegion.trim().isEmpty()) {
		            largeRegion = firstSchedule.getLargeRegion();
		            needsRedirect = true;
		        }
		        if (smallRegion == null || smallRegion.trim().isEmpty()) {
		            smallRegion = firstSchedule.getSmallRegion();
		            needsRedirect = true;
		        }
		    }
		    
		    if (selectedDate == null || selectedDate.trim().isEmpty()) {
		        selectedDate = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
		        needsRedirect = true;
		    }
		    
		    // 무한 루프 방지를 위해 실제로 값이 비어있어 새로 채워진 경우에만 리다이렉트 수행
		    if (needsRedirect) {
		        response.sendRedirect("selectMovieReserveProc.do?movieId=" + movieId 
		                + "&large_region=" + java.net.URLEncoder.encode(largeRegion != null ? largeRegion : "", "UTF-8") 
		                + "&smallRegion=" + java.net.URLEncoder.encode(smallRegion != null ? smallRegion : "", "UTF-8") 
		                + "&selectedDate=" + selectedDate);
		        return;
		    }
		}
		
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
		request.setAttribute("screenId", screenId);
		request.setAttribute("scheduleSTime", scheduleSTime);

		RequestDispatcher rd = request.getRequestDispatcher("index.jsp?section=reserve/reserve-movie.jsp");
		rd.forward(request, response);
	}
}

