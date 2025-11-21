package services;

import java.util.List;
import dao.UserDao;
import entity.User;

public class UserService {
    
    private UserDao userDao;

    public UserService() {
        this.userDao = new UserDao();
    }

    public void insert(User user) throws Exception {
        validate(user);
        userDao.insert(user);
    }

    public void update(User user) throws Exception {
        validate(user);
        userDao.update(user);
    }

    public void delete(int id) throws Exception {
        userDao.delete(id);
    }

    public User findById(int id) {
        return userDao.findById(id);
    }

    public List<User> findAll() {
        return userDao.findAll();
    }
    
    private void validate(User user) throws Exception {
        if (user.getUsername() == null || user.getUsername().trim().isEmpty()) {
            throw new Exception("Username không được để trống");
        }
        if (user.getPassword() == null || user.getPassword().trim().isEmpty()) {
            throw new Exception("Password không được để trống");
        }
        if (user.getEmail() == null || !user.getEmail().contains("@")) {
            throw new Exception("Email không hợp lệ");
        }
    }
}
