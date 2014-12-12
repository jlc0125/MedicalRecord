package mr.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import mr.domain.Med;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowCallbackHandler;
import org.springframework.stereotype.Repository;

@Repository
public class MedDao {
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	public List<Med> allMeds(){
		final List<Med> medVocab=new ArrayList<Med>();
		String sqlStr="select * from med_vocab order by id desc";
		
		jdbcTemplate.query(sqlStr,
				new RowCallbackHandler(){
					public void processRow(ResultSet rs) throws SQLException{
						Med tmpMed=new Med();
						tmpMed.setId(rs.getLong("id"));
						tmpMed.setName(rs.getString("word"));
						medVocab.add(tmpMed);
					}
		});
		return medVocab;
	}
	
	public Med getMedById(Long id){
		final Med result=new Med();
		String sqlStr="select * from med_vocab where id=?";
		jdbcTemplate.query(sqlStr,new Object[]{id},
				new RowCallbackHandler(){
					public void processRow(ResultSet rs) throws SQLException{
						result.setId(rs.getLong("id"));
						result.setName(rs.getString("word"));
					}
		});
		return result;
	}
	
	public boolean isMed(String word){
		String sqlStr="select count(*) from med_vocab where word=?";
		int count=jdbcTemplate.queryForInt(sqlStr, new Object[]{word});
		if(count>0) return true;
		else return false;
	}
}
