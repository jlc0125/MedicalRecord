package mr.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class RevisionDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	//获取所有的修改意见表
	public List getRevisionList(){
		String sql = "select * from revision";
		List revisionList = jdbcTemplate.queryForList(sql);
		return revisionList;
	}
	
	public void setAgree(int agree,int id){
		String sql = "update revision set agree=" + agree + " where id="+id;
		jdbcTemplate.execute(sql);
	}
	
	public void setDisagree(int disagree,int id){
		String sql = "update revision set disagree=" + disagree + " where id="+id;
		jdbcTemplate.execute(sql);
	}
}
