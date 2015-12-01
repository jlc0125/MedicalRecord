package mr.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/book")
public class BookController {
	@RequestMapping(value="")
	public String anaPage(){
		return "book";
	}
}
