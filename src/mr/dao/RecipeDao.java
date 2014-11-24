package mr.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBObject;
import com.mongodb.MongoClient;

@Repository
public class RecipeDao {
	@Autowired
	private MongoClient mongoClient;
	
	public Object search(String name){
		DB db = mongoClient.getDB("medrecord");
		DBCollection coll = db.getCollection("fangji");
		DBObject doc = coll.findOne(new BasicDBObject("name", name));
		if(doc == null)
			return null;
		else
			return coll.findOne(new BasicDBObject("name", name)).get("description");
	}
}
