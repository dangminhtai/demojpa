package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import entity.User;
import services.UserService;

@WebServlet(urlPatterns = {"/login", "/logout"})
public class LoginController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String url = req.getRequestURL().toString();
        if (url.contains("logout")) {
            HttpSession session = req.getSession();
            session.invalidate();
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String username = req.getParameter("username");
        String pass = req.getParameter("password");
        String remember = req.getParameter("remember");

        User user = userService.login(username, pass);

        if (user != null) {
            HttpSession session = req.getSession();
            session.setAttribute("account", user);

            if (remember != null) {
                Cookie cUsername = new Cookie("username", username);
                Cookie cPass = new Cookie("password", pass);
                cUsername.setMaxAge(30 * 24 * 60 * 60);
                cPass.setMaxAge(30 * 24 * 60 * 60);
                resp.addCookie(cUsername);
                resp.addCookie(cPass);
            }

            // Redirect based on role
            // 1: User, 2: Manager, 3: Admin
            int role = user.getRoleid();
            if (role == 1) {
                resp.sendRedirect(req.getContextPath() + "/user/home");
            } else if (role == 2) {
                resp.sendRedirect(req.getContextPath() + "/manager/home");
            } else if (role == 3) {
                resp.sendRedirect(req.getContextPath() + "/admin/home");
            } else {
                resp.sendRedirect(req.getContextPath() + "/login?error=InvalidRole");
            }
        } else {
            req.setAttribute("error", "Sai tên đăng nhập hoặc mật khẩu");
            req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
        }
    }
}
