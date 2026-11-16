<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript">
	alert("회원정보 변경에 에러가 발생하였습니다.");
	location.href="MyPageProc.do?userId=${sessionScope.id}&amp;menu=info"
</script>