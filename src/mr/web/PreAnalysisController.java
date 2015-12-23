package mr.web;

import java.util.Map;

import mr.service.PreAnalysisService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("pre_analysis")
public class PreAnalysisController {
	@Autowired
	private PreAnalysisService preS;
	
	@RequestMapping()
	public String preAnalysisPage(){
		return "record_pre_analysis";
	}
	
	@RequestMapping("home")
	public String homePage(){
		return "pre_search";
	}
	
	@RequestMapping("retval")
	@ResponseBody
	public Map<String,Object> getPreMap(@RequestParam String pre){
		String[] preSeg=IKAnalizer.IKAnalysis(pre).trim().split(" ");
		Map<String,Object> result=preS.getPreMap(preSeg);
		return result;
	}

}
