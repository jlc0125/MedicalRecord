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
	@ResponseBody
	@RequestMapping("/recipe")
	public TempNode[] recipe(@RequestParam(value="q", required=false)String name, int option){
		System.out.println(option);
		try {
			if(option == 1){
				System.out.println(name);
				TempNode[] nodes = recipeService.symptomSearchRecipe(name);
				return nodes;
			}
			else if(option == 2){
				TempNode[] nodes = recipeService.drugSearchRecipe(name);
				return nodes;
			}
		} catch (Exception e) {
			return null;
		}
		return null;
		
		
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
