package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import entity.Category;
import entity.User;
import services.CategoryService;

@WebServlet(urlPatterns = {"/user/home", "/manager/home", "/admin/home", "/category/create", "/category/update", "/category/delete"})
public class CategoryController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private CategoryService categoryService = new CategoryService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String url = req.getRequestURI();
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("account");
        
        // Safety check if filter missed it or direct access
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        if (url.contains("home")) {
            List<Category> list = null;
            if (user.getRoleid() == 2) { // Manager
                list = categoryService.findByUserId(user.getId());
            } else { // User (1) or Admin (3)
                list = categoryService.findAll();
            }
            req.setAttribute("list", list);
            req.getRequestDispatcher("/views/category-list.jsp").forward(req, resp);
        } else if (url.contains("create")) {
            req.getRequestDispatcher("/views/category-form.jsp").forward(req, resp);
        } else if (url.contains("update")) {
            int id = Integer.parseInt(req.getParameter("id"));
            Category category = categoryService.findById(id);
            // Check ownership
            if (category.getUser() != null && category.getUser().getId() != user.getId()) {
                 // Requirement: "thêm, sửa, xem, xóa category của chính mình tạo ra"
                 // If admin can edit all, remove this check for admin. But let's stick to "own" for now or allow Admin.
                 // Let's assume Admin (3) can edit all.
                 if (user.getRoleid() != 3) {
                    resp.sendRedirect(req.getContextPath() + getHomeUrl(user.getRoleid()) + "?error=NotOwner");
                    return;
                 }
            }
            req.setAttribute("category", category);
            req.getRequestDispatcher("/views/category-form.jsp").forward(req, resp);
        } else if (url.contains("delete")) {
            int id = Integer.parseInt(req.getParameter("id"));
            Category category = categoryService.findById(id);
             // Check ownership
            if (category.getUser() != null && category.getUser().getId() != user.getId()) {
                 if (user.getRoleid() != 3) {
                    resp.sendRedirect(req.getContextPath() + getHomeUrl(user.getRoleid()) + "?error=NotOwner");
                    return;
                 }
            }
            try {
                categoryService.delete(id);
            } catch (Exception e) {
                e.printStackTrace();
            }
            resp.sendRedirect(req.getContextPath() + getHomeUrl(user.getRoleid()));
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String url = req.getRequestURI();
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("account");
        
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        Category category = new Category();
        String idStr = req.getParameter("categoryId");
        if (idStr != null && !idStr.isEmpty()) {
            category.setCategoryId(Integer.parseInt(idStr));
        }
        category.setCategoryname(req.getParameter("categoryname"));
        category.setCategorycode(req.getParameter("categorycode"));
        category.setImages(req.getParameter("images"));
        String statusStr = req.getParameter("status");
        if (statusStr != null && !statusStr.isEmpty()) {
             category.setStatus(Integer.parseInt(statusStr));
        }
        
        // Preserve owner or set new
        if (url.contains("create")) {
            category.setUser(user);
            categoryService.insert(category);
        } else if (url.contains("update")) {
             // Check ownership before update
            Category oldCat = categoryService.findById(category.getCategoryId());
            if (oldCat.getUser() != null && oldCat.getUser().getId() != user.getId()) {
                if (user.getRoleid() != 3) {
                    resp.sendRedirect(req.getContextPath() + getHomeUrl(user.getRoleid()) + "?error=NotOwner");
                    return;
                }
            }
            category.setUser(oldCat.getUser()); // Keep original owner
            categoryService.update(category);
        }

        resp.sendRedirect(req.getContextPath() + getHomeUrl(user.getRoleid()));
    }
    
    private String getHomeUrl(int roleId) {
        if (roleId == 1) return "/user/home";
        if (roleId == 2) return "/manager/home";
        if (roleId == 3) return "/admin/home";
        return "/login";
    }
}
