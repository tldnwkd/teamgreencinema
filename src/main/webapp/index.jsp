<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>
<%@ page import="java.sql.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/style.css">
</head>
<body>
	<%
		request.setCharacterEncoding("utf-8");
	
		String section = request.getParameter("section");
		
		if(section ==null){
			section = "section.jsp";
		}
	
	%>
	<div class="index-wrap">
		<jsp:include page="header.jsp"></jsp:include>	
		<main id="main">
			<jsp:include page="<%= section %>"/>		
		</main>
		<jsp:include page="footer.jsp"></jsp:include>		
	</div>
</body>
</html>