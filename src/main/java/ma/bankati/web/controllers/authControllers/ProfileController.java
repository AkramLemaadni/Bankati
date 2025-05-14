package ma.bankati.web.controllers.authControllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import ma.bankati.model.users.ERole;
import ma.bankati.model.users.User;
import ma.bankati.service.authentification.IAuthentificationService;

import java.io.IOException;

@WebServlet(value = "/profile", loadOnStartup = 3)
public class ProfileController extends HttpServlet {

    private IAuthentificationService authService;

    @Override
    public void init() throws ServletException {
        authService = (IAuthentificationService) getServletContext().getAttribute("authService");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User connectedUser = (User) request.getSession().getAttribute("connectedUser");
        if (connectedUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        request.setAttribute("user", connectedUser);
        if(connectedUser.getRole() == ERole.ADMIN) {
            request.getRequestDispatcher("/admin/profil.jsp").forward(request, response);
        }
        else {
            request.getRequestDispatcher("/public/profile.jsp").forward(request, response);
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Handle profile updates here
    }
}