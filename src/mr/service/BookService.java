package mr.service;

import java.util.List;

import mr.dao.BookDao;
import mr.domain.Book;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class BookService {
	@Autowired
	private BookDao bookDao;
	
	public Book getById(long id){
		return bookDao.getById(id);
	}
	
	public List<Book> getAll(){
		return bookDao.getAll();
	}
}
