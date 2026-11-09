<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<section id="my-profile" class="mypage-section">
  <div class="section-header">
    <h2 class="section-title">내 정보 수정</h2>
  </div>

  <div class="profile-card">
    <form id="userUpdateForm" action="${pageContext.request.contextPath}/UserUpdateProc.do" method="post" name="userForm">
      
      <!-- 회원 아이디 (PK - 수정 불가) -->
      <div class="form-group">
        <label for="userId" class="form-label">아이디</label>
        <input type="text" id="userId" name="userId" class="form-input is-readonly" 
               value="${userInfo.userId}" readonly>
        <span class="form-help">아이디는 변경할 수 없습니다.</span>
      </div>

      <!-- 이름 -->
      <div class="form-group">
        <label for="userName" class="form-label">이름 <span class="required">*</span></label>
        <input type="text" id="userName" name="userName" class="form-input" 
               value="${userInfo.userName}" maxlength="20" required>
      </div>

      <!-- 생년월일 -->
      <div class="form-group">
        <label for="userBirth" class="form-label">생년월일 <span class="required">*</span></label>
        <input type="date" id="userBirth" name="userBirth" class="form-input" 
               value="${userInfo.userBirth}" required>
      </div>

      <!-- 이메일 -->
      <div class="form-group">
        <label for="userEmail" class="form-label">이메일</label>
        <input type="email" id="userEmail" name="userEmail" class="form-input" 
               value="${userInfo.userEmail}" maxlength="20" placeholder="example@green.com">
      </div>

      <!-- 휴대폰 번호 -->
      <div class="form-group">
        <label for="userPhone" class="form-label">휴대폰 번호 <span class="required">*</span></label>
        <input type="tel" id="userPhone" name="userPhone" class="form-input" 
               value="${userInfo.userPhone}" maxlength="15" placeholder="010-0000-0000" required>
      </div>

      <hr class="form-divider">

      <!-- 새 비밀번호 -->
      <div class="form-group">
        <label for="userPw" class="form-label">비밀번호 (변경 시 입력) <span class="required">*</span></label>
        <input type="password" id="userPw" name="userPw" class="form-input" 
               maxlength="15" placeholder="변경할 때만 입력하세요">
      </div>

      <!-- 새 비밀번호 확인 -->
      <div class="form-group">
        <label for="userPwConfirm" class="form-label">비밀번호 확인 <span class="required">*</span></label>
        <input type="password" id="userPwConfirm" class="form-input" 
               maxlength="15" placeholder="비밀번호를 한 번 더 입력하세요">
        <span id="pwMatchMsg" class="form-help"></span>
      </div>

      <!-- 하단 버튼 영역 (수정 저장 / 회원 탈퇴) -->
      <div class="profile-actions">
        <button type="button" class="btn btn--danger-outline" onclick="confirmWithdraw();">회원 탈퇴</button>
        <div class="profile-actions__right">
          <button type="reset" class="btn btn--outline">초기화</button>
          <button type="submit" class="btn btn--primary">정보 수정 완료</button>
        </div>
      </div>
    </form>

    <!-- 회원 탈퇴 처리용 히든 폼 (user_delete = 1 소프트 삭제 요청용) -->
    <form id="userWithdrawForm" action="${pageContext.request.contextPath}/userDeleteProc.do" method="post">
      <input type="hidden" name="userId" value="${userInfo.userId}">
      <input type="hidden" name="userDelete" value="1">
    </form>
  </div>
</section>