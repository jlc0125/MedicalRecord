package mr.web;

import java.util.List;

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
	
	@RequestMapping("/recipe")
	public String recipe(Model model){
		String[] name = {"散偏汤",  "散痹汤",  "十宝丹",  "七液丹",  "郁金散", "豢龙汤",  "藿香正气散", 
				"椒梅汤",  "养阴汤",  "分清止淋丸",  "加味补中益气汤",  "白头翁汤",  "消毒散",  "黑归脾丸 ",
				"芙蓉膏",  "加味异功散",  "乌头煎",  "茱萸汤",  "蒿芩清胆汤",  "开郁汤",  "清宫解毒饮", 
				"香粉",  "左归丸",  "达原饮", "龟鹿胶",  "四兽饮",  "全生白术散",  "解表散"};
		model.addAttribute("name", name);
		return "recipe";
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
}
