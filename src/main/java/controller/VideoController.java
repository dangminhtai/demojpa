package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import entity.Category;
import entity.Video;
import services.CategoryService;
import services.VideoService;

@WebServlet(urlPatterns = {"/videos", "/videos/create", "/videos/update", "/videos/delete", "/videos/reset"})
public class VideoController extends HttpServlet {
    
    private static final long serialVersionUID = 1L;
    private VideoService videoService;
    private CategoryService categoryService;

    @Override
    public void init() throws ServletException {
        super.init();
        this.videoService = new VideoService();
        this.categoryService = new CategoryService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String url = req.getRequestURL().toString();
        Video video = null;

        if (url.contains("delete")) {
            try {
                String id = req.getParameter("id");
                videoService.delete(id);
                req.setAttribute("message", "Xóa thành công!");
            } catch (Exception e) {
                req.setAttribute("error", "Lỗi: " + e.getMessage());
            }
            video = new Video();
        } else if (url.contains("update")) {
            try {
                String id = req.getParameter("id");
                video = videoService.findById(id);
            } catch (Exception e) {
                req.setAttribute("error", "Lỗi tải dữ liệu video!");
            }
        } else if (url.contains("reset")) {
            video = new Video();
        }

        if (video == null) {
            video = new Video();
        }

        List<Video> list = null;
        String keyword = req.getParameter("keyword");
        
        if (keyword != null && !keyword.isEmpty()) {
            list = videoService.findByTitle(keyword);
        } else {
            list = videoService.findAll();
        }

        List<Category> categories = categoryService.findAll();
        
        req.setAttribute("video", video);
        req.setAttribute("list", list);
        req.setAttribute("categories", categories);
        
        req.getRequestDispatcher("/views/video-list.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String url = req.getRequestURL().toString();
        req.setCharacterEncoding("UTF-8");
        
        Video video = new Video();
        try {
            video.setVideoId(req.getParameter("videoId"));
            video.setTitle(req.getParameter("title"));
            video.setPoster(req.getParameter("poster"));
            video.setDescription(req.getParameter("description"));
            
            String viewsStr = req.getParameter("views");
            if (viewsStr != null && !viewsStr.isEmpty()) {
                video.setViews(Integer.parseInt(viewsStr));
            }
            
            String activeStr = req.getParameter("active");
            if (activeStr != null && !activeStr.isEmpty()) {
                video.setActive(Integer.parseInt(activeStr));
            }
            
            String categoryIdStr = req.getParameter("categoryId");
            if (categoryIdStr != null && !categoryIdStr.isEmpty()) {
                Category category = categoryService.findById(Integer.parseInt(categoryIdStr));
                video.setCategory(category);
            }

            if (url.contains("create")) {
                videoService.insert(video);
                req.setAttribute("message", "Thêm mới thành công!");
                video = new Video(); 
            } else if (url.contains("update")) {
                videoService.update(video);
                req.setAttribute("message", "Cập nhật thành công!");
            }
        } catch (Exception e) {
            req.setAttribute("error", "Lỗi: " + e.getMessage());
        }

        List<Video> list = videoService.findAll();
        List<Category> categories = categoryService.findAll();
        
        req.setAttribute("video", video);
        req.setAttribute("list", list);
        req.setAttribute("categories", categories);
        
        req.getRequestDispatcher("/views/video-list.jsp").forward(req, resp);
    }
}
