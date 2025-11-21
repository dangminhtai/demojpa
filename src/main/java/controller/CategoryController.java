package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import entity.Category;
import services.CategoryService;

@WebServlet(urlPatterns = {"/categories", "/categories/create", "/categories/update", "/categories/delete", "/categories/reset"})
public class CategoryController extends HttpServlet {
    
    private static final long serialVersionUID = 1L;
    private CategoryService categoryService;

    @Override
    public void init() throws ServletException {
        super.init();
        this.categoryService = new CategoryService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String url = req.getRequestURL().toString();
        Category category = null;

        if (url.contains("delete")) {
            try {
                int id = Integer.parseInt(req.getParameter("id"));
                categoryService.delete(id);
                req.setAttribute("message", "Xóa thành công!");
            } catch (Exception e) {
                req.setAttribute("error", "Lỗi: " + e.getMessage());
            }
            category = new Category();
        } else if (url.contains("update")) {
            try {
                int id = Integer.parseInt(req.getParameter("id"));
                category = categoryService.findById(id);
            } catch (Exception e) {
                req.setAttribute("error", "Lỗi tải dữ liệu category!");
            }
        } else if (url.contains("reset")) {
            category = new Category();
        }

        if (category == null) {
            category = new Category();
        }

        List<Category> list = categoryService.findAll();
        req.setAttribute("category", category);
        req.setAttribute("list", list);
        
        req.getRequestDispatcher("/views/category-list.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String url = req.getRequestURL().toString();
        req.setCharacterEncoding("UTF-8");
        
        Category category = new Category();
        try {
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

            if (url.contains("create")) {
                categoryService.insert(category);
                req.setAttribute("message", "Thêm mới thành công!");
                category = new Category(); 
            } else if (url.contains("update")) {
                categoryService.update(category);
                req.setAttribute("message", "Cập nhật thành công!");
            }
        } catch (Exception e) {
            req.setAttribute("error", "Lỗi: " + e.getMessage());
        }

        List<Category> list = categoryService.findAll();
        req.setAttribute("category", category);
        req.setAttribute("list", list);
        
        req.getRequestDispatcher("/views/category-list.jsp").forward(req, resp);
    }
}
