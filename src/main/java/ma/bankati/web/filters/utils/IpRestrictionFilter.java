package ma.bankati.web.filters.utils;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Set;

@WebFilter("/public/*")
public class IpRestrictionFilter implements Filter {
    private static final Set<String> ALLOWED_IPS = Set.of("127.0.0.1", "192.168.1.100");

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        String clientIp = request.getRemoteAddr();
        if (!ALLOWED_IPS.contains(clientIp)) {
            ((HttpServletResponse) response).sendError(HttpServletResponse.SC_FORBIDDEN, "Access denied for IP: " + normalizeIp(clientIp));
            System.out.println("Access denied for IP: " + normalizeIp(clientIp));
            return;
        }

        chain.doFilter(request, response);
        }

    private String normalizeIp(String ip) {
        return ip.equals("0:0:0:0:0:0:0:1") ? "LocalHost [127.0.0.1]" : ip;
    }
}

