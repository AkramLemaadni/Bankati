<%@ page import="ma.bankati.model.users.ERole" %>
<%@page contentType="text/html;charset=UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    var ctx = request.getContextPath();
    var connectedUser = (ma.bankati.model.users.User) session.getAttribute("connectedUser");
    var appName = (String) application.getAttribute("AppName");
%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <title>Mon Profil - <%= appName %></title>
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
            margin-bottom: 4rem;
        }
        .profile-card {
            background: #212529;
            border-radius: 1.5rem;
            padding: 2rem;
            margin-bottom: 2rem;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
        }
        .profile-icon {
            font-size: 1.5rem;
            margin-right: 10px;
            color: #4fc3f7;
        }
        .info-row {
            border-bottom: 1px solid #2c2c2c;
            padding: 15px 0;
            color: #fff;
        }
        .info-row:last-child {
            border-bottom: none;
        }
        .input-group-text {
            background: #232526 !important;
            border-color: #2c2c2c;
            color: #fff;
        }
        .form-control {
            background: #232526 !important;
            border-color: #2c2c2c;
            color: #fff !important;
        }
        .form-control::placeholder {
            color: #666;
        }
        .form-control:focus {
            border-color: #4fc3f7;
            box-shadow: 0 0 0 0.2rem rgba(79,195,247,.15);
            background: #232526;
            color: #fff;
        }
        .badge.bg-primary {
            background-color: #4fc3f7 !important;
        }
        .badge.bg-success {
            background-color: #43a047 !important;
        }
        .btn-outline-success {
            border-color: #43a047;
            color: #43a047;
        }
        .btn-outline-success:hover {
            background-color: #43a047;
            color: #fff;
        }
        .border-primary {
            border-color: #4fc3f7 !important;
        }
        .text-primary {
            color: #4fc3f7 !important;
        }
        .text-danger {
            color: #ff5252 !important;
        }
        .is-invalid {
            border-color: #ff5252 !important;
        }
        .invalid-feedback {
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
        <div class="logo"><%= appName %> <span class="admin-badge">CLIENT</span></div>
    </div>
    <nav class="nav flex-column">
        <a class="nav-link" href="<%= ctx %>/home">
            <i class="bi bi-house-door me-2"></i> Accueil
        </a>
        <a class="nav-link" href="<%= ctx %>/credit">
            <i class="bi bi-cash-stack me-2"></i> Crédit
        </a>
        <hr class="border-secondary">
        <div class="dropdown">
            <a class="nav-link dropdown-toggle text-success" href="#" data-bs-toggle="dropdown">
                <i class="bi bi-person-circle me-2"></i>
                <%= connectedUser.getRole() %>: <%= connectedUser.getFirstName() %>
            </a>
            <ul class="dropdown-menu dropdown-menu-dark">
                <li><a class="dropdown-item active" href="<%= ctx %>/profile"><i class="bi bi-person me-2"></i>Votre Profil</a></li>
                <li><a class="dropdown-item text-danger" href="<%= ctx %>/logout"><i class="bi bi-box-arrow-right me-2"></i>Déconnexion</a></li>
            </ul>
        </div>
    </nav>
</div>

<!-- ALERT MESSAGES -->
<div class="alert-wrapper">
    <c:if test="${not empty successMessage}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            <i class="bi bi-check-circle-fill me-2"></i> ${successMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>
    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <i class="bi bi-exclamation-triangle-fill me-2"></i> ${errorMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>
</div>

<!-- ✅ MAIN CONTENT -->
<div class="main-content">
    <div class="main-card">
        <h4 class="text-center text-primary mb-4">Mon Profil</h4>

        <!-- PROFILE CARD -->
        <div class="profile-card">
            <!-- Profile Header -->
            <div class="d-flex justify-content-between align-items-center mb-4">
                <div>
                    <h5 class="text-primary mb-0">Informations Personnelles</h5>
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
        <div class="profile-card mt-5">
            <h5 class="text-center text-primary mb-4">Changer le mot de passe</h5>

            <form id="passwordForm" action="<%= ctx %>/profile/change-password" method="post" class="mt-3" onsubmit="return validatePasswordForm()">
                <!-- Current Password -->
                <div class="mb-3">
                    <div class="input-group align-items-center">
                        <span class="input-group-text">
                            <i class="bi bi-lock-fill text-primary" style="font-size: 1.2rem; margin-right: 6px;"></i>
                        </span>
                        <input type="password" class="form-control" id="currentPassword" name="currentPassword" placeholder="Mot de passe actuel" required/>
                        <div class="invalid-feedback">Le mot de passe actuel est requis</div>
                    </div>
                </div>

                <!-- New Password -->
                <div class="mb-3">
                    <div class="input-group align-items-center">
                        <span class="input-group-text">
                            <i class="bi bi-key-fill text-primary" style="font-size: 1.2rem; margin-right: 6px;"></i>
                        </span>
                        <input type="password" class="form-control" id="newPassword" name="newPassword" placeholder="Nouveau mot de passe" required/>
                        <div class="invalid-feedback">Le nouveau mot de passe est requis</div>
                    </div>
                </div>

                <!-- Confirm New Password -->
                <div class="mb-4">
                    <div class="input-group align-items-center">
                        <span class="input-group-text">
                            <i class="bi bi-key text-primary" style="font-size: 1.2rem; margin-right: 6px;"></i>
                        </span>
                        <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" placeholder="Confirmer le nouveau mot de passe" required/>
                        <div class="invalid-feedback">Les mots de passe ne correspondent pas</div>
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
</div>

<!-- ✅ FOOTER -->
<footer>
    <span class="text-muted">
        <i class="bi bi-house-door me-1"></i> <b class="text-primary"><%= appName %></b> – © 2025 Tous droits réservés
    </span>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Form validation for password change
    function validatePasswordForm() {
        const form = document.getElementById('passwordForm');
        const currentPassword = document.getElementById('currentPassword');
        const newPassword = document.getElementById('newPassword');
        const confirmPassword = document.getElementById('confirmPassword');
        let isValid = true;
        
        // Reset validation state
        currentPassword.classList.remove('is-invalid');
        newPassword.classList.remove('is-invalid');
        confirmPassword.classList.remove('is-invalid');
        
        // Validate current password
        if (!currentPassword.value) {
            currentPassword.classList.add('is-invalid');
            isValid = false;
        }
        
        // Validate new password
        if (!newPassword.value) {
            newPassword.classList.add('is-invalid');
            isValid = false;
        }
        
        // Validate password confirmation
        if (!confirmPassword.value || confirmPassword.value !== newPassword.value) {
            confirmPassword.classList.add('is-invalid');
            isValid = false;
        }
        
        return isValid;
    }
    
    // Real-time validation
    document.getElementById('currentPassword').addEventListener('input', function() {
        if (this.value) {
            this.classList.remove('is-invalid');
        }
    });
    
    document.getElementById('newPassword').addEventListener('input', function() {
        if (this.value) {
            this.classList.remove('is-invalid');
        }
        // Check confirmation field if it's already filled
        const confirmField = document.getElementById('confirmPassword');
        if (confirmField.value && confirmField.value !== this.value) {
            confirmField.classList.add('is-invalid');
        } else if (confirmField.value) {
            confirmField.classList.remove('is-invalid');
        }
    });
    
    document.getElementById('confirmPassword').addEventListener('input', function() {
        const newPassword = document.getElementById('newPassword').value;
        if (this.value && this.value === newPassword) {
            this.classList.remove('is-invalid');
        } else if (this.value) {
            this.classList.add('is-invalid');
        }
    });
</script>
</body>
</html>