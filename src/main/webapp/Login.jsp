<html>
  <head>
    <title>Login</title>
    
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/style.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
  
  </head>
  <body class="Optima bgBlue">

  <div class="container w-50 bg-white mt-5 border border-light rounded-circle">
    <br>
  <div class="card-header bg-white text-center border border-light rounded-circle w-75 mx-auto">
   
    <h1 class="blue font-weight-bold p-2">  <!-- Image de login centrée -->
      <img src="../assets/img/login.png" alt="Image de connexion"
		   class="img-fluid mt-2 mb-3" style="max-height: 60px;"> Bankati </h1>
  </div>
  <div class="card-body">
    <form action="login" method="post" autocomplete="off">
     
      <!-- Login field -->
      <div class="form-group">
        <div class="input-group-prepend">
              <span class="input-group-text bg-white border-end-0">
                <i class="bi bi-person-fill text-primary"></i>
              </span>
        </div>
        <input type="text"
               class="form-control w-75 mx-auto text-primary"
               name="lg"
               placeholder="Nom d'utilisateur"
               autocomplete="off">
              <!-- Affichage de l'erreur pour le champ username -->
              <div class="w-75 mx-auto">
                <label class="text-danger d-block font-italic small">
                  <%= request.getAttribute("usernameError") != null ? request.getAttribute("usernameError") : "" %>
                </label>
              </div>
      </div>
      
      <!-- Password field -->
      <div class="form-group">
        <input type="password"
               class="form-control w-75 mx-auto  text-primary"
               name="pss"
               placeholder="Mot de passe"
               autocomplete="off">
              <!-- Affichage de l'erreur pour le champ password -->
              <div class="w-75 mx-auto">
                <label class="text-danger  d-block font-italic small">
                  <%= request.getAttribute("passwordError") != null ? request.getAttribute("passwordError") : "" %>
                </label>
              </div>
              <% if (request.getAttribute("globalMessage") != null) { %>
              <div class="alert alert-info w-75 mx-auto text-center text-danger">
                <%= request.getAttribute("globalMessage") %>
              </div>
              <% } %>
      
      </div>
      <br>
      <div class="form-group">
        <input type="submit"
               value="Se connecter"
               class="btn btn-outline-primary btn-block w-50 mx-auto font-weight-bold">
      </div>
      <br>
      
    </form>
  </div>
  </div>
  
  </body>
</html>
