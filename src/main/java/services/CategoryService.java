package services;

import java.util.List;
import dao.CategoryDao;
import entity.Category;

public class CategoryService {
    
    private CategoryDao categoryDao;

    public CategoryService() {
        this.categoryDao = new CategoryDao();
    }

    public void insert(Category category) {
        categoryDao.insert(category);
    }

    public void update(Category category) {
        categoryDao.update(category);
    }

    public void delete(int id) throws Exception {
        categoryDao.delete(id);
    }

    public Category findById(int id) {
        return categoryDao.findById(id);
    }

    public List<Category> findAll() {
        return categoryDao.findAll();
    }

    public List<Category> findByUserId(int userId) {
        return categoryDao.findByUserId(userId);
    }
}
