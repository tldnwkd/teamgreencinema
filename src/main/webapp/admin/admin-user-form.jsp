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
				<label for="beforePw">비밀번호</label>
				<input id="beforePw" name="userPw" type="text" maxlength="15" placeholder="${empty udto ? '비밀번호 (15자 이내)' : '비워 두면 기존 비밀번호를 유지합니다'}">
				<c:if test="${not empty udto}">
					<p class="admin-form__hint">비밀번호를 바꾸지 않으려면 비워 두세요.</p>
				</c:if>
			</div>
			<div class="admin-form__row">
				<label for="beforeName">이름</label>
				<input id="afterName" type="hidden" value="${udto.userName}" >
				<input id="beforeName" name="userName" type="text" maxlength="20" value="${udto.userName}" placeholder="이름 (20자 이내)">
			</div>
			<div class="admin-form__row">
				<label for="beforeBirth">생년월일</label>
				<input id="afterBirth" type="hidden" value="${udto.userBirth}">
				<input id="beforeBirth" name="userBirth" type="date" value="${udto.userBirth}">
			</div>
			<div class="admin-form__row">
				<label for="beforePhone">연락처</label>
				<input id="afterPhone" type="hidden" value="${udto.userPhone}">
				<input id="beforePhone" name="userPhone" type="text" maxlength="15" value="${udto.userPhone}" placeholder="010-0000-0000">
			</div>
			<div class="admin-form__row">
				<label for="userEmail">이메일</label>
				<c:if test="${not empty udto}">
					<input id="afterEmail" type="hidden" value="${udto.userEmail}">
				</c:if>
				<input id="userEmail" name="userEmail" type="text" maxlength="30" value="${udto.userEmail}" placeholder="이메일 (없으면 비워 두세요)">
			</div>
			<c:if test="${not empty udto}">
				<div class="admin-form__row">
				<input id="afterDelete" type="hidden" value="${udto.userDelete}">
					<label for="beforeDelete">상태</label>
					<select id="beforeDelete" name="userDelete">
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
						<input type="hidden" name="btn" id="btn" value="">
						<button type="button" onclick="updateUser()">수정</button>
						<c:if test="${udto.userId != 'admin'}">
							<button type="button" class="is-danger" onclick="deleteUser()">탈퇴</button>
						</c:if>
					</c:otherwise>
				</c:choose>
			</div>
		</form>
	</div>
</section>

<script>
	function updateUser() {
		let form = document.userForm;

		let afterDelete = document.getElementById("afterDelete").value;
		let beforeDelete = document.getElementById("beforeDelete").value;
		let afterName = document.getElementById("afterName").value;
		let beforeName = document.getElementById("beforeName").value;
		let afterBirth = document.getElementById("afterBirth").value;
		let beforeBirth = document.getElementById("beforeBirth").value;
		let afterPhone = document.getElementById("afterPhone").value;
		let beforePhone = document.getElementById("beforePhone").value;
		let afterEmail = document.getElementById("afterEmail").value;
		let beforeEmail = document.getElementById("userEmail").value;
		let beforePw = document.getElementById("beforePw").value;

		if(	afterDelete == beforeDelete
			&&  afterName == beforeName
			&&	afterBirth == beforeBirth
			&&	afterPhone == beforePhone
			&&	afterEmail == beforeEmail
			&&	beforePw.trim() == ""
		) {
			alert("수정된 값이 없습니다.");
			form.userPhone.focus();
			return;
		} else if (confirm('수정을 완료하시겠습니까?')) {
		    document.getElementById("btn").value = "upd";
		    form.submit();
		}
	}

	function deleteUser() {
		if (confirm('이 회원을 탈퇴 처리할까요?')) {
			document.getElementById("btn").value = "del";
			document.userForm.submit();
		}
	}
</script>
