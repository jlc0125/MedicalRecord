package mr.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/Analiysis")
public class AnaliysisController {
	@RequestMapping(value="")
	public String anaPage(){
		return "analiysis";
	}
	
	@RequestMapping(value="bz")
	public String bz(@RequestParam("wd") String wd){
		return "analiysis";
	}
	
}
