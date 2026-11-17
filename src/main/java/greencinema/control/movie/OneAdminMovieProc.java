package greencinema.control.movie;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import greencinema.model.movie.MovieDAO;
import greencinema.model.movie.MovieDTO;

@WebServlet("/OneAdminMovieProc.do")
public class OneAdminMovieProc extends HttpServlet {

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
			RequestDispatcher rd = request.getRequestDispatcher("/index.jsp");
			rd.forward(request, response);
			return;
		}

		String movieIdStr = request.getParameter("movie_Id");
		if(movieIdStr == null || movieIdStr.equals("")) {
			response.sendRedirect("AdminMovieProc.do");
			return;
		}
		int movieId = Integer.parseInt(movieIdStr);
		MovieDAO mdao = new MovieDAO();
		MovieDTO mdto = mdao.oneMovie(movieId);
		if(mdto == null) {
			response.sendRedirect("AdminMovieProc.do");
			return;
		}

		request.setAttribute("mdto", mdto);
		RequestDispatcher rd = request.getRequestDispatcher("admin/admin-index.jsp?section=admin-movie-form.jsp");
		rd.forward(request, response);
	}

}
