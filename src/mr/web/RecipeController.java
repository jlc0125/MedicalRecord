package mr.web;

import java.util.List;

import mr.domain.TempNode;
import mr.service.RecipeService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mongodb.DBObject;

@Controller
public class RecipeController{
	@Autowired
	private RecipeService recipeService;
	
	@RequestMapping("/analysishome")
	public String index(){
		return "analysishome";
	}
	
	@RequestMapping("/recipehome")
	public String recipehome(Model model){
		return "recipehome";
	}
	
	@RequestMapping("/recipe")
	public String recipe(@RequestParam(value="q", required=false)String name, int option, Model model){
		if(name!=null && name!=""){
			try {
				name = new String(name.getBytes("iso-8859-1"), "UTF-8");
				model.addAttribute("option", option);
				if(option == 1){
					TempNode[] nodes = recipeService.symptomSearchRecipe(name);
					if(nodes == null){
						model.addAttribute("noResult", 1);
					}
					else{
						model.addAttribute("searchName", name);
						model.addAttribute("nodes", nodes);
					}
					return "recipehome";
				}
				else if(option == 2){
					TempNode[] nodes = recipeService.drugSearchRecipe(name);
					if(nodes == null){
						model.addAttribute("noResult", 1);
					}
					else{
						model.addAttribute("searchName", name);
						model.addAttribute("nodes", nodes);
					}
					return "recipehome";
				}
				else{
					model.addAttribute("recipeName", name);
					return "recipe";
				}
			} catch (Exception e) {
				model.addAttribute("error", 1);
				return "recipehome";
			}
		}
		else{
			return "recipehome";
		}
	}
	
	@ResponseBody
	@RequestMapping("/recipe/search")
	public Object search(@RequestParam(value="q", required=false)String recipeName){
		if(recipeName==null || recipeName=="")
			return null;
		return recipeService.search(recipeName);
	}
	
	@ResponseBody
	@RequestMapping("/recipe/hint")
	public List<DBObject> hint(@RequestParam(value="q", required=false)String recipeName){
		return recipeService.searchBeginWith(recipeName);
	}
	
	@ResponseBody
	@RequestMapping("/recipe/pinyin")
	public List pinyin(@RequestParam(value="q", required=false)String abbr){
		return recipeService.abbrBeginWith(abbr);
	}
	
	@ResponseBody
	@RequestMapping("/recipe/pinci")
	public List pinci(@RequestParam(value="q", required=false)int freq){
		return recipeService.pinciSearch(freq);
	}
	
}
