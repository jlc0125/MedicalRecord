package mr.dao;

import java.sql.ResultSet;
import java.sql.SQLException;

import mr.domain.Doctor;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowCallbackHandler;
import org.springframework.stereotype.Repository;

@Repository
public class DoctorDao {
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	public Doctor doctorById(final Long id){
		final Doctor result=new Doctor();
		String sqlStr="select * from doctor where id=?";
		jdbcTemplate.query(sqlStr,new Object[] {id},
				new RowCallbackHandler(){
					@Override
					public void processRow(ResultSet rs) throws SQLException {
						result.setId(id);
						result.setIntroduction(rs.getString("introduction"));
						result.setName(rs.getString("name"));
						result.setPicture(rs.getString("picture"));
					}
		});
		return result;
	}
}
