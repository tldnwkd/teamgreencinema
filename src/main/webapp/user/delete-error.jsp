<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript">
	alert("비밀번호가 맞지 않아 회원탈퇴를 하지 못했습니다.");
	location.href="MyPageProc.do?userId=${sessionScope.id}&menu=delete";
</script>