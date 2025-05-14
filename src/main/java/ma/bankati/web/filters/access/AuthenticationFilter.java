// ✅ AuthFilter.java
package ma.bankati.web.filters.access;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import ma.bankati.model.users.User;

import java.io.IOException;

@WebFilter(urlPatterns = {"/*"})
public class AuthenticationFilter implements Filter {

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;

        String path = request.getRequestURI().substring(request.getContextPath().length());

        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("connectedUser") : null;

        boolean isLoggedIn = session != null && user != null;
        boolean isLoginRequest = path.equals("/login") || path.equals("/logout");
        boolean isStaticResource = path.startsWith("/assets/") || path.endsWith(".css") || path.endsWith(".js") || path.endsWith(".png") || path.endsWith(".jpg");

        if (isLoggedIn || isLoginRequest || isStaticResource) {
            chain.doFilter(request, response); // Accès autorisé
        } else {
            response.sendRedirect(request.getContextPath() + "/login"); // Redirection vers /login
        }
    }
}


