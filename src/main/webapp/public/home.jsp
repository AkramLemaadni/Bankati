<%@ page import="ma.bankati.model.users.User" pageEncoding="UTF-8" %>
<html>
<head>
	<title>H O M E</title>
	<link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/bootstrap.min.css">
	<link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/style.css">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
	<!-- Google Fonts: Poppins -->
	<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
	<style>
		body {
			min-height: 100vh;
			background: linear-gradient(135deg, #232526 0%, #414345 100%);
			font-family: 'Poppins', Arial, sans-serif;
		}
		.main-card {
			border: none;
			border-radius: 2rem;
			box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.2);
			background: #181a1b;
			padding: 2.5rem 2rem 2rem 2rem;
			width: 100%;
			max-width: 500px;
			margin: 4rem auto 3rem auto;
			font-family: 'Poppins', Arial, sans-serif;
		}
		.main-card h1 {
			color: #ff5252;
			font-weight: 600;
			font-size: 2rem;
			letter-spacing: 1px;
		}
		.navbar, .footer-navbar {
			font-family: 'Poppins', Arial, sans-serif;
		}
		.navbar-brand strong {
			color: #4fc3f7 !important;
			font-family: 'Poppins', Arial, sans-serif;
			font-weight: 600;
			letter-spacing: 1px;
		}
		.dropdown-menu, .dropdown-item {
			font-family: 'Poppins', Arial, sans-serif;
		}
		.footer-navbar {
			background: #181a1b !important;
		}
		.footer-navbar .text-muted, .footer-navbar .blue {
			color: #4fc3f7 !important;
		}
		.rounded-circle {
			border-radius: 2rem !important;
		}
		.bg-white {
			background: #232526 !important;
		}
		.nav-link, .dropdown-item, .navbar-brand, .navbar {
			color: #fff !important;
		}
		.nav-link.text-primary, .dropdown-item.text-primary {
			color: #4fc3f7 !important;
		}
		.nav-link.text-danger, .dropdown-item.text-danger {
			color: #ff5252 !important;
		}
		.nav-link.text-success, .dropdown-toggle.text-success {
			color: #43a047 !important;
		}
		.nav-link.fw-bold, .dropdown-item.fw-bold {
			font-weight: 600 !important;
		}
		.navbar, .footer-navbar {
			box-shadow: 0 2px 8px 0 rgba(31, 38, 135, 0.08);
		}
	</style>
</head>
<%
	var user = (User) session.getAttribute("connectedUser");
	var appName = (String) application.getAttribute("AppName");
	var ctx = request.getContextPath();
%>
<body>

<!-- ✅ NAVBAR (updated to match the second version) -->
<nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm">
	<div class="container-fluid">
		<!-- Logo & Brand -->
		<a class="navbar-brand d-flex align-items-center" href="<%= ctx %>/home">
			<img src="<%= ctx %>/assets/img/logoBank.png" alt="Logo" width="40" height="40" class="d-inline-block align-text-top me-2">
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

<div class="main-card">
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