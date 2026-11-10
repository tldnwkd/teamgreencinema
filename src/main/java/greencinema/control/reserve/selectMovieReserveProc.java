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

		// 세션이 없거나, id가 null이거나, 공백/빈 문자열인 경우 모두 차단
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
		String largeRegion = request.getParameter("large_region");
		String smallRegion = request.getParameter("smallRegion"); 
		String selectedDate = request.getParameter("selectedDate");
		String scheduleSTime = request.getParameter("scheduleSTime");
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
		request.setAttribute("screenId", screenId);
		request.setAttribute("scheduleSTime", scheduleSTime);

		RequestDispatcher rd = request.getRequestDispatcher("index.jsp?section=reserve/reserve-movie.jsp");
		rd.forward(request, response);
	}
}