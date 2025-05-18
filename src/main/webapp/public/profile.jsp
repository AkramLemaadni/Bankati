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
        .profile-card {
            border-radius: 2rem;
            box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.2);
            background: #181a1b;
            padding: 2.5rem 2rem 2rem 2rem;
            color: #fff;
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
        .container {
            background: #181a1b !important;
            color: #fff;
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
        .badge.bg-primary {
            background-color: #4fc3f7 !important;
        }
        .badge.bg-success {
            background-color: #43a047 !important;
        }
        .blue {
            color: #4fc3f7 !important;
        }
        .footer-navbar {
            background: #181a1b !important;
        }
        .footer-navbar .text-muted, .footer-navbar .blue {
            color: #4fc3f7 !important;
        }
        .alert-success {
            background-color: rgba(67, 160, 71, 0.9) !important;
            color: white !important;
        }
        .alert-danger {
            background-color: rgba(255, 82, 82, 0.9) !important;
            color: white !important;
        }
        .is-invalid {
            border-color: #ff5252 !important;
        }
        .invalid-feedback {
            color: #ff5252 !important;
        }
    </style>
</head>
<body>

<!-- NAVBAR -->
<nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm">
    <div class="container-fluid">
        <a class="navbar-brand d-flex align-items-center" href="<%= ctx %>/home">
			<img src="<%= ctx %>/assets/img/logoBank.png" alt="Logo" width="40" height="40" class="d-inline-block align-text-top me-2">
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

<!-- ALERT MESSAGES -->
<c:if test="${not empty successMessage}">
    <div class="container w-75 mt-3">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            <i class="bi bi-check-circle-fill me-2"></i> ${successMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </div>
</c:if>
<c:if test="${not empty errorMessage}">
    <div class="container w-75 mt-3">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <i class="bi bi-exclamation-triangle-fill me-2"></i> ${errorMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </div>
</c:if>

<!-- MAIN CONTENT -->
<div class="container w-75 mt-5 mb-5 p-4 rounded-3 shadow-sm border border-dark">
    <h4 class="text-center text-primary mb-4">Mon Profile</h4>

    <!-- PROFILE CARD -->
    <div class="profile-card bg-dark p-4 mb-5">
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
    <div class="border border-primary rounded-4 p-4 mt-5 mb-5 shadow-sm">
        <h5 class="text-center bold blue mb-4">Changer le mot de passe</h5>

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

<!-- FOOTER -->
<nav class="navbar footer-navbar fixed-bottom shadow-sm">
    <div class="container d-flex justify-content-between align-items-center w-100">
        <span class="text-muted small"><b class="blue"><i class="bi bi-house-door me-1"></i> Akram's Bank 2025 </b>– © Tous droits réservés</span>
    </div>
</nav>

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