package mr.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.regex.Pattern;

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
		DB db = mongoClient.getDB("medrecord");
		DBCollection coll = db.getCollection("recipe");
		DBObject doc = coll.findOne(new BasicDBObject("name", name));
		if(doc == null)
			return null;
		else
			return coll.findOne(new BasicDBObject("name", name)).get("description");
	}
	
	public List<DBObject> searchBeginWith(String name){
		DB db = mongoClient.getDB("medrecord");
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
		String sql = "select name,pinci from recipe where abbr like '" + abbr + "%' order by abbr";
		return jdbcTemplate.queryForList(sql); 
	}
	
	public List pinciSearch(int freq){
		String sql = "select name,pinci from recipe order by pinci";
		if(freq == 0)
			sql += " DESC";
		return jdbcTemplate.queryForList(sql); 
	}
	
}
