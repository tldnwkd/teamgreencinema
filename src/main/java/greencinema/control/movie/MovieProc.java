package greencinema.control.movie;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.Servlet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import greencinema.model.reservejoin.ReservejoinDAO;
import greencinema.model.reservejoin.ReservejoinDTO;

@WebServlet("/MovieProc.do")
public class MovieProc extends HttpServlet implements Servlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		reqPro(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		reqPro(request, response);
	}
	
	protected void reqPro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		ReservejoinDAO rjdao = new ReservejoinDAO();
		ReservejoinDTO rjdto = new ReservejoinDTO();
		String movieId = request.getParameter("movieId");
		
		rjdto= rjdao.getOneMovieList(movieId);
		request.setAttribute("rjdto", rjdto);
				
		RequestDispatcher rd = request.getRequestDispatcher("/index.jsp?section=movie/movieInfo.jsp");		
		rd.forward(request, response);	
		
	}


}
