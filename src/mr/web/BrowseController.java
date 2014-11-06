package mr.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/Browse")
public class BrowseController {
	
	@RequestMapping(value="")
	public String browsePage(){
		return "browse";
	}
	
}
