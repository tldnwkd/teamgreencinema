<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<section id="my-withdraw" class="mypage-section">
  <div class="section-header">
    <h2 class="section-title">회원 탈퇴</h2>
  </div>

  <div class="profile-card">
    <p class="withdraw-block__help">탈퇴하면 이 계정으로 다시 로그인할 수 없습니다. 비밀번호를 입력한 뒤 탈퇴를 진행합니다.</p>

    <form id="userWithdrawForm" action="${pageContext.request.contextPath}/UserDeleteProc.do" method="post">
      <div class="form-group">
        <label for="deletePw" class="form-label">비밀번호 확인 <span class="required">*</span></label>
        <input type="password" id="deletePw" name="userPw" class="form-input"
               maxlength="15" autocomplete="current-password" required>
      </div>
      <div class="profile-actions profile-actions--end">
        <button type="submit" class="btn btn--danger-outline">회원 탈퇴</button>
      </div>
    </form>
  </div>
</section>
<script>
(function () {
  var form = document.getElementById("userWithdrawForm");
  if (!form) return;

  form.addEventListener("submit", function (event) {
    var password = document.getElementById("deletePw");
    if (!password.value) {
      event.preventDefault();
      return;
    }
    if (!window.confirm("정말 탈퇴하시겠습니까? 탈퇴 후에는 이 계정으로 로그인할 수 없습니다.")) {
      event.preventDefault();
    }
  });
})();
</script>
