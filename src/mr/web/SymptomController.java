package mr.web;

import java.util.List;

import mr.service.SymptomService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mongodb.DBObject;

@Controller
public class SymptomController {
	@Autowired
	private SymptomService symptomService;
	
	@RequestMapping("/symptomhome")
	public String home(Model model){
		String[] name = {"咳嗽",  "发热",  "腹痛",  "头痛",  "口渴", "腹胀",  "呕吐", 
				"心悸",  "自汗",  "瘀血",  "伤寒",  "神昏",  "眩晕",  "耳鸣 ",
				"恶心",  "感冒",  "不寐",  "吐血",  "腰痛",  "出血",  "气喘", 
				"胁痛",  "盗汗",  "内伤",  "失眠",  "肾水",  "咽痛",  "风温"};
		model.addAttribute("name", name);
		return "symptomhome";
	}
	
	@RequestMapping("/symptom")
	public String symptom(@RequestParam(value="q", required=false)String symptomName, Model model){
		String[] name = {"咳嗽",  "发热",  "伤寒",   "感冒", "盗汗", 
				"腹痛",  "头痛",  "腰痛",  "胁痛",  "咽痛",
				"瘀血", "吐血",   "出血",  "腹胀",  "呕吐", 
				"心悸",  "自汗",   "神昏",  "眩晕",  "耳鸣 "};
		if(symptomName!=null && symptomName!=""){
			try {
				symptomName = new String(symptomName.getBytes("iso-8859-1"), "UTF-8");
				String[] temp = symptomService.relate(symptomName);
				if(temp != null)
					name =  temp;
				model.addAttribute("symptomName", symptomName);
			} catch (Exception e) {
				model.addAttribute("error", 1);
			}
		}
		model.addAttribute("name", name);
		return "symptom";
	}
	
	@ResponseBody
	@RequestMapping("/symptom/search")
	public Object search(@RequestParam(value="q", required=false)String symptomName){
		if(symptomName==null || symptomName=="")
			return null;
		return symptomService.search(symptomName);
	}
	
	@ResponseBody
	@RequestMapping("/symptom/hint")
	public List<DBObject> hint(@RequestParam(value="q", required=false)String symptomName){
		return symptomService.searchBeginWith(symptomName);
	}
	
	@ResponseBody
	@RequestMapping("/symptom/pinyin")
	public List pinyin(@RequestParam(value="q", required=false)String abbr){
		return symptomService.abbrBeginWith(abbr);
	}
	
	@ResponseBody
	@RequestMapping("/symptom/pinci")
	public List pinci(@RequestParam(value="q", required=false)int freq){
		return symptomService.pinciSearch(freq);
	}
}
