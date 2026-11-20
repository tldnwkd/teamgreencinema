<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

    <main id="main">
      <section class="auth-page">
        <div class="auth-card auth-card--wide">
          <p class="tiny-eyebrow" style="text-align:center">JOIN GREEN CINEMA</p>
          <h1 class="auth-card__title">회원가입</h1>
          <p class="auth-card__subtitle">회원 가입에 필요한 정보를 입력하세요.</p>

          <c:if test="${not empty msg}">
            <div class="auth-modal" role="alertdialog" aria-modal="true" aria-labelledby="joinMsg">
              <div class="auth-modal__card">
                <p id="joinMsg"><c:out value="${msg}" /></p>
                <button type="button" class="btn btn--primary" onclick="this.closest('.auth-modal').remove()">확인</button>
              </div>
            </div>
          </c:if>
          
          <div class="demo-note">
            <span class="demo-note__dot" aria-hidden="true"></span>회원가입
          </div>

          <form id="joinForm" action="UserJoinProc.do" method="post" onsubmit="return validateJoinForm();">
            <div class="form-grid">
              <div class="form-group">
                <label class="form-label" for="userId">아이디 <span class="form-label__required">*</span></label>
                <input id="userId" class="form-control" name="userId" value="<c:out value='${userId}'/>" placeholder="아이디를 입력하세요.">
              </div>
              <div class="form-group">
                <label class="form-label" for="userName">이름 <span class="form-label__required">*</span></label>
                <input id="userName" class="form-control" name="userName" value="<c:out value='${userName}'/>" placeholder="이름">
              </div>
              <div class="form-group">
                <label class="form-label" for="userPw">비밀번호 <span class="form-label__required">*</span></label>
                <input type="password" id="userPw" class="form-control" name="userPw" placeholder="비밀번호">
              </div>
              <div class="form-group">
                <label class="form-label" for="userPwChk">비밀번호 확인 <span class="form-label__required">*</span></label>
                <input type="password" id="userPwChk" class="form-control" name="userPwChk" placeholder="비밀번호 확인">
              </div>
              <div class="form-group">
                <label class="form-label" for="userBirth">생년월일 <span class="form-label__required">*</span></label>
                <input type="date" id="userBirth" class="form-control" name="userBirth" value="<c:out value='${userBirth}'/>">
              </div>
              <div class="form-group">
                <label class="form-label" for="userPhone">휴대폰번호 <span class="form-label__required">*</span></label>
                <input type="tel" id="userPhone" class="form-control" name="userPhone" value="<c:out value='${userPhone}'/>" placeholder="010-0000-0000">
              </div>
              <div class="form-group form-group--full">
                <label class="form-label" for="userEmail">이메일 <span class="form-label__required">*</span></label>
                <input type="email" id="userEmail" class="form-control" name="userEmail" value="<c:out value='${userEmail}'/>" placeholder="example@email.com">
              </div>
            </div>
            <button type="submit" class="btn btn--primary btn--large btn--block">회원가입</button>
          </form>

          <div class="auth-links">
            <a href="index.jsp?section=user/login.jsp">이미 계정이 있나요? 로그인</a>
          </div>
        </div>
      </section>
    </main>

    <script>
      function validateJoinForm() {
        const fields = [
          { el: document.getElementById("userId"), message: "아이디를 입력하세요." },
          { el: document.getElementById("userName"), message: "이름을 입력하세요." },
          { el: document.getElementById("userPw"), message: "비밀번호를 입력하세요." },
          { el: document.getElementById("userPwChk"), message: "비밀번호 확인을 입력하세요." },
          { el: document.getElementById("userBirth"), message: "생년월일을 선택하세요." },
          { el: document.getElementById("userPhone"), message: "휴대폰번호를 입력하세요." },
          { el: document.getElementById("userEmail"), message: "이메일을 입력하세요." }
        ];

        for (let i = 0; i < fields.length; i++) {
          const item = fields[i];
          if (!item.el || item.el.value.trim() === "") {
            alert(item.message);
            if (item.el) {
              item.el.focus();
            }
            return false;
          }
        }

        const pw = document.getElementById("userPw");
        const pwChk = document.getElementById("userPwChk");
        if (pw.value !== pwChk.value) {
          alert("비밀번호가 일치하지 않습니다.");
          pwChk.focus();
          return false;
        }
        
        const phoneEl = document.getElementById("userPhone");
        const phoneDigits = phoneEl.value.replace(/[^0-9]/g, "");
        if (!/^010\d{8}$/.test(phoneDigits)) {
          alert("휴대폰번호는 010으로 시작하는 11자리 숫자로 입력하세요.");
          phoneEl.focus();
          return false;
        }

        return true;
      }
      
      
    </script>