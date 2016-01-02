package mr.service;

import java.util.ArrayList;
import java.util.List;

import mr.dao.BookDao;
import mr.domain.Book;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import net.sourceforge.pinyin4j.PinyinHelper;

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
	
	public List<Book> search(String keyword){
		return bookDao.search(keyword);
	}
	
	public List<Book> filter(char c){
		List<Book> allBook = bookDao.getAll();
		List<Book> result = new ArrayList<Book>();
		for (Book book:allBook){
			String[] pinyin = PinyinHelper.toHanyuPinyinStringArray(book.getTitle().charAt(0));
			if(pinyin[0].charAt(0)== c){
				result.add(book);
			}
		}
		return result;
		
	}
}
