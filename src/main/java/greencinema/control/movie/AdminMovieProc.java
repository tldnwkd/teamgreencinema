package greencinema.control.movie;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import greencinema.model.faq.FaqDAO;
import greencinema.model.inquiry.InquiryDAO;
import greencinema.model.movie.MovieDAO;
import greencinema.model.movie.MovieDTO;
import greencinema.model.notice.NoticeDAO;
import greencinema.model.user.UserDAO;

@WebServlet("/AdminMovieProc.do")
@MultipartConfig(maxFileSize = 1024 * 1024 * 5, maxRequestSize = 1024 * 1024 * 6)
public class AdminMovieProc extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		reqPro(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		reqPro(request, response);
	}

	protected void reqPro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String btn = null;
		String menu = null;
		try {
			btn = request.getParameter("btn");
			menu = request.getParameter("menu");
		} catch (IllegalStateException e) {
			response.setContentType("text/html; charset=UTF-8");
			java.io.PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('이미지 파일은 5MB 이하만 올릴 수 있습니다.');");
			out.println("history.back();");
			out.println("</script>");
			return;
		}
		if(btn != null || "write".equals(menu)) {
			new AdminMovieInsertProc().reqPro(request, response);
			return;
		}
		if(request.getParameter("movie_Id") != null) {
			new OneAdminMovieProc().reqPro(request, response);
			return;
		}

		HttpSession session = request.getSession();
		String chkid = (String)session.getAttribute("id");
		System.out.println(chkid);
		
		int count = 0; // 전체게시글 수
		int pagesize = 10; // 한 화면에 그릴 페이지 수
		String pageNum = request.getParameter("pageNum");//화면에서 넘겨받을 pageNum값
		if(pageNum == null) { // 페이지 선택 안했을 경우 자동으로 1번 페이지 선택
			pageNum = "1";
		}
		
		int number = 0; 
		int curretnPage = Integer.parseInt(pageNum); // 현재 페이지 위치
		
		MovieDAO mdao = new MovieDAO();
		count = mdao.movieAllCount(); // 페이지 전체수 입력
		System.out.println(count);
		int StartRow = (curretnPage-1)*pagesize;//한 페이지에 출력할 개수
		
		ArrayList<MovieDTO>  mList = new ArrayList<MovieDTO>();
		mList = mdao.movieAllList(StartRow,pagesize);
		
		
		number = count-StartRow; //페이지당 게시글 출력 번호
		int pageCount = 0; //페이지 개수
		int pageBlock = 3; //한 화면에 출력할 페이지 개수
		int startpage = 1; //한 화면 시작 페이지 수
		int endpage = 0; //마지막 페이지 수
		
		if(count > 0) {
			
			pageCount = count/pagesize + (count % pagesize == 0 ? 0:1);
			
			if(curretnPage % pageBlock != 0) {
				startpage = (curretnPage / pageBlock)*pageBlock+1;
			}else {
				startpage = ((curretnPage/ pageBlock)-1)*pageBlock+1;
			}
			
			endpage = startpage + pageBlock -1;
			
			if(endpage > pageCount) {
				endpage = pageCount;
			}
			
		}
		
		
		request.setAttribute("mList", mList);
		
		request.setAttribute("StartRow", StartRow);
		request.setAttribute("pageCount", pageCount);
		request.setAttribute("pagesize", pagesize);
		request.setAttribute("count", count);
		request.setAttribute("number", number);
		request.setAttribute("startpage", startpage);
		request.setAttribute("endpage", endpage);
		request.setAttribute("pageBlock", pageBlock);
		
		
		request.setAttribute("movieCount", count);
															 
		if("admin".equals(chkid)) {
			RequestDispatcher rd = request.getRequestDispatcher("admin/admin-index.jsp?section=admin-movie.jsp");
			rd.forward(request, response);
		}else {
			RequestDispatcher rd = request.getRequestDispatcher("/index.jsp");
			rd.forward(request, response);
		}
				
	}

	
}
