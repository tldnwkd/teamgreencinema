<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>
<%@ page import="java.sql.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>그린시네마에 오신걸 환영합니다.</title>
<link rel="stylesheet" href="css/style.css">
</head>

	<%
		request.setCharacterEncoding("utf-8");
	
		String section = request.getParameter("section");				
		if(section == null){			
	        request.getRequestDispatcher("MovieListProc.do").forward(request, response);
	        return;
	    }	
	%>
	
	<c:choose >	
	<c:when test="${sessionScope.id == 'admin' }">		
		<jsp:include page="/admin/admin-index.jsp"></jsp:include>
	</c:when>
	<c:otherwise>
	<body>
		<div class="index-wrap">
			<jsp:include page="header.jsp"></jsp:include>	
			<main id="main">
				<jsp:include page="<%= section %>"/>		
			</main>
			<jsp:include page="footer.jsp"></jsp:include>		
		</div>
	</body>
	</c:otherwise>	
	</c:choose>

</html>