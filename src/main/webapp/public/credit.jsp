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
    <title>Demandes de Crédit - <%= appName %></title>
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
        .credit-form-card {
            max-width: 500px;
            background: #212529;
            border-radius: 1.5rem;
            padding: 2rem;
            margin: 0 auto 2rem;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
        }
        .main-card h4, .credit-form-card h5 {
            color: #4fc3f7;
            font-weight: 600;
            letter-spacing: 1px;
        }
        .form-control, .input-group-text, .form-select {
            background: #232526;
            color: #fff !important;
            border: 1px solid #333;
            font-family: 'Poppins', sans-serif;
        }
        input.form-control, input.form-control:focus, input.form-control:active,
        input[type="number"], input[type="number"]:focus, input[type="number"]:active {
            color: #fff !important;
            background: #232526 !important;
            border: 1px solid #333 !important;
            caret-color: #4fc3f7;
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
            background: #43a047;
            border: none;
            color: #fff;
        }
        .btn-success:hover, .btn-outline-success:hover {
            background: #2e7d32;
        }
        .btn-primary, .btn-outline-primary {
            background: #4fc3f7;
            border: none;
            color: #fff;
        }
        .btn-primary:hover, .btn-outline-primary:hover {
            background: #29b6f6;
            color: #fff;
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
        <div class="logo"><%= appName %> <span class="admin-badge">CLIENT</span></div>
    </div>
    <nav class="nav flex-column">
        <a class="nav-link" href="<%= ctx %>/home">
            <i class="bi bi-house-door me-2"></i> Accueil
        </a>
        <a class="nav-link active" href="<%= ctx %>/credit">
            <i class="bi bi-cash-stack me-2"></i> Crédit
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
        <h4 class="text-center text-primary mb-4">Mes Demandes de Crédit</h4>

        <!-- CREDIT FORM -->
        <div class="credit-form-card p-4 mb-5 mx-auto">
            <h5 class="text-center bold text-primary">
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
                <thead>
                <tr>
                    <th class="text-center text-primary">Date</th>
                    <th class="text-center text-primary">Montant</th>
                    <th class="text-center text-primary">Durée</th>
                    <th class="text-center text-primary">Statut</th>
                    <th class="text-center text-primary">Actions</th>
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
                <c:if test="${empty demandes}">
                    <tr>
                        <td colspan="5" class="text-center py-4">
                            <i class="bi bi-info-circle me-2"></i> Aucune demande de crédit trouvée
                        </td>
                    </tr>
                </c:if>
                </tbody>
            </table>
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