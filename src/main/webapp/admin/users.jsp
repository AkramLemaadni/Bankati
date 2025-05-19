<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
	var ctx = request.getContextPath();
	var connectedUser = (ma.bankati.model.users.User) session.getAttribute("connectedUser");
    var appName = (String) application.getAttribute("AppName");
%>

<!DOCTYPE html>
<html lang="fr">
<head>
	<meta charset="UTF-8">
	<title>Gestion des Utilisateurs - <%= appName %></title>
	<link rel="stylesheet" href="<%= ctx %>/assets/css/bootstrap.min.css">
	<link rel="stylesheet" href="<%= ctx %>/assets/css/bootstrap-icons.css">
	<link rel="stylesheet" href="<%= ctx %>/assets/css/style.css">
	<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
	<style>
		body {
			min-height: 100vh;
			margin: 0;
			font-family: 'Poppins', sans-serif;
			background: linear-gradient(135deg, #232526 0%, #414345 100%);
			color: #fff;
		}
		.sidebar {
			width: 250px;
			height: 100vh;
			background-color: #181a1b;
			position: fixed;
			top: 0;
			left: 0;
			padding: 2rem 1rem;
		}
		.sidebar .nav-link {
			color: #fff;
			margin: 0.5rem 0;
			font-weight: 500;
		}
		.sidebar .nav-link:hover, .sidebar .nav-link.active {
			background-color: #242627;
			border-radius: 0.5rem;
			color: #4fc3f7 !important;
		}
		.sidebar .logo {
			font-size: 1.5rem;
			font-weight: 600;
			color: #4fc3f7;
		}
		.main-content {
			margin-left: 250px;
			padding: 2rem;
		}
		.main-card {
			background: #181a1b;
			border-radius: 1.5rem;
			padding: 2rem;
			box-shadow: 0 8px 32px rgba(0, 0, 0, 0.2);
			margin-bottom: 3rem;
		}
		.form-section-dark {
			background: #212529;
			border-radius: 1.5rem;
			padding: 2rem;
			margin-top: 2rem;
			border: 1px solid #4fc3f7;
		}
		.table {
			color: #fff;
			background: #232526;
			border-radius: 1rem;
			overflow: hidden;
		}
		.table thead {
			background: #181a1b;
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
		.btn-outline-warning {
			border-color: #ffc107;
			color: #ffc107;
		}
		.btn-outline-warning:hover {
			background-color: #ffc107;
			color: #212529;
		}
		.btn-outline-danger {
			border-color: #ff5252;
			color: #ff5252;
		}
		.btn-outline-danger:hover {
			background-color: #ff5252;
			color: #fff;
		}
		.btn-outline-success {
			border-color: #43a047;
			color: #43a047;
		}
		.btn-outline-success:hover {
			background-color: #43a047;
			color: #fff;
		}
		.btn-outline-primary {
			border-color: #4fc3f7;
			color: #4fc3f7;
		}
		.btn-outline-primary:hover {
			background-color: #4fc3f7;
			color: #fff;
		}
		.text-primary {
			color: #4fc3f7 !important;
		}
		.text-danger {
			color: #ff5252 !important;
		}
		.alert-wrapper {
			position: fixed;
			top: 20px;
			left: 250px;
			width: calc(100% - 270px);
			z-index: 1000;
		}
		footer {
			position: fixed;
			bottom: 0;
			left: 250px;
			width: calc(100% - 250px);
			background-color: #181a1b;
			text-align: center;
			padding: 0.75rem;
			font-size: 0.9rem;
		}
		.admin-badge {
			background-color: #4fc3f7;
			color: white;
			font-size: 0.7rem;
			padding: 0.2rem 0.5rem;
			border-radius: 0.5rem;
			margin-left: 0.5rem;
			font-weight: bold;
			letter-spacing: 0.05rem;
		}
	</style>
</head>
<body>

<!-- ✅ SIDEBAR -->
<div class="sidebar d-flex flex-column">
    <div class="mb-4 text-center">
		<img src="<%= ctx %>/assets/img/logoBank.png" width="40" class="mb-2" alt="Logo">
		<div class="logo"><%= appName %> <span class="admin-badge">ADMIN</span></div>
    </div>
    <nav class="nav flex-column">
        <a class="nav-link" href="<%= ctx %>/home">
            <i class="bi bi-house-door me-2"></i> Accueil
        </a>
        <a class="nav-link active" href="<%= ctx %>/users">
            <i class="bi bi-people-fill me-2"></i> Utilisateurs
        </a>
        <a class="nav-link" href="<%= ctx %>/credit">
            <i class="bi bi-cash-stack me-2"></i> Demande Crédit
        </a>
        <hr class="border-secondary">
        <div class="dropdown">
            <a class="nav-link dropdown-toggle text-success" href="#" data-bs-toggle="dropdown">
                <i class="bi bi-person-circle me-2"></i>
                <%= connectedUser.getRole() %>: <%= connectedUser.getFirstName() %>
            </a>
            <ul class="dropdown-menu dropdown-menu-dark">
                <li><a class="dropdown-item" href="<%= ctx %>/profile"><i class="bi bi-person me-2"></i>Votre Profil</a></li>
                <li><a class="dropdown-item text-danger" href="<%= ctx %>/logout"><i class="bi bi-box-arrow-right me-2"></i>Déconnexion</a></li>
            </ul>
        </div>
    </nav>
</div>

<!-- ✅ MAIN CONTENT -->
<div class="main-content">
	<div class="main-card">
		<h4 class="text-center text-primary mb-4">Liste des Utilisateurs</h4>

		<div class="table-responsive">
			<table class="table table-hover table-bordered text-center">
				<thead>
				<tr>
					<th class="text-center text-primary">Nom</th>
					<th class="text-center text-primary">Prénom</th>
					<th class="text-center text-primary">Login</th>
					<th class="text-center text-primary">Rôle</th>
					<th class="text-center text-primary">Actions</th>
				</tr>
				</thead>
				<tbody>
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
				<c:if test="${empty users}">
					<tr>
						<td colspan="5" class="text-center py-4">
							<i class="bi bi-info-circle me-2"></i> Aucun utilisateur trouvé
						</td>
					</tr>
				</c:if>
				</tbody>
			</table>
		</div>

		<!-- ✅ FORMULAIRE UTILISATEUR -->
		<div class="form-section-dark mt-4">
			<h5 class="text-center text-primary mb-4">
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
</div>

<!-- ✅ FOOTER -->
<footer>
    <span class="text-muted">
        <i class="bi bi-house-door me-1"></i> <b class="text-primary"><%= appName %></b> – © 2025 Tous droits réservés
    </span>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
