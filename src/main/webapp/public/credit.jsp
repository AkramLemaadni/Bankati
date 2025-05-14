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
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        .statut-en_attente { color: orange; font-weight: bold; }
        .statut-approuve { color: green; font-weight: bold; }
        .statut-refuse { color: red; font-weight: bold; }
        .is-invalid { border-color: #dc3545; }
        .invalid-feedback { color: #dc3545; font-size: 0.875em; }
    </style>
</head>
<body class="Optima bgBlue">

<!-- NAVBAR -->
<nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm">
    <div class="container-fluid">
        <a class="navbar-brand d-flex align-items-center" href="<%= ctx %>/home">
            <img src="<%= ctx %>/assets/img/logoBlue.png" alt="Logo" width="40" height="40" class="me-2">
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
<div class="container w-75 mt-5 mb-5 bg-white p-4 rounded-3 shadow-sm border border-light">
    <h4 class="text-center text-primary mb-4">Mes Demandes de Crédit</h4>

    <!-- CREDIT FORM -->
    <div class="border border-primary rounded-4 p-4 mb-5 shadow-sm bg-white w-75 mx-auto">
        <h5 class="text-center bold blue">Nouvelle Demande</h5>
        <form id="creditForm" action="${ctx}/credit/save" method="post" class="mt-3" onsubmit="return validateCreditForm()">
            <input type="hidden" name="action" value="ajouter">

            <div class="mb-3">
                <label class="form-label text-primary fw-bold">Montant (DH)</label>
                <div class="input-group align-items-center">
                    <span class="input-group-text bg-white">
                        <i class="bi bi-currency-dollar text-primary"></i>
                    </span>
                    <input type="number" id="montant" name="montant"
                           class="form-control text-dark bold"
                           placeholder="5000" required>
                </div>
            </div>

            <div class="mb-3">
                <label class="form-label text-primary fw-bold">Durée (mois)</label>
                <div class="input-group align-items-center">
                    <span class="input-group-text bg-white">
                        <i class="bi bi-hourglass-split text-primary"></i>
                    </span>
                    <input type="number" id="duree" name="duree"
                           class="form-control text-dark bold"
                           placeholder="12" min="1" max="120" required>
                    <div class="invalid-feedback">Durée doit être entre 1 et 120 mois</div>
                </div>
            </div>

            <div class="text-center mt-4">
                <button type="submit" class="btn btn-success fw-bold px-4">
                    <i class="bi bi-save me-1"></i> Soumettre
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
                    <td class="statut-${demande.statut.toString().toLowerCase().replace(' ', '_')}">
                            ${demande.statut}
                    </td>
                    <td>
                        <div class="btn-group" role="group">
                            <a href="${ctx}/credit/edit?id=${demande.id}" class="btn btn-outline-primary btn-sm">
                                <i class="bi bi-pencil-fill"></i>
                            </a>
                            <form action="${ctx}/credit/delete" method="post" style="display:inline;">
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
<nav class="navbar footer-navbar fixed-bottom bg-white shadow-sm">
    <div class="container d-flex justify-content-between align-items-center w-100">
        <span class="text-muted small"><b class="blue"><i class="bi bi-house-door me-1"></i> Bankati 2025 </b>– © Tous droits réservés</span>
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
        if (!duree.value || duree.value <= 0) {
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
        if (this.value > 0) {
            this.classList.remove('is-invalid');
        }
    });
</script>

</body>
</html>