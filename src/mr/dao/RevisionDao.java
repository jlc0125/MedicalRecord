package mr.dao;

import java.text.SimpleDateFormat;
import java.util.Date;

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
		int type = revision.getType();
		String sqlStr=String.format("insert into revision (advise, comment, create_date, state, type)"
				+ " values('%s','%s','%s',%d,%d)",new Object[]{advise, comment, dateString, state, type});
		jdbcTemplate.execute(sqlStr);
		
	}
}
