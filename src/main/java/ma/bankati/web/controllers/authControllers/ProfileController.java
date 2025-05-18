package ma.bankati.web.controllers.authControllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import ma.bankati.dao.userDao.IUserDao;
import ma.bankati.dao.userDao.UserDaoImpl;
import ma.bankati.model.users.ERole;
import ma.bankati.model.users.User;
import ma.bankati.service.authentification.IAuthentificationService;

import java.io.IOException;
import java.util.Optional;

@WebServlet(urlPatterns = {"/profile", "/profile/*"}, loadOnStartup = 3)
public class ProfileController extends HttpServlet {

    private IAuthentificationService authService;
    private IUserDao userDao;

    @Override
    public void init() throws ServletException {
        authService = (IAuthentificationService) getServletContext().getAttribute("authService");
        userDao = new UserDaoImpl();
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
        
        String path = request.getPathInfo();
        if (path != null && path.equals("/change-password")) {
            changePassword(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
    
    private void changePassword(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        User connectedUser = (User) request.getSession().getAttribute("connectedUser");
        if (connectedUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");
        
        // Validate current password
        Optional<User> userOpt = userDao.findByLoginAndPassword(connectedUser.getUsername(), currentPassword);
        if (userOpt.isEmpty()) {
            request.setAttribute("errorMessage", "Mot de passe actuel incorrect");
            doGet(request, response);
            return;
        }
        
        // Validate new password
        if (newPassword == null || newPassword.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Le nouveau mot de passe ne peut pas être vide");
            doGet(request, response);
            return;
        }
        
        // Confirm passwords match
        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("errorMessage", "Les mots de passe ne correspondent pas");
            doGet(request, response);
            return;
        }
        
        // Update the password
        connectedUser.setPassword(newPassword);
        User updatedUser = userDao.update(connectedUser);
        
        if (updatedUser != null) {
            // Update the session with the updated user
            request.getSession().setAttribute("connectedUser", updatedUser);
            request.setAttribute("successMessage", "Mot de passe modifié avec succès");
        } else {
            request.setAttribute("errorMessage", "Échec de la mise à jour du mot de passe");
        }
        
        doGet(request, response);
    }
}