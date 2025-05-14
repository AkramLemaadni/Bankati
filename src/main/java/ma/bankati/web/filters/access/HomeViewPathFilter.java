package ma.bankati.web.filters.access;
import jakarta.servlet.ServletException;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;
import java.io.IOException;
import ma.bankati.model.users.*;

@WebFilter(urlPatterns = {"/home"})
public class HomeViewPathFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpSession session = req.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("connectedUser") : null;

        if (user != null) {
            String viewPath = "";

            switch (user.getRole()) {
                case ADMIN:
                    viewPath = "admin/home.jsp";
                    break;
                case USER:
                    viewPath = "public/home.jsp";
                    break;
                default:
                    viewPath = "login.jsp";
            }
            req.setAttribute("viewPath", viewPath);
        }

        chain.doFilter(request, response);
    }
}
