package ma.bankati.web.controllers.authControllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import ma.bankati.model.users.User;
import ma.bankati.service.authentification.IAuthentificationService;

import java.io.IOException;

@WebServlet(urlPatterns = "/login", loadOnStartup = 0)
public class LoginController extends HttpServlet {

    IAuthentificationService authService;

    @Override
    public void init() throws ServletException {
        System.out.println("LoginController créé et initialisé");
        authService = (IAuthentificationService) getServletContext().getAttribute("authService");
    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {


        request.getRequestDispatcher("public/Login.jsp").forward(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("lg");
        String password = request.getParameter("pss");

        if (!authService.validateLoginForm(username, password)) {
            authService.getFieldErrors().forEach(request::setAttribute);
            request.setAttribute("globalMessage", authService.getGlobalMessage());
            request.getRequestDispatcher("public/Login.jsp").forward(request, response);
            return;
        }

        User user = authService.connect(username, password);

        if (user != null) {
            request.getSession().setAttribute("connectedUser", user);
            request.getSession().setAttribute("globalMessage", authService.getGlobalMessage());
            response.sendRedirect("home");
        } else {
            //authService.getFieldErrors().forEach(request::setAttribute);
            request.setAttribute("globalMessage", authService.getGlobalMessage());
            request.getRequestDispatcher("public/Login.jsp").forward(request, response);
        }

    }

    @Override
    public void destroy() {
        System.out.println("LoginController détruit");
    }
}
