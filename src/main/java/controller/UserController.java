package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import entity.User;
import services.UserService;

import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.Part;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
                 maxFileSize = 1024 * 1024 * 10,      // 10MB
                 maxRequestSize = 1024 * 1024 * 50)   // 50MB
@WebServlet(urlPatterns = {"/users", "/users/create", "/users/update", "/users/delete", "/users/reset"})
public class UserController extends HttpServlet {
    
    private static final long serialVersionUID = 1L;
    private UserService userService;

    @Override
    public void init() throws ServletException {
        super.init();
        this.userService = new UserService();
    }

    // ... doGet implementation remains same ...

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String url = req.getRequestURL().toString();
        req.setCharacterEncoding("UTF-8");
        
        User user = new User();
        try {
            String idStr = req.getParameter("id");
            if (idStr != null && !idStr.isEmpty()) {
                user.setId(Integer.parseInt(idStr));
            }
            user.setUsername(req.getParameter("username"));
            user.setPassword(req.getParameter("password"));
            user.setFullname(req.getParameter("fullname"));
            user.setEmail(req.getParameter("email"));
            user.setPhone(req.getParameter("phone"));
            
            // Handle File Upload
            String uploadPath = getServletContext().getRealPath("") + "uploads";
            Files.createDirectories(Paths.get(uploadPath));
            
            Part filePart = req.getPart("images");
            if (filePart != null && filePart.getSize() > 0) {
                String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                filePart.write(uploadPath + "/" + fileName);
                user.setImages("uploads/" + fileName);
            } else {
                // Keep old image if not updating
                user.setImages(req.getParameter("currentImage"));
            }

            user.setAdmin(req.getParameter("admin") != null);
            user.setActive(req.getParameter("active") != null);

            if (url.contains("create")) {
                userService.insert(user);
                req.setAttribute("message", "Thêm mới thành công!");
                user = new User(); 
            } else if (url.contains("update")) {
                userService.update(user);
                req.setAttribute("message", "Cập nhật thành công!");
            }
        } catch (Exception e) {
            req.setAttribute("error", "Lỗi: " + e.getMessage());
            e.printStackTrace();
        }

        List<User> list = userService.findAll();
        req.setAttribute("user", user);
        req.setAttribute("list", list);
        
        req.getRequestDispatcher("/views/user-list.jsp").forward(req, resp);
    }
}
