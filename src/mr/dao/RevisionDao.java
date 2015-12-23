package mr.dao;


import java.text.SimpleDateFormat;
import java.util.Date;

import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;


import mr.domain.Revision;
@Repository
public class RevisionDao {
	@Autowired
	JdbcTemplate jdbcTemplate;
	
	public Revision getRevisionById(){
		return null;
	};
	
	public void addRevision(Revision revision){
//		System.out.println(revision.getAdvise());
		String advise = revision.getAdvise();
		String comment = revision.getComment();
		Date createDate = revision.getCreateDate();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String dateString = sdf.format(createDate);
		
		int state = revision.getState();
		int type = revision.getRevisionType();
		String sqlStr=String.format("insert into revision (advise, comment, create_date, state, type)"
				+ " values('%s','%s','%s',%d,%d)",new Object[]{advise, comment, dateString, state, type});
		jdbcTemplate.execute(sqlStr);
	}


	
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
