package mr.web;

import java.util.List;

import mr.domain.TempNode;
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
		return "drughome";
	}
	
	@RequestMapping("/drug")
	public String drug(@RequestParam(value="q", required=false)String name,  int option, Model model){
		if(name!=null && name!=""){
			try {
				name = new String(name.getBytes("iso-8859-1"), "UTF-8");
				model.addAttribute("option", option);
				if(option == 1){
					TempNode[] nodes = drugService.symptomSearchDrug(name);
					if(nodes == null){
						model.addAttribute("noResult", 1);
					}
					else{
						model.addAttribute("searchName", name);
						model.addAttribute("nodes", nodes);
					}
					return "drughome";
				}
				else if(option == 2){
					TempNode[] nodes = drugService.recipeSearchDrug(name);
					if(nodes == null){
						model.addAttribute("noResult", 1);
					}
					else{
						model.addAttribute("searchName", name);
						model.addAttribute("nodes", nodes);
					}
					return "drughome";
				}
				else{
					model.addAttribute("drugName", name);
					return "drug";
				}
			} catch (Exception e) {
				model.addAttribute("error", 1);
				return "drughome";
			}
		}
		else{
			return "drughome";
		}
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
