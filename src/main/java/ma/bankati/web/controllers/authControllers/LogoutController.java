package ma.bankati.web.controllers.authControllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(value = "/logout", loadOnStartup = 2)
public class LogoutController extends HttpServlet {

    @Override
    public void init() throws ServletException {
        System.out.println("LogoutController créé et initialisé");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Invalider la session
        request.getSession().invalidate();

        // Rediriger vers la page de login avec message
        request.setAttribute("globalMessage", "Vous avez été déconnecté avec succès.");
        request.getRequestDispatcher("login").forward(request, response);
    }

    @Override
    public void destroy() {
        System.out.println("LogoutController détruit");
    }
}
