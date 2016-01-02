package mr.web;

import java.util.List;

import mr.domain.Book;
import mr.service.BookService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/book")
public class BookController {
	@Autowired
	private BookService bookService;
		
	@RequestMapping(value="")
	public String bookPage(){
		return "book";
	}
	
	@RequestMapping(value="/get")
	@ResponseBody
	public Book getBook(@RequestParam("bid") long bid){
		return bookService.getById(bid);
	}
	
	@RequestMapping(value="/get_all")
	@ResponseBody
	public List<Book> getAllBook(){
		return bookService.getAll();
	}
	
	@RequestMapping(value="/search")
	@ResponseBody
	public List<Book> searchBook(@RequestParam("q") String keyword){
		return bookService.search(keyword);
	}
	
	@RequestMapping(value="/pinyin_filter")
	@ResponseBody
	public List<Book> filteBook(@RequestParam("c") char c){
		return bookService.filter(c);
	}
}
