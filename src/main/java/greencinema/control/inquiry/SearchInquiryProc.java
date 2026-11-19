package greencinema.control.inquiry;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import greencinema.model.inquiry.InquiryDAO;
import greencinema.model.inquiry.InquiryDTO;

@WebServlet("/SearchInquiryProc.do")
public class SearchInquiryProc extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		rePro(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		rePro(request, response);
	}
	protected void rePro(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {
		System.out.println("SearchInquiryProc 실행됨");

	    request.setCharacterEncoding("UTF-8");

	    HttpSession session = request.getSession(false);
	    String chkid = session == null ? null : (String) session.getAttribute("id");

	    // 로그인 검사
	    if (chkid == null || chkid.isEmpty()) {
	        response.sendRedirect(
	            request.getContextPath() + "/index.jsp?section=user/login.jsp"
	        );
	        return;
	    }

	    String type = request.getParameter("type");
	    String content = request.getParameter("content");

	    


	    if (type == null) type = "";
	    if (content == null) content = "";

	    // 페이징
	    int pagesize = 10;
	    String pageNum = request.getParameter("pageNum");

	    if (pageNum == null || pageNum.isEmpty()) {
	        pageNum = "1";
	    }

	    int currentPage = Integer.parseInt(pageNum);
	    int StartRow = (currentPage - 1) * pagesize;

	    InquiryDAO idao = new InquiryDAO();

	    int count = 0;
	    ArrayList<InquiryDTO> sList;

	    boolean isAdmin = "admin".equals(chkid);
	    
	    System.out.println("검색 Servlet 실행");
	    System.out.println("관리자 여부: " + isAdmin);
	    System.out.println("type: [" + type + "]");
	    System.out.println("content: [" + content + "]");
	    System.out.println("status: [" + request.getParameter("status") + "]");

	    // 관리자 / 일반회원 검색 구분
	    if (isAdmin) {
	    	
	    	String status = request.getParameter("status");
	    	if(status == null || status.trim().isEmpty()) {
	    		status = null;
	    	}
	    		
	    		if(type == null || type.trim().isEmpty()) {
	    		type = null;
	    		content = null;
	    	}
	    	
	    	
		    System.out.println("status:"+ status);

	        count = idao.adminSCount(type, content, status);
	        sList = idao.adminSearch(type, content, StartRow, pagesize, status);

	    
	    	request.setAttribute("status", status);
	    
	    } else {

	        count = idao.sCount(chkid, type, content);
	        sList = idao.search(type, content, StartRow, pagesize, chkid);
	    }

	    int number = count - StartRow;

	    int pageCount = 0;
	    int pageBlock = 3;
	    int startpage = 1;
	    int endpage = 0;

	    if (count > 0) {

	        pageCount = count / pagesize
	                + (count % pagesize == 0 ? 0 : 1);

	        startpage = ((currentPage - 1) / pageBlock)
	                * pageBlock + 1;

	        endpage = startpage + pageBlock - 1;

	        if (endpage > pageCount) {
	            endpage = pageCount;
	        }
	    }

	    // JSP 데이터 전달
	    request.setAttribute("sList", sList);
	    request.setAttribute("iList", sList);

	    request.setAttribute("type", type);
	    request.setAttribute("content", content);

	    request.setAttribute("StartRow", StartRow);
	    request.setAttribute("pageCount", pageCount);
	    request.setAttribute("pagesize", pagesize);
	    request.setAttribute("count", count);
	    request.setAttribute("number", number);
	    request.setAttribute("startpage", startpage);
	    request.setAttribute("endpage", endpage);
	    request.setAttribute("pageBlock", pageBlock);

	    // 화면 이동
	    String view;

	    if (isAdmin) {
	        view = "/admin/admin-index.jsp?section=admin-inquiry.jsp";
	    } else {
	        view = "/index.jsp?section=cs/cs-index.jsp"
	             + "&csSection=inquiry&csView=search";
	    }

	    RequestDispatcher rd = request.getRequestDispatcher(view);
	    rd.forward(request, response);
	}
}
