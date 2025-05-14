<%@ page import="ma.bankati.model.users.User" pageEncoding="UTF-8" %>
<html>
<head>
	<title>H O M E</title>
	<link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/bootstrap.min.css">
	<link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/style.css">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<%
	var user = (User) session.getAttribute("connectedUser");
	var appName = (String) application.getAttribute("AppName");
	var ctx = request.getContextPath();
%>
<body class="bgBlue Optima">

<!-- ✅ NAVBAR (updated to match the second version) -->
<nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm">
	<div class="container-fluid">
		<!-- Logo & Brand -->
		<a class="navbar-brand d-flex align-items-center" href="<%= ctx %>/home">
			<img src="<%= ctx %>/assets/img/logoBlue.png" alt="Logo" width="40" height="40" class="d-inline-block align-text-top me-2">
			<strong class="blue ml-1"><%= appName %></strong>
		</a>

		<!-- Menu de navigation -->
		<div class="collapse navbar-collapse">
			<ul class="navbar-nav me-auto mb-2 mb-lg-0">
				<li class="nav-item">
					<a class="nav-link text-primary fw-bold" href="<%= ctx %>/home">
						<i class="bi bi-house-door me-1"></i> Accueil
					</a>
				</li>
				<li class="nav-item">
					<a class="nav-link text-primary fw-bold" href="<%= ctx %>/credit">
						<i class="bi bi-cash-stack me-1"></i> Crédit
					</a>
				</li>
			</ul>
		</div>

		<!-- Infos session avec sous-menu -->
		<div class="dropdown d-flex align-items-center">
			<a class="btn btn-sm btn-light border dropdown-toggle text-success fw-bold"
			   href="#" role="button" id="dropdownSessionMenu" data-bs-toggle="dropdown" aria-expanded="false">
				<i class="bi bi-person-circle me-1"></i> <b><%= user.getRole() %></b> : <i><%= user.getFirstName() + " " + user.getLastName() %></i>
			</a>
			<ul class="dropdown-menu dropdown-menu-end" aria-labelledby="dropdownSessionMenu">
				<li><hr class="dropdown-divider"></li>
				<li>
					<a class="dropdown-item text-primary Profile-btn fw-bold" href="<%= ctx %>/profile">
						<i class="bi bi-person-circle me-1"></i> <b>Votre Profile</b>
					</a>
					<a class="dropdown-item text-danger logout-btn fw-bold" href="<%= ctx %>/logout">
						<i class="bi bi-box-arrow-right me-1"></i> <b>Déconnexion</b>
					</a>
				</li>
			</ul>
		</div>
	</div>
</nav>

<div class="container w-50 bg-white mt-5 border border-light rounded-circle mb-5">
	<div class="card-body text-center">
		<h1 class="mt-4 mb-3 text-danger font-weight-bold text-capitalize">
			Page publique
		</h1>
	</div>
</div>

<!-- ✅ FOOTER FIXÉ EN BAS -->
<nav class="navbar footer-navbar fixed-bottom bg-white">
	<div class="container d-flex justify-content-between align-items-center w-100">
        <span class="text-muted small">
            © <%= appName %> 2025 – Tous droits réservés
        </span>
	</div>
</nav>
</body>
</html>