package filter;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import entity.User;

@WebFilter(urlPatterns = "/*")
public class AuthorizationFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;
        String url = req.getRequestURI();

        if (url.contains("/login") || url.contains("/logout") || url.endsWith(".css") || url.endsWith(".js") || url.endsWith(".png") || url.endsWith(".jpg")) {
            chain.doFilter(request, response);
            return;
        }

        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("account");

        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        int role = user.getRoleid();
        
        if (url.contains("/admin") && role != 3) {
            resp.sendRedirect(req.getContextPath() + "/login?error=Unauthorized");
            return;
        }
        
        if (url.contains("/manager") && role != 2) {
             resp.sendRedirect(req.getContextPath() + "/login?error=Unauthorized");
             return;
        }
        
        if (url.contains("/user") && role != 1) {
             // Maybe allow admin/manager to access user pages? Requirement says "Redirect to URL corresponding to role".
             // It doesn't explicitly forbid access, but usually role-based URLs are strict.
             // However, "Trang home của role user và admin sẽ hiển thị danh sách tất cả category".
             // This implies Admin might access /admin/home, and User /user/home.
             // If Admin tries to access /user/home, maybe it's allowed?
             // But let's stick to strict separation based on URL prefix for now as per "Dùng Filter để lọc URL tương ứng với RoleID".
             resp.sendRedirect(req.getContextPath() + "/login?error=Unauthorized");
             return;
        }

        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
    }
}
