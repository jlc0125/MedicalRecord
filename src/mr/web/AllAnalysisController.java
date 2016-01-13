package mr.web;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class AllAnalysisController {
	
	@RequestMapping(value = "/analysis_all")
	public String analysisPage(){
		return "analysis_all";
	}
}
