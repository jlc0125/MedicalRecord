package mr.service;

import java.util.ArrayList;
import java.util.List;

import mr.dao.BookCommentDao;
import mr.domain.BookComment;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;


@Service
public class BookCommentService {
	@Autowired
	private BookCommentDao bcDao;
	
	public BookComment commentById(Long id){
		return bcDao.commentById(id);
	}
	
	public void addComment(long bid, long uid, int page, String content){
		bcDao.addComment(bid, uid, page, content);
	}
	
	public List<BookComment> commentByPage(long bid, int page){
		return bcDao.commnetByPage(bid, page);
	}
}