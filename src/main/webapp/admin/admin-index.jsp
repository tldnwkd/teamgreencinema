<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css?v=20261116h">



	<%
		request.setCharacterEncoding("utf-8");
	
		String section = request.getParameter("section");
				
		if(section == null || section.trim().isEmpty()){			
			request.getRequestDispatcher("/AdminMovieProc.do").forward(request, response);
	        return;
	        
	    }
	
	%>

<body class="admin-body">
	<div class="admin-shell">
		<jsp:include page="/admin/admin-left.jsp"></jsp:include>
		<div class="admin-main">
			<jsp:include page="/admin/admin-header.jsp"></jsp:include>
			<% if("admin-user.jsp".equals(section)){ %>
				<jsp:include page="/admin/admin-user.jsp"></jsp:include>
			<% }else if("admin-user-form.jsp".equals(section)){ %>
				<jsp:include page="/admin/admin-user-form.jsp"></jsp:include>
			<% }else{ %>
				<jsp:include page="<%= section %>" ></jsp:include>
			<% } %>
		</div>	
	</div>	
</body>