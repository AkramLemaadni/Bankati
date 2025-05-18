<%@page import="ma.bankati.model.data.MoneyData" pageEncoding="UTF-8" %>
<%@page import="ma.bankati.model.users.User" %>
<%@page import="java.util.List" %>
<%
    var ctx = request.getContextPath();
%>
<html>
<head>
    <title>Accueil</title>
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
        .main-card, .container-main-dark {
            border: none;
            border-radius: 2rem;
            box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.2);
            background: #181a1b;
            padding: 2.5rem 2rem 2rem 2rem;
            width: 100%;
            max-width: 500px;
            margin: 4rem auto 3rem auto;
            color: #fff;
            font-family: 'Poppins', Arial, sans-serif;
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
        .balance-amount {
            font-size: 2rem;
            font-weight: 600;
        }
        .currency {
            font-size: 1.2rem;
            margin-left: 0.5rem;
        }
        .currency-card {
            background: #242627;
            border-radius: 1rem;
            padding: 1rem;
            margin-bottom: 1rem;
        }
        .currency-icon {
            font-size: 1.5rem;
            margin-right: 0.5rem;
        }
    </style>
</head>
<%
    var result = (MoneyData) request.getAttribute("result");
    var allCurrencies = (List<MoneyData>) request.getAttribute("allCurrencies");
    var connectedUser = (User) session.getAttribute("connectedUser");
    var appName = (String) application.getAttribute("AppName");
%>
<body class="Optima bgBlue">

<nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm">
    <div class="container-fluid">
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
        <div class="dropdown d-flex align-items-center">
            <a class="btn btn-sm btn-light border dropdown-toggle text-success fw-bold"
               href="#" role="button" id="dropdownSessionMenu" data-bs-toggle="dropdown" aria-expanded="false">
                <i class="bi bi-person-circle me-1"></i> <b><%= connectedUser.getRole() %></b> : <i><%= connectedUser.getFirstName() + " " + connectedUser.getLastName() %></i>
            </a>
            <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="dropdownSessionMenu">
                <!--<li><span class="dropdown-item-text text-muted small">Session ouverte</span></li>-->
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
<div class="container-main-dark main-card mt-5 mb-5">
    <div class="card-body text-center">
        <h5 class="mt-4 mb-4">
            Bienvenue à votre compte <span class="text-primary font-weight-bold"><%= appName %></span>
        </h5>
        
        <div class="mb-4">
            <p class="text-primary h5 mb-3">
                Solde principal :
            </p>
            <div class="text-danger balance-amount">
                <%= String.format("%,.2f", result.getValue()) %><span class="currency"><%= result.getDevise() %></span>
            </div>
            <p class="text-muted small mt-2">Dernière mise à jour: <%= result.getCreationDate() %></p>
        </div>
        
        <% if (allCurrencies != null && allCurrencies.size() > 1) { %>
            <div class="mt-4">
                <p class="text-primary h6 mb-3">Tous vos comptes :</p>
                
                <div class="currency-list">
                    <% for (MoneyData currency : allCurrencies) { %>
                        <div class="currency-card text-start">
                            <div class="d-flex align-items-center">
                                <% 
                                String icon = "bi-cash-coin";
                                if (currency.getDevise().name().equals("Dollar")) {
                                    icon = "bi-currency-dollar";
                                } else if (currency.getDevise().name().equals("Euro")) {
                                    icon = "bi-currency-euro";
                                } else if (currency.getDevise().name().equals("Pound")) {
                                    icon = "bi-currency-pound";
                                }
                                %>
                                <i class="bi <%= icon %> currency-icon text-primary"></i>
                                <div>
                                    <h6 class="mb-0"><%= currency.getDevise() %></h6>
                                    <p class="mb-0"><strong><%= String.format("%,.2f", currency.getValue()) %></strong></p>
                                </div>
                            </div>
                        </div>
                    <% } %>
                </div>
            </div>
        <% } %>
    </div>
</div>

<!-- ✅ FOOTER FIXÉ EN BAS -->
<nav class="navbar footer-navbar fixed-bottom shadow-sm">
    <div class="container d-flex justify-content-between align-items-center w-100">
        <span class="text-muted small"><b class="blue"><i class="bi bi-house-door me-1"></i> <%= appName %> 2025 </b>– © Tous droits réservés</span>
    </div>
</nav>

</body>
</html>
