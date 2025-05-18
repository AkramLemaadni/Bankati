<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
	var ctx = request.getContextPath();
	var connectedUser = (ma.bankati.model.users.User) session.getAttribute("connectedUser");
%>


<html>
<head>
	<title>Utilisateurs</title>
	<link rel="stylesheet" href="<%= ctx %>/assets/css/bootstrap.min.css">
	<link rel="stylesheet" href="<%= ctx %>/assets/css/bootstrap-icons.css">
	<link rel="stylesheet" href="<%= ctx %>/assets/css/style.css">
	<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
	<style>
		body {
			min-height: 100vh;
			background: linear-gradient(135deg, #232526 0%, #414345 100%);
			font-family: 'Poppins', Arial, sans-serif;
		}
		.container, .main-card, .form-section-dark {
			background: #181a1b !important;
			color: #fff;
			border-radius: 2rem;
			box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.2);
		}
		.navbar, .footer-navbar {
			font-family: 'Poppins', Arial, sans-serif;
			background: #181a1b !important;
		}
		.navbar-brand strong {
			color: #4fc3f7 !important;
			font-family: 'Poppins', Arial, sans-serif;
			font-weight: 600;
			letter-spacing: 1px;
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
		.footer-navbar {
			background: #181a1b !important;
		}
		.footer-navbar .text-muted, .footer-navbar .blue {
			color: #4fc3f7 !important;
		}
		.blue {
			color: #4fc3f7 !important;
		}
		.text-danger {
			color: #ff5252 !important;
		}
		.text-primary {
			color: #4fc3f7 !important;
		}
		.table {
			color: #fff;
			background: #232526;
		}
		.table thead {
			background: #232526;
			color: #4fc3f7;
		}
		.table-bordered th, .table-bordered td {
			border-color: #2c2c2c;
		}
		.input-group-text, .form-control, .form-select {
			background: #232526 !important;
			border-color: #2c2c2c;
			color: #fff !important;
		}
		.form-control::placeholder {
			color: #666;
		}
	</style>
</head>
<body class="Optima bgBlue">


<h1></h1>
<!-- ✅ NAVBAR -->
<nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm">
	<div class="container-fluid">
		<!-- Logo & Brand -->
		<a class="navbar-brand d-flex align-items-center" href="<%= ctx %>/home">
            <img src="<%= ctx %>/assets/img/logoBank.png" alt="Logo" width="40" height="40" class="d-inline-block align-text-top me-2">
			<strong class="blue ml-1"><%=application.getAttribute("AppName")%></strong>
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
					<a class="nav-link text-primary fw-bold" href="<%= ctx %>/users">
						<i class="bi bi-people-fill me-1"></i> Utilisateurs
					</a>
				</li>
				<li class="nav-item">
					<a class="nav-link text-primary fw-bold" href="<%= ctx %>/users">
						<i class="bi bi-people-fill me-1"></i> Demande credit
					</a>
				</li>
			</ul>
		</div>

		<!-- Infos session avec sous-menu -->
		<div class="dropdown d-flex align-items-center">
			<a class="btn btn-sm btn-light border dropdown-toggle text-success fw-bold"
			   href="#" role="button" id="dropdownSessionMenu" data-bs-toggle="dropdown" aria-expanded="false">
				<i class="bi bi-person-circle me-1"></i> <b><%= connectedUser.getRole() %></b> : <i><%= connectedUser.getFirstName() + " " + connectedUser.getLastName() %></i>
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


<!-- ✅ CONTENU PRINCIPAL -->
<div class="container w-75 mt-5 mb-5 p-4 rounded-3 shadow-sm border border-light">
	<h4 class="text-center text-primary mb-4">Liste des Utilisateurs</h4>

	<table class="table table-hover table-bordered text-center">
		<thead class="table-light blue">
		<tr>
			<th class="text-center">Nom</th>
			<th class="text-center">Prénom</th>
			<th class="text-center">Login</th>
			<th class="text-center">Rôle</th>
			<th class="text-center">Actions</th>
		</tr>
		</thead>
		<tbody class="bold">

		<c:forEach items="${users}" var="user">
			<tr>
				<td>${user.lastName}</td>
				<td>${user.firstName}</td>
				<td>${user.username}</td>
				<td>${user.role}</td>
				<td>
					<a href="${pageContext.request.contextPath}/users/edit?id=${user.id}" class="btn btn-outline-warning btn-sm me-1">
						<i class="bi bi-pencil-fill"></i>
					</a>
					<a href="${pageContext.request.contextPath}/users/delete?id=${user.id}" class="btn btn-outline-danger btn-sm">
						<i class="bi bi-trash-fill"></i>
					</a>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>

	<!-- ✅ FORMULAIRE ENCADRÉ -->
	<div class="form-section-dark border border-primary rounded-4 p-4 mt-5 mb-5 shadow-sm w-75 mx-auto">

		<h5 class="text-center bold blue">
			<c:choose>
				<c:when test="${not empty user}">Modifier un utilisateur</c:when>
				<c:otherwise>Ajouter un nouveau utilisateur</c:otherwise>
			</c:choose>
		</h5>

		<!-- ✅ Bouton visible uniquement si on est en modification -->
		<c:if test="${not empty user}">
			<div class="text-center mb-3">
				<a href="${pageContext.request.contextPath}/users" class="btn btn-outline-primary btn-sm fw-bold">
					<i class="bi bi-person-plus-fill me-1"></i> Ajouter un nouvel utilisateur
				</a>
			</div>
		</c:if>

		<form action="${pageContext.request.contextPath}/users/save" method="post" class="mt-3">
			<input type="hidden" name="id" value="${user.id}"/>

			<!-- Prénom -->
			<div class="mb-3">
				<div class="input-group align-items-center">
				<span class="input-group-text">
					<i class="bi bi-person-badge text-primary" style="font-size: 1.2rem; margin-right: 6px;"></i>
				</span>
					<input type="text" class="form-control bold" name="firstName" placeholder="Prénom" value="${user.firstName}"/>
				</div>
			</div>

			<!-- Nom -->
			<div class="mb-3">
				<div class="input-group align-items-center">
				<span class="input-group-text">
					<i class="bi bi-person text-primary" style="font-size: 1.2rem; margin-right: 6px;"></i>
				</span>
					<input type="text" class="form-control bold" name="lastName" placeholder="Nom" value="${user.lastName}"/>
				</div>
			</div>

			<!-- Nom d'utilisateur -->
			<div class="mb-3">
				<div class="input-group align-items-center">
				<span class="input-group-text">
					<i class="bi bi-person-circle text-primary" style="font-size: 1.2rem; margin-right: 6px;"></i>
				</span>
					<input type="text" class="form-control bold" name="username" placeholder="Nom d'utilisateur" value="${user.username}"/>
				</div>
			</div>

			<!-- Mot de passe -->
			<div class="mb-3">
				<div class="input-group align-items-center">
				<span class="input-group-text">
					<i class="bi bi-lock-fill text-primary" style="font-size: 1.2rem; margin-right: 6px;"></i>
				</span>
					<input type="password" class="form-control bold" name="password" placeholder="Mot de passe" value="${user.password}"/>
				</div>
			</div>

			<!-- Rôle -->
			<div class="mb-4">
				<div class="input-group align-items-center">
				<span class="input-group-text">
					<i class="bi bi-shield-lock text-primary" style="font-size: 1.2rem; margin-right: 6px;"></i>
				</span>
					<select name="role" class="form-select bold">
						<option value="ADMIN" ${user.role == 'ADMIN' ? 'selected' : ''}>ADMIN</option>
						<option value="CLIENT" ${user.role == 'CLIENT' ? 'selected' : ''}>CLIENT</option>
					</select>
				</div>
			</div>

			<!-- Bouton Enregistrer -->
			<div class="text-center">
				<button type="submit" class="btn btn-outline-success font-weight-bold">
					<i class="bi bi-save me-1"></i> Enregistrer
				</button>
			</div>
		</form>
	</div>

</div>

<!-- ✅ FOOTER -->
<nav class="navbar footer-navbar fixed-bottom shadow-sm">
	<div class="container d-flex justify-content-between align-items-center w-100">
		<span class="text-muted small"><b class="blue"><i class="bi bi-house-door me-1"></i> Akram's Bank 2025 </b>– © Tous droits réservés</span>
	</div>
</nav>



</body>
</html>
