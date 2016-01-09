package mr.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Pattern;

import mr.domain.Prescription;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowCallbackHandler;
import org.springframework.stereotype.Repository;

import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;
import com.mongodb.MongoClient;

@Repository
public class PrescriptionDao {
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private MongoClient mongoClient;
	
	public List<Prescription> allPre(){
		final List<Prescription> result=new ArrayList<Prescription>();
		String sqlStr="select prescription_id,pre_name_zh,pre_dosage from prescription";
		jdbcTemplate.query(sqlStr, 
			new RowCallbackHandler(){

				@Override
				public void processRow(ResultSet rs) throws SQLException {
					Prescription pre= new Prescription();
					pre.setId(rs.getLong(1));
					pre.setName(rs.getString(2));
					pre.setDosage(rs.getString(3));
					result.add(pre);
				}
				
					
			}
		);
		return result;
	}
	
	public List<DBObject> recipePrescription(String name){
		DB db = mongoClient.getDB("medrecord201512");
		DBCollection coll = db.getCollection("prescription");
		BasicDBObject cond = new BasicDBObject();
		cond.put("name", name);
		DBObject field = new BasicDBObject();
		field.put("_id", false);
		field.put("name", true);
		DBCursor cur = coll.find(cond);
		
		List<DBObject> res= new ArrayList<DBObject>();
		DBObject tmp;
		while(cur.hasNext()){
			DBObject doc = new BasicDBObject();
			tmp = cur.next();
			doc.put("name", tmp.get("name"));
			doc.put("description", tmp.get("description"));
			res.add(doc);
		}
		return res;
	}
	
}
