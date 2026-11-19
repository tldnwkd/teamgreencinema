package greencinema.control.movie;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Part;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import greencinema.model.movie.MovieDAO;
import greencinema.model.movie.MovieDTO;

@WebServlet("/AdminMovieInsertProc.do")
@MultipartConfig(maxFileSize = 1024 * 1024 * 5, maxRequestSize = 1024 * 1024 * 6)
public class AdminMovieInsertProc extends HttpServlet {

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

		String type = request.getParameter("btn");
		// 등록 화면
		if(type == null) {
			RequestDispatcher rd = request.getRequestDispatcher("admin/admin-index.jsp?section=admin-movie-form.jsp");
			rd.forward(request, response);
			return;
		}

		if(type.equals("del")) {
			String movieIdStr = request.getParameter("movieId");
			if(movieIdStr == null || movieIdStr.equals("")) {
				response.sendRedirect("AdminMovieProc.do");
				return;
			}
			int movieId = Integer.parseInt(movieIdStr);
			MovieDAO mdao = new MovieDAO();
			if(mdao.scheduleCount(movieId) > 0) {
				alert(response, "상영 일정이 있는 영화는 삭제할 수 없습니다.", "AdminMovieProc.do?movie_Id=" + movieId);
				return;
			}
			int result = mdao.deleteMovie(movieId);
			System.out.println(result);
			if(result > 0) {
				response.sendRedirect("AdminMovieProc.do");
			}else {
				alert(response, "영화를 삭제하지 못했습니다.", "AdminMovieProc.do?movie_Id=" + movieId);
			}
			return;
		}

		if(type.equals("ins") || type.equals("upd")) {
			String title = request.getParameter("movieTitle");
			String content = request.getParameter("movieContent");
			String imgPath = request.getParameter("imgPath");
			String rate = request.getParameter("movieRate");
			String runtime = request.getParameter("runTime");
			String uploaded = savePoster(request);

			String msg = null;
			if("big".equals(uploaded)) {
				msg = "이미지 파일은 5MB 이하만 올릴 수 있습니다.";
			}else if("type".equals(uploaded)) {
				msg = "jpg, jpeg, png, gif, webp 파일만 올릴 수 있습니다.";
			}else if("fail".equals(uploaded)) {
				msg = "이미지 파일을 저장하지 못했습니다.";
			}else if(uploaded != null && !uploaded.equals("")) {
				imgPath = uploaded;
			}

			if(msg == null && (title == null || title.equals("") || title.length() > 20)) {
				msg = "제목은 1자 이상 20자 이하로 입력해주세요.";
			}else if(msg == null && (content == null || content.equals(""))) {
				msg = "영화 내용을 입력해주세요.";
			}else if(msg == null && (imgPath == null || imgPath.equals("") || imgPath.length() > 20)) {
				msg = "포스터 이미지를 선택해주세요.";
			}else if(msg == null && (rate == null || rate.equals("") || runtime == null || runtime.equals(""))) {
				msg = "관람등급과 상영시간을 입력해주세요.";
			}

			int movieRate = 0;
			int runTime = 0;
			if(msg == null) {
				try {
					movieRate = Integer.parseInt(rate);
					runTime = Integer.parseInt(runtime);
				}catch(NumberFormatException e) {
					msg = "관람등급과 상영시간은 숫자로 입력해주세요.";
				}
			}
			if(msg == null && !(movieRate == 0 || movieRate == 12 || movieRate == 15 || movieRate == 19)) {
				msg = "관람등급을 다시 선택해주세요.";
			}
			if(msg == null && (runTime < 1 || runTime > 255)) {
				msg = "상영시간은 1분 이상 255분 이하로 입력해주세요.";
			}
			if(msg != null) {
				alert(response, msg, null);
				return;
			}

			MovieDTO mdto = new MovieDTO();
			mdto.setMovieTitle(title);
			mdto.setMovieContent(content);
			mdto.setImgPath(imgPath);
			mdto.setMovieRate(movieRate);
			mdto.setRunTime(runTime);

			MovieDAO mdao = new MovieDAO();
			if(type.equals("ins")) {
				boolean result = mdao.insert(mdto);
				System.out.println(result);
				if(result) {
					response.sendRedirect("AdminMovieProc.do");
				}else {
					alert(response, "영화를 등록하지 못했습니다.", "AdminMovieInsertProc.do");
				}
			}else {
				String movieIdStr = request.getParameter("movieId");
				if(movieIdStr == null || movieIdStr.equals("")) {
					response.sendRedirect("AdminMovieProc.do");
					return;
				}
				int movieId = Integer.parseInt(movieIdStr);
				mdto.setMovieId(movieId);
				int result = mdao.update(mdto);
				System.out.println(result);
				if(result > 0) {
					response.sendRedirect("AdminMovieProc.do");
				}else {
					alert(response, "영화를 수정하지 못했습니다.", "AdminMovieProc.do?movie_Id=" + movieId);
				}
			}
		}
	}

	// 올린 포스터를 /img 에 짧은 이름으로 저장. 없으면 빈 문자열.
	private String savePoster(HttpServletRequest request) {
		Part part = null;
		try {
			part = request.getPart("poster");
		} catch (IllegalStateException e) {
			return "big";
		} catch (Exception e) {
			return "";
		}
		if(part == null || part.getSize() <= 0) {
			return "";
		}

		String origin = part.getSubmittedFileName();
		String ext = "";
		if(origin != null && origin.lastIndexOf('.') >= 0) {
			ext = origin.substring(origin.lastIndexOf('.')).toLowerCase();
		}
		if(!(ext.equals(".jpg") || ext.equals(".jpeg") || ext.equals(".png") || ext.equals(".gif") || ext.equals(".webp"))) {
			return "type";
		}

		String fileName = "u" + (System.currentTimeMillis() % 100000000L) + ext;
		String imgPath = "/img/" + fileName;
		if(imgPath.length() > 20) {
			return "fail";
		}

		// 실행 중인 서버 img 와 프로젝트 src/main/webapp/img 둘 다 저장한다.
		// 서버 폴더에만 두면 이클립스 img 목록에 안 보이고, 다시 배포하면 파일도 사라진다.
		String folder = request.getServletContext().getRealPath("/img");
		File projectImg = new File("C:/green/src/main/webapp/img");
		File dir = null;
		if(folder != null) {
			dir = new File(folder);
			if(!dir.exists()) {
				dir.mkdirs();
			}
		}
		if(dir == null || !dir.isDirectory()) {
			dir = projectImg;
		}
		if(!dir.isDirectory()) {
			return "fail";
		}
		File saved = new File(dir, fileName);
		try {
			part.write(saved.getAbsolutePath());
			if(projectImg.isDirectory() && !saved.getCanonicalPath().equals(new File(projectImg, fileName).getCanonicalPath())) {
				copyFile(saved, new File(projectImg, fileName));
			}
		} catch (IOException e) {
			e.printStackTrace();
			return "fail";
		}
		return imgPath;
	}

	private void copyFile(File from, File to) throws IOException {
		FileInputStream in = new FileInputStream(from);
		FileOutputStream out = new FileOutputStream(to);
		byte[] buf = new byte[4096];
		int n = 0;
		while((n = in.read(buf)) != -1) {
			out.write(buf, 0, n);
		}
		in.close();
		out.close();
	}

	private void alert(HttpServletResponse response, String msg, String location) throws IOException {
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.println("<script>");
		out.println("alert('" + msg + "');");
		if(location == null) {
			out.println("history.back();");
		}else {
			out.println("location.href='" + location + "';");
		}
		out.println("</script>");
	}

}
