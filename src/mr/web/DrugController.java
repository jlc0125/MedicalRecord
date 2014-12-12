package mr.web;

import java.util.Arrays;
import java.util.List;

import mr.service.DrugService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mongodb.DBObject;

@Controller
public class DrugController {
	@Autowired
	private DrugService drugService;
	
	@RequestMapping("/drughome")
	public String home(Model model){
		String[] name = {"茯苓",  "白芍",  "甘草",  "当归",  "杏仁", "半夏",  "黄岑", 
				"白术",  "桂枝",  "连翘",  "枳壳",  "赤芍",  "柴胡",  "泽泻 ",
				"茯神",  "党参",  "竹茹",  "丹参",  "山药",  "知母",  "川芎", 
				"砂仁",  "桔梗",  "石斛", "桑叶",  "远志",  "生姜",  "橘红"};
		model.addAttribute("name", name);
		return "drughome";
	}
	
	@RequestMapping("/drug")
	public String drug(@RequestParam(value="q", required=false)String drugName, Model model){
		String[] name = {"茯苓",  "白芍",  "甘草",  "当归",  "杏仁", 
				"白术",  "桂枝",  "连翘",   "柴胡",  "泽泻 ",
				"茯神",   "竹茹",  "丹参",  "山药",  "知母", 
				"砂仁",  "桔梗",  "桑叶",  "生姜",  "橘红"};
		if(drugName!=null && drugName!=""){
			try {
				drugName = new String(drugName.getBytes("iso-8859-1"), "UTF-8");
				String[] temp = drugService.relate(drugName);
				if(temp != null)
					name =  temp;
				model.addAttribute("drugName", drugName);
			} catch (Exception e) {
				model.addAttribute("error", 1);
			}
		}
		model.addAttribute("name", name);
		return "drug";
	}
	
	@ResponseBody
	@RequestMapping("/drug/search")
	public Object search(@RequestParam(value="q", required=false)String drugName){
		if(drugName==null || drugName=="")
			return null;
		return drugService.search(drugName);
	}
	
	@ResponseBody
	@RequestMapping("/drug/hint")
	public List<DBObject> hint(@RequestParam(value="q", required=false)String drugName){
		return drugService.searchBeginWith(drugName);
	}
	
	@ResponseBody
	@RequestMapping("/drug/pinyin")
	public List pinyin(@RequestParam(value="q", required=false)String abbr){
		return drugService.abbrBeginWith(abbr);
	}
	
	@ResponseBody
	@RequestMapping("/drug/pinci")
	public List pinci(@RequestParam(value="q", required=false)int freq){
		return drugService.pinciSearch(freq);
	}
	
}
