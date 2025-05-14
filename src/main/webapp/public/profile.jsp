<%@ page import="ma.bankati.model.users.ERole" %>
<%@page contentType="text/html;charset=UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    var ctx = request.getContextPath();
    var connectedUser = (ma.bankati.model.users.User) session.getAttribute("connectedUser");
%>

<html>
<head>
    <title>Mon Profile</title>
    <link rel="stylesheet" href="<%= ctx %>/assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%= ctx %>/assets/css/bootstrap-icons.css">
    <link rel="stylesheet" href="<%= ctx %>/assets/css/style.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        .profile-card {
            border-radius: 15px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }
        .profile-icon {
            font-size: 1.5rem;
            margin-right: 10px;
            color: #0d6efd;
        }
        .info-row {
            border-bottom: 1px solid #eee;
            padding: 15px 0;
        }
        .info-row:last-child {
            border-bottom: none;
        }
    </style>
</head>
<body class="Optima bgBlue">

<!-- NAVBAR (same as your users page) -->
<nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm">
    <div class="container-fluid">
        <a class="navbar-brand d-flex align-items-center" href="<%= ctx %>/home">
            <img src="<%= ctx %>/assets/img/logoBlue.png" alt="Logo" width="40" height="40" class="d-inline-block align-text-top me-2">
            <strong class="blue ml-1"><%=application.getAttribute("AppName")%></strong>
        </a>

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

<!-- MAIN CONTENT -->
<div class="container w-75 mt-5 mb-5 bg-white p-4 rounded-3 shadow-sm border border-light">
    <h4 class="text-center text-primary mb-4">Mon Profile</h4>

    <!-- PROFILE CARD -->
    <div class="profile-card bg-white p-4 mb-5">
        <!-- Profile Header -->
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h5 class="blue mb-0">Informations Personnelles</h5>
            </div>
        </div>

        <!-- Profile Information -->
        <div class="row info-row">
            <div class="col-md-3 d-flex align-items-center">
                <i class="bi bi-person-badge profile-icon"></i>
                <strong>Prénom:</strong>
            </div>
            <div class="col-md-9">
                <%= connectedUser.getFirstName() %>
            </div>
        </div>

        <div class="row info-row">
            <div class="col-md-3 d-flex align-items-center">
                <i class="bi bi-person profile-icon"></i>
                <strong>Nom:</strong>
            </div>
            <div class="col-md-9">
                <%= connectedUser.getLastName() %>
            </div>
        </div>

        <div class="row info-row">
            <div class="col-md-3 d-flex align-items-center">
                <i class="bi bi-person-circle profile-icon"></i>
                <strong>Nom d'utilisateur:</strong>
            </div>
            <div class="col-md-9">
                <%= connectedUser.getUsername() %>
            </div>
        </div>

        <div class="row info-row">
            <div class="col-md-3 d-flex align-items-center">
                <i class="bi bi-shield-lock profile-icon"></i>
                <strong>Rôle:</strong>
            </div>
            <div class="col-md-9">
                <span class="badge bg-<%= connectedUser.getRole() == ERole.ADMIN ? "primary" : "success" %>">
                    <%= connectedUser.getRole() %>
                </span>
            </div>
        </div>

        <div class="row info-row">
            <div class="col-md-3 d-flex align-items-center">
                <i class="bi bi-calendar-check profile-icon"></i>
                <strong>Date de création:</strong>
            </div>
            <div class="col-md-9">
                <%= connectedUser.getCreationDate() != null ?
                        connectedUser.getCreationDate().format(java.time.format.DateTimeFormatter.ofPattern("dd/MM/yyyy")) :
                        "N/A" %>
            </div>
        </div>
    </div>

    <!-- PASSWORD CHANGE SECTION -->
    <div class="border border-primary rounded-4 p-4 mt-5 mb-5 shadow-sm bg-white">
        <h5 class="text-center bold blue mb-4">Changer le mot de passe</h5>

        <form action="<%= ctx %>/profile/change-password" method="post" class="mt-3">
            <!-- Current Password -->
            <div class="mb-3">
                <div class="input-group align-items-center">
                    <span class="input-group-text bg-white">
                        <i class="bi bi-lock-fill text-primary" style="font-size: 1.2rem; margin-right: 6px;"></i>
                    </span>
                    <input type="password" class="form-control text-dark bold" name="currentPassword" placeholder="Mot de passe actuel" required/>
                </div>
            </div>

            <!-- New Password -->
            <div class="mb-3">
                <div class="input-group align-items-center">
                    <span class="input-group-text bg-white">
                        <i class="bi bi-key-fill text-primary" style="font-size: 1.2rem; margin-right: 6px;"></i>
                    </span>
                    <input type="password" class="form-control text-dark bold" name="newPassword" placeholder="Nouveau mot de passe" required/>
                </div>
            </div>

            <!-- Confirm New Password -->
            <div class="mb-4">
                <div class="input-group align-items-center">
                    <span class="input-group-text bg-white">
                        <i class="bi bi-key text-primary" style="font-size: 1.2rem; margin-right: 6px;"></i>
                    </span>
                    <input type="password" class="form-control text-dark bold" name="confirmPassword" placeholder="Confirmer le nouveau mot de passe" required/>
                </div>
            </div>

            <!-- Submit Button -->
            <div class="text-center">
                <button type="submit" class="btn btn-outline-success font-weight-bold">
                    <i class="bi bi-save me-1"></i> Enregistrer les modifications
                </button>
            </div>
        </form>
    </div>
</div>

<!-- FOOTER (same as your users page) -->
<nav class="navbar footer-navbar fixed-bottom bg-white shadow-sm">
    <div class="container d-flex justify-content-between align-items-center w-100">
        <span class="text-muted small"><b class="blue"><i class="bi bi-house-door me-1"></i> Bankati 2025 </b>– © Tous droits réservés</span>
    </div>
</nav>

</body>
</html>