<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<section class="admin-board">
	<div class="admin-panel">
		<form class="admin-form" action="UserProc.do" method="post" name="userForm">
			<div class="admin-form__row">
				<label for="userId">아이디</label>
				<c:choose>
					<c:when test="${empty udto}">
						<input id="userId" name="userId" type="text" maxlength="20" placeholder="아이디 (20자 이내)">
					</c:when>
					<c:otherwise>
						<input id="userId" name="userId" type="text" maxlength="20" value="${udto.userId}" readonly>
					</c:otherwise>
				</c:choose>
			</div>
			<div class="admin-form__row">
				<label for="userPw">비밀번호</label>
				<input id="userPw" name="userPw" type="text" maxlength="15" placeholder="${empty udto ? '비밀번호 (15자 이내)' : '비워 두면 기존 비밀번호를 유지합니다'}">
				<c:if test="${not empty udto}">
					<p class="admin-form__hint">비밀번호를 바꾸지 않으려면 비워 두세요.</p>
				</c:if>
			</div>
			<div class="admin-form__row">
				<label for="userName">이름</label>
				<input id="userName" name="userName" type="text" maxlength="20" value="${udto.userName}" placeholder="이름 (20자 이내)">
			</div>
			<div class="admin-form__row">
				<label for="userBirth">생년월일</label>
				<input id="userBirth" name="userBirth" type="date" value="${udto.userBirth}">
			</div>
			<div class="admin-form__row">
				<label for="userPhone">연락처</label>
				<input id="userPhone" name="userPhone" type="text" maxlength="15" value="${udto.userPhone}" placeholder="010-0000-0000">
			</div>
			<div class="admin-form__row">
				<label for="userEmail">이메일</label>
				<input id="userEmail" name="userEmail" type="text" maxlength="30" value="${udto.userEmail}" placeholder="이메일 (없으면 비워 두세요)">
			</div>
			<c:if test="${not empty udto}">
				<div class="admin-form__row">
					<label for="userDelete">상태</label>
					<select id="userDelete" name="userDelete">
						<option value="0" ${udto.userDelete == 0 ? 'selected' : ''}>정상</option>
						<option value="1" ${udto.userDelete == 1 ? 'selected' : ''}>탈퇴</option>
					</select>
				</div>
			</c:if>

			<div class="admin-form__actions">
				<a href="UserProc.do">목록</a>
				<c:choose>
					<c:when test="${empty udto}">
						<button type="submit" name="btn" value="ins">등록</button>
					</c:when>
					<c:otherwise>
						<button type="submit" name="btn" value="upd" onclick="return confirm('회원 정보를 수정할까요?');">수정</button>
							<c:if test="${udto.userId != 'admin'}">							
								<button type="submit" name="btn" value="del" class="is-danger" onclick="return confirm('이 회원을 탈퇴 처리할까요?');">탈퇴</button>
							</c:if>
							<c:if test="${udto.userId == 'admin'}">							
								<button type="button" class="is-danger" onclick="admin()">탈퇴</button>
							</c:if>
					</c:otherwise>
				</c:choose>
			</div>
		</form>
	</div>
</section>

<script type="text/javascript">
	function admin(){
		alert("관리자 계정은 삭제 할 수 없습니다.");
	}
</script>
