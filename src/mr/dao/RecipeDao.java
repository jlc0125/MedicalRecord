package mr.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

import mr.domain.TempNode;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;
import com.mongodb.MongoClient;

@Repository
public class RecipeDao {
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private MongoClient mongoClient;
	
	public Object search(String name){
		DB db = mongoClient.getDB("medrecord201512");
		DBCollection coll = db.getCollection("recipe");
		DBObject doc = coll.findOne(new BasicDBObject("name", name));
		if(doc == null)
			return null;
		else
			return coll.findOne(new BasicDBObject("name", name)).get("description");
	}
	
	public List<DBObject> searchBeginWith(String name){
		DB db = mongoClient.getDB("medrecord201512");
		DBCollection coll = db.getCollection("recipe");
		BasicDBObject cond = new BasicDBObject();
		Pattern pattern = Pattern.compile("^"+name+".*$");
		cond.put("name", pattern);
		DBObject field = new BasicDBObject();
		field.put("_id", false);
		field.put("name", true);
		DBCursor cur = coll.find(cond, field).limit(10);
		
		List<DBObject> res= new ArrayList<DBObject>();
		DBObject tmp;
		while(cur.hasNext()){
			DBObject doc = new BasicDBObject();
			tmp = cur.next();
			doc.put("label", tmp.get("name"));
			doc.put("name", tmp.get("name"));
			res.add(doc);
		}
		return res;
	}
	
	public List abbrBeginWith(String abbr){
		String sql = "select name,pinci from recipe201512 where abbr like '" + abbr + "%' order by abbr";
		return jdbcTemplate.queryForList(sql); 
	}
	
	public List pinciSearch(int freq){
		String sql = "select name,pinci from recipe201512 order by pinci";
		if(freq == 0)
			sql += " DESC";
		return jdbcTemplate.queryForList(sql); 
	}
	
	public TempNode[] symptomSearchRecipe(String symptomName){
		String sql = "select recipe,recipe_pinci from symptom201512 where name= '" + symptomName + "'";
		 List<Map<String, Object>> rows = jdbcTemplate.queryForList(sql); 
		 if(rows.isEmpty())
			 return null;
		 else {
			 Map<String, Object> res = rows.get(0);
			 String name = (String) res.get("recipe");
			 String pinci = (String) res.get("recipe_pinci");
			 TempNode[] ret = null;
			 if(name != null){
				 String[] names = name.split(" ");
				 String[] pincis = pinci.split(" ");
				 
				 int num = names.length > 5 ? 5 : names.length;
				 ret = new TempNode[num];
				 for(int i=0; i<num; i++){
					 ret[i] = new TempNode(i+1, names[i], pincis[i]);
				 }
			 }
			 return ret;
		 }
	}
	
	public TempNode[] drugSearchRecipe(String drugName){
		String sql = "select recipe,recipe_pinci from drug201512 where name= '" + drugName + "'";
		 List<Map<String, Object>> rows = jdbcTemplate.queryForList(sql); 
		 if(rows.isEmpty())
			 return null;
		 else {
			 Map<String, Object> res = rows.get(0);
			 String name = (String) res.get("recipe");
			 String pinci = (String) res.get("recipe_pinci");
			 TempNode[] ret = null;
			 if(name != null){
				 String[] names = name.split(" ");
				 String[] pincis = pinci.split(" ");
				 
				 int num = names.length > 5 ? 5 : names.length;
				 ret = new TempNode[num];
				 for(int i=0; i<num; i++){
					 ret[i] = new TempNode(i+1, names[i], pincis[i]);
				 }
			 }
			 return ret;
		 }
	}
	
}
