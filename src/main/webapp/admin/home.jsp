<%@page import="ma.bankati.model.data.MoneyData" pageEncoding="UTF-8" %>
<%@page import="ma.bankati.model.users.User" %>
<%@page import="java.util.List" %>
<%
    var ctx = request.getContextPath();
    var result = (MoneyData) request.getAttribute("result");
    var allCurrencies = (List<MoneyData>) request.getAttribute("allCurrencies");
    var connectedUser = (User) session.getAttribute("connectedUser");
    var appName = (String) application.getAttribute("AppName");
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Accueil - <%= appName %></title>
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
        }
        .currency-card {
            background-color: #242627;
            border-radius: 1rem;
            padding: 1rem;
            margin-bottom: 1rem;
        }
        .currency-icon {
            font-size: 1.5rem;
            margin-right: 0.5rem;
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
        <a class="nav-link active" href="<%= ctx %>/home">
            <i class="bi bi-house-door me-2"></i> Accueil
        </a>
        <a class="nav-link" href="<%= ctx %>/users">
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
        <h4 class="mb-4 text-center">Bienvenue à votre compte <span class="text-primary"><%= appName %></span></h4>

        <div class="mb-4 text-center">
            <h5 class="text-primary">Solde principal :</h5>
            <div class="text-danger display-6 fw-bold">
                <%= String.format("%,.2f", result.getValue()) %> <span class="currency"><%= result.getDevise() %></span>
            </div>
            <p class="text-muted small mt-2">Dernière mise à jour : <%= result.getCreationDate() %></p>
        </div>

        <% if (allCurrencies != null && allCurrencies.size() > 1) { %>
        <h6 class="text-primary mt-5 mb-3">Tous vos comptes :</h6>
        <% for (MoneyData currency : allCurrencies) {
            String icon = "bi-cash-coin";
            if (currency.getDevise().name().equals("Dollar")) {
                icon = "bi-currency-dollar";
            } else if (currency.getDevise().name().equals("Euro")) {
                icon = "bi-currency-euro";
            } else if (currency.getDevise().name().equals("Pound")) {
                icon = "bi-currency-pound";
            }
        %>
        <div class="currency-card d-flex align-items-center">
            <i class="bi <%= icon %> currency-icon text-primary"></i>
            <div>
                <h6 class="mb-1"><%= currency.getDevise() %></h6>
                <p class="mb-0 fw-semibold"><%= String.format("%,.2f", currency.getValue()) %></p>
            </div>
        </div>
        <% } %>
        <% } %>
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