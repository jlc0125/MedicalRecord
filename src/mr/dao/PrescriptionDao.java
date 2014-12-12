package mr.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import mr.domain.Prescription;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowCallbackHandler;
import org.springframework.stereotype.Repository;

@Repository
public class PrescriptionDao {
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
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
}
