package services;

import java.util.List;
import dao.VideoDao;
import entity.Video;

public class VideoService {
    
    private VideoDao videoDao;

    public VideoService() {
        this.videoDao = new VideoDao();
    }

    public void insert(Video video) {
        videoDao.insert(video);
    }

    public void update(Video video) {
        videoDao.update(video);
    }

    public void delete(String id) throws Exception {
        videoDao.delete(id);
    }

    public Video findById(String id) {
        return videoDao.findById(id);
    }

    public List<Video> findAll() {
        return videoDao.findAll();
    }
    public List<Video> findByTitle(String title) {
        return videoDao.findByTitle(title);
    }
}
