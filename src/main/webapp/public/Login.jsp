<%@ page pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<html>
<head>
  <title>Login</title>
  <c:url value="/assets/css/bootstrap.min.css" var="bootstrapCss" />
  <c:url value="/assets/css/style.css" var="styleCss" />
  <c:url value="/assets/css/bootstrap-icons.css" var="iconsCss" />
  <link rel="stylesheet" href="${bootstrapCss}">
  <link rel="stylesheet" href="${styleCss}">
  <link rel="stylesheet" href="${iconsCss}">
  <!-- Google Fonts: Poppins -->
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
  <style>
    body {
      min-height: 100vh;
      background: linear-gradient(135deg, #232526 0%, #414345 100%);
      display: flex;
      align-items: center;
      justify-content: center;
      font-family: 'Poppins', Arial, sans-serif;
    }
    .login-card {
      border: none;
      border-radius: 1.5rem;
      box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.2);
      background: #181a1b;
      padding: 2.5rem 2rem 2rem 2rem;
      width: 100%;
      max-width: 400px;
      font-family: 'Poppins', Arial, sans-serif;
    }
    .login-logo {
      width: 70px;
      height: 70px;
      object-fit: contain;
      margin-bottom: 1rem;
      filter: drop-shadow(0 0 8px #007bff88);
    }
    .login-title {
      font-family: 'Poppins', Arial, sans-serif;
      color: #4fc3f7;
      font-weight: 600;
      margin-bottom: 0.5rem;
      letter-spacing: 1px;
    }
    .form-control, .input-group-text {
      background: #232526;
      color: #fff;
      border: 1px solid #333;
      font-family: 'Poppins', Arial, sans-serif;
    }
    .form-control:focus {
      border-color: #4fc3f7;
      box-shadow: 0 0 0 0.2rem rgba(79,195,247,.15);
      background: #232526;
      color: #fff;
    }
    .input-group-text {
      border-right: none;
      background: #232526;
      /* Move logo down */
      display: flex;
      align-items: flex-end;
      padding-bottom: 8px;
    }
    .username-logo, .password-logo {
      width: 24px;
      height: 24px;
      margin-bottom: 2px;
      opacity: 0.85;
    }
    .form-control::placeholder {
      color: #b0b3b8;
      font-family: 'Poppins', Arial, sans-serif;
    }
    .login-btn {
      font-weight: 600;
      letter-spacing: 1px;
      background: #007bff;
      border: none;
      font-family: 'Poppins', Arial, sans-serif;
    }
    .login-btn:hover {
      background: #0056b3;
    }
    /* Redesigned error and confirm messages */
    .custom-error {
      background: #e53935;
      color: #fff;
      border-radius: 0.5rem;
      padding: 0.5rem 1rem;
      margin-top: 0.5rem;
      font-size: 0.97em;
      display: flex;
      align-items: center;
      gap: 0.5em;
      box-shadow: 0 2px 8px 0 rgba(229,57,53,0.08);
    }
    .custom-success {
      background: #43a047;
      color: #fff;
      border-radius: 0.5rem;
      padding: 0.5rem 1rem;
      margin-top: 0.5rem;
      font-size: 0.97em;
      display: flex;
      align-items: center;
      gap: 0.5em;
      box-shadow: 0 2px 8px 0 rgba(67,160,71,0.08);
    }
    .text-muted {
      color: #b0b3b8 !important;
    }
  </style>
</head>
<body>
<div class="login-card mx-auto">
  <div class="text-center">
    <img src="${ctx}/assets/img/user.png" class="login-logo" alt="Login Logo">
    <h2 class="login-title">${AppName}</h2>
    <p class="text-muted mb-4" style="font-size:1.1em;">Connectez-vous à votre espace sécurisé</p>
  </div>
  <form action="login" method="post" autocomplete="off">
    <div class="mb-3">
      <div class="input-group">
        <span class="input-group-text">
          <img src="${ctx}/assets/img/username.png" class="username-logo" alt="Username Logo">
        </span>
        <input type="text"
               class="form-control"
               name="lg"
               placeholder="Nom d'utilisateur"
               required>
      </div>
      <c:if test="${not empty usernameError}">
        <div class="custom-error">
          <i class="bi bi-exclamation-triangle-fill"></i>
            ${usernameError}
        </div>
      </c:if>
    </div>
    <div class="mb-3">
      <div class="input-group">
        <span class="input-group-text">
          <img src="${ctx}/assets/img/password.png" class="password-logo" alt="Password Logo">
        </span>
        <input type="password"
               class="form-control"
               name="pss"
               placeholder="Mot de passe"
               required>
      </div>
      <c:if test="${not empty passwordError}">
        <div class="custom-error">
          <i class="bi bi-exclamation-triangle-fill"></i>
            ${passwordError}
        </div>
      </c:if>
    </div>
    <c:if test="${not empty globalMessage}">
      <div class="custom-success text-center w-100 justify-content-center">
        <i class="bi bi-check-circle-fill"></i>
          ${globalMessage}
      </div>
    </c:if>
    <div class="d-grid mt-4">
      <input type="submit"
             value="Se Connecter"
             class="btn login-btn">
    </div>
  </form>
</div>
</body>
</html>