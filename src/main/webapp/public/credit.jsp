<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    var ctx = request.getContextPath();
    var connectedUser = (ma.bankati.model.users.User) session.getAttribute("connectedUser");
%>
<html>
<head>
    <title>Demandes de Crédit</title>
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
        .main-card, .credit-form-card {
            border: none;
            border-radius: 2rem;
            box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.2);
            background: #181a1b;
            padding: 2.5rem 2rem 2rem 2rem;
            width: 100%;
            max-width: 900px;
            margin: 2rem auto 2rem auto;
            font-family: 'Poppins', Arial, sans-serif;
        }
        .credit-form-card {
            max-width: 500px;
            background: #212529;
        }
        .main-card h4, .credit-form-card h5 {
            color: #4fc3f7;
            font-weight: 600;
            letter-spacing: 1px;
        }
        .form-control, .input-group-text, .form-select {
            background: #232526;
            color: #fff;
            border: 1px solid #333;
            font-family: 'Poppins', Arial, sans-serif;
        }
        .form-control:focus, .form-select:focus {
            border-color: #4fc3f7;
            box-shadow: 0 0 0 0.2rem rgba(79,195,247,.15);
            background: #232526;
            color: #fff;
        }
        .input-group-text {
            border-right: none;
            background: #232526;
        }
        .form-control::placeholder {
            color: #b0b3b8;
        }
        .btn-success, .btn-outline-success {
            background: #007bff;
            border: none;
            color: #fff;
        }
        .btn-success:hover, .btn-outline-success:hover {
            background: #0056b3;
        }
        .btn-outline-danger {
            border-color: #ff5252;
            color: #ff5252;
        }
        .btn-outline-danger:hover {
            background: #ff5252;
            color: #fff;
        }
        .btn-outline-primary {
            border-color: #4fc3f7;
            color: #4fc3f7;
        }
        .btn-outline-primary:hover {
            background: #4fc3f7;
            color: #fff;
        }
        .table {
            background: #232526;
            color: #fff;
            border-radius: 1rem;
            overflow: hidden;
        }
        .table th, .table td {
            border-color: #333;
            vertical-align: middle;
        }
        .table thead {
            background: #181a1b;
            color: #4fc3f7;
        }
        .statut-en_attente { color: orange; font-weight: bold; }
        .statut-approuve { color: #43a047; font-weight: bold; }
        .statut-refuse { color: #ff5252; font-weight: bold; }
        .footer-navbar {
            background: #181a1b !important;
            font-family: 'Poppins', Arial, sans-serif;
        }
        .footer-navbar .text-muted, .footer-navbar .blue {
            color: #4fc3f7 !important;
        }
        .bg-white {
            background: #232526 !important;
        }
        .rounded-3, .rounded-4, .rounded-circle {
            border-radius: 2rem !important;
        }
        .btn-group .btn {
            margin: 0 2px;
        }
        .navbar-brand strong {
            color: #4fc3f7 !important;
        }
        .nav-link, .dropdown-item, .navbar-brand, .navbar {
            color: #fff !important;
        }
        .nav-link.text-primary, .dropdown-item.text-primary {
            color: #4fc3f7 !important;
        }
        .text-danger {
            color: #ff5252 !important;
        }
        .text-primary {
            color: #4fc3f7 !important;
        }
        .blue {
            color: #4fc3f7 !important;
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
                    <a class="nav-link text-primary fw-bold active" href="<%= ctx %>/credit">
                        <i class="bi bi-cash-stack me-1"></i> Crédit
                    </a>
                </li>
            </ul>
        </div>
        <div class="dropdown d-flex align-items-center">
            <a class="btn btn-sm btn-light border dropdown-toggle text-success fw-bold"
               href="#" role="button" data-bs-toggle="dropdown">
                <i class="bi bi-person-circle me-1"></i> <b><%= connectedUser.getRole() %></b> :
                <i><%= connectedUser.getFirstName() + " " + connectedUser.getLastName() %></i>
            </a>
            <ul class="dropdown-menu dropdown-menu-end">
                <li><hr class="dropdown-divider"></li>
                <li>
                    <a class="dropdown-item text-primary fw-bold" href="<%= ctx %>/profile">
                        <i class="bi bi-person-circle me-1"></i> Votre Profil
                    </a>
                    <a class="dropdown-item text-danger fw-bold" href="<%= ctx %>/logout">
                        <i class="bi bi-box-arrow-right me-1"></i> Déconnexion
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
<div class="main-card mt-5 mb-5">
    <h4 class="text-center text-primary mb-4">Mes Demandes de Crédit</h4>

    <!-- CREDIT FORM -->
    <div class="credit-form-card p-4 mb-5 mx-auto">
        <h5 class="text-center bold blue">
            <c:choose>
                <c:when test="${not empty credit}">Modifier la demande</c:when>
                <c:otherwise>Nouvelle Demande</c:otherwise>
            </c:choose>
        </h5>

        <!-- Bouton visible uniquement si on est en modification -->
        <c:if test="${not empty credit}">
            <div class="text-center mb-3">
                <a href="<%= ctx %>/credit" class="btn btn-outline-primary btn-sm fw-bold">
                    <i class="bi bi-plus-circle me-1"></i> Nouvelle demande
                </a>
            </div>
        </c:if>

        <form id="creditForm" action="<%= ctx %>/credit/save" method="post" class="mt-3" onsubmit="return validateCreditForm()">
            <input type="hidden" name="id" value="${credit.id}"/>

            <div class="mb-3">
                <label class="form-label text-primary fw-bold">Montant (DH)</label>
                <div class="input-group align-items-center">
                    <span class="input-group-text">
                        <i class="bi bi-currency-dollar text-primary"></i>
                    </span>
                    <input type="number" id="montant" name="montant"
                           class="form-control bold"
                           placeholder="5000" value="${credit.montant}" required>
                </div>
            </div>

            <div class="mb-3">
                <label class="form-label text-primary fw-bold">Durée (mois)</label>
                <div class="input-group align-items-center">
                    <span class="input-group-text">
                        <i class="bi bi-hourglass-split text-primary"></i>
                    </span>
                    <input type="number" id="duree" name="duree"
                           class="form-control bold"
                           placeholder="12" min="1" max="120" value="${credit.dureeMois}" required>
                    <div class="invalid-feedback">Durée doit être entre 1 et 120 mois</div>
                </div>
            </div>

            <div class="text-center mt-4">
                <button type="submit" class="btn btn-success fw-bold px-4">
                    <i class="bi bi-save me-1"></i> 
                    <c:choose>
                        <c:when test="${not empty credit}">Mettre à jour</c:when>
                        <c:otherwise>Soumettre</c:otherwise>
                    </c:choose>
                </button>
            </div>
        </form>
    </div>

    <!-- CREDIT REQUESTS TABLE -->
    <div class="table-responsive">
        <table class="table table-hover table-bordered text-center">
            <thead class="table-light blue">
            <tr>
                <th class="text-center">Date</th>
                <th class="text-center">Montant</th>
                <th class="text-center">Durée</th>
                <th class="text-center">Statut</th>
                <th class="text-center">Actions</th>
            </tr>
            </thead>
            <tbody class="bold">
            <c:forEach items="${demandes}" var="demande">
                <tr>
                    <td>${demande.dateDemande}</td>
                    <td>${demande.montant} DH</td>
                    <td>${demande.dureeMois} mois</td>
                    <td class="statut-${demande.status.toString().toLowerCase()}">
                            ${demande.status}
                    </td>
                    <td>
                        <div class="btn-group" role="group">
                            <a href="${pageContext.request.contextPath}/credit/edit?id=${demande.id}" class="btn btn-outline-primary btn-sm">
                                <i class="bi bi-pencil-fill"></i>
                            </a>
                            <form action="${pageContext.request.contextPath}/credit/delete" method="post" style="display:inline;">
                                <input type="hidden" name="id" value="${demande.id}">
                                <button type="submit" class="btn btn-outline-danger btn-sm"
                                        onclick="return confirm('Êtes-vous sûr de vouloir supprimer cette demande?')">
                                    <i class="bi bi-trash-fill"></i>
                                </button>
                            </form>
                        </div>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<!-- FOOTER -->
<nav class="navbar footer-navbar fixed-bottom shadow-sm">
    <div class="container d-flex justify-content-between align-items-center w-100">
        <span class="text-muted small"><b class="blue"><i class="bi bi-house-door me-1"></i> Akram's Bank 2025 </b>– © Tous droits réservés</span>
    </div>
</nav>

<script>
    // Form validation
    function validateCreditForm() {
        const form = document.getElementById('creditForm');
        const montant = document.getElementById('montant');
        const duree = document.getElementById('duree');
        let isValid = true;

        // Reset validation
        montant.classList.remove('is-invalid');
        duree.classList.remove('is-invalid');

        // Validate amount
        if (!montant.value || montant.value <= 0) {
            montant.classList.add('is-invalid');
            isValid = false;
        }

        // Validate duration
        if (!duree.value || duree.value <= 0 || duree.value > 120) {
            duree.classList.add('is-invalid');
            isValid = false;
        }

        return isValid;
    }

    // Real-time validation
    document.getElementById('montant').addEventListener('input', function() {
        if (this.value > 0) {
            this.classList.remove('is-invalid');
        }
    });

    document.getElementById('duree').addEventListener('input', function() {
        if (this.value > 0 && this.value <= 120) {
            this.classList.remove('is-invalid');
        }
    });
</script>

</body>
</html>