<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css?v=20261116g">



	<%
		request.setCharacterEncoding("utf-8");
	
		String section = request.getParameter("section");
				
		if(section == null || section.trim().isEmpty()){			
	        section = "/admin/admin.jsp";
	        
	    }
	
	%>

<body class="admin-body">
	<div class="admin-shell">
		<jsp:include page="/admin/admin-left.jsp"></jsp:include>
		<div class="admin-main">
			<jsp:include page="/admin/admin-header.jsp"></jsp:include>		
			<jsp:include page="<%= section %>" ></jsp:include>
		</div>	
	</div>	
</body>