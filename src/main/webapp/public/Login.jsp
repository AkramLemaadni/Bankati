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
  </head>
  <body class="Optima bgBlue">

  <div class="container w-50 bg-white mt-5 border border-light rounded-circle">
    <br>
  <div class="card-header bg-white text-center border border-light rounded-circle w-75 mx-auto">
   
    <h1 class="blue font-weight-bold p-2">  <!-- Image de login centrée -->
      <img src="${ctx}/assets/img/login.png" class="img-fluid mt-2 mb-3" style="max-height: 60px;">
      <br>
      ${AppName}
    </h1>
  </div>
  <div class="card-body">
    <form action="login" method="post">
     
      <!-- Login field -->
      <div class="form-group">
        <input type="text"
               class="form-control w-75 mx-auto text-primary"
               name="lg"
               placeholder="Nom d'utilisateur">
              <!-- Affichage de l'erreur pour le champ username -->
              <div class="w-75 mx-auto">
                <label class="text-danger d-block font-italic small">
                  ${empty usernameError ? "" : usernameError}
                 </label>
              </div>
      </div>
      
      <!-- Password field -->
      <div class="form-group">
        <input type="password"
               class="form-control w-75 mx-auto  text-primary"
               name="pss"
               placeholder="Mot de passe">
              <!-- Affichage de l'erreur pour le champ password -->
              <div class="w-75 mx-auto">
                <label class="text-danger  d-block font-italic small">
                  ${empty passwordError ? "" : passwordError}
                </label>
              </div>
              <c:if test="${not empty globalMessage}">
                <div class="alert alert-info w-75 mx-auto text-center text-danger">
                    ${globalMessage}
                </div>
              </c:if>
      </div>
      <br>
      <div class="form-group">
        <input type="submit"
               value="Se Connecter"
               class="btn btn-outline-primary btn-block w-50 mx-auto font-weight-bold">
      </div>
      <br>
    </form>
  </div>
  </div>
  
  </body>
</html>
