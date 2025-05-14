package ma.bankati.web.filters.utils;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import java.io.IOException;
import ma.bankati.model.users.User;

@WebFilter("/*")
public class RequestLoggingFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        String ip = normalizeIp(req.getRemoteAddr());
        String uri = req.getRequestURI();
        String method = req.getMethod();
        String user = (req.getSession(false) != null && req.getSession(false).getAttribute("connectedUser") != null)
                ? ((User) req.getSession(false).getAttribute("connectedUser")).getUsername()
        : "USER_WITH_NO_SESSION";

        System.out.printf("📥 [%s] %s %s from %s%n", user, method, uri, ip);

        chain.doFilter(request, response);
    }

    private String normalizeIp(String ip) {
        return ip.equals("0:0:0:0:0:0:0:1") ? "127.0.0.1" : ip;
    }
}
