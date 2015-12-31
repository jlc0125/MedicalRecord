package mr.web;

import java.util.List;

import mr.domain.BookComment;
import mr.service.BookCommentService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/read")
public class ReadController {
	@Autowired
	private BookCommentService bcService;

	@RequestMapping("/{bookId}")
	public String readPage(){
		return "test";
	}

	@RequestMapping("post_comment")
	@ResponseBody
	public int postComment(@RequestParam("bid") long bid, @RequestParam("uid") long uid,@RequestParam("page") int page, @RequestParam("cont") String content){
		bcService.addComment(bid, uid, page, content);
		return 0;
	}
	
	@RequestMapping("get_comment")
	@ResponseBody
	public List<BookComment> getComment(@RequestParam("bid") long bid,@RequestParam("page") int page){
		return bcService.commentByPage(bid, page);

	}
	
	@RequestMapping("/test")
	public String readPage2(){
		return "test2";
	}
}
