package ma.bankati.web.filters.access;

import jakarta.servlet.ServletException;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;
import java.io.IOException;
import ma.bankati.model.users.*;

@WebFilter(urlPatterns = {"/admin/*", "/public/*"})
public class AuthorizationFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        HttpSession session = req.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("connectedUser") : null;

        if (user == null) {
            res.sendRedirect("login");
            return;
        }

        String uri = req.getRequestURI();
        ERole role = user.getRole();

        if ((uri.contains("/admin/") && role != ERole.ADMIN) ||
            (uri.contains("/public/") && role != ERole.USER)) {
            res.sendRedirect(req.getContextPath() + "/home");
            return;
        }

        chain.doFilter(request, response);
    }
}
