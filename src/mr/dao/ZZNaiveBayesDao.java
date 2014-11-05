package mr.dao;

import java.sql.ResultSet;
import java.sql.SQLException;

import mr.domain.ZZNaiveBayes;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.IncorrectResultSizeDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowCallbackHandler;
import org.springframework.stereotype.Repository;

@Repository
public class ZZNaiveBayesDao {
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	public Long indexOf(String word){
		String sqlStr="select id from zz_naivebayes_model where word=?";
		try{
			return jdbcTemplate.queryForLong(sqlStr,new Object[] {word});
		}catch(IncorrectResultSizeDataAccessException e){
			return -1L;
		}
	}
	
	public ZZNaiveBayes getById(Long id){
		String sqlStr="select * from zz_naivebayes_model where id=?";
		final ZZNaiveBayes result=new ZZNaiveBayes();
		jdbcTemplate.query(sqlStr, new Object[] {id},
				new RowCallbackHandler(){
					public void processRow(ResultSet rs) throws SQLException{
						result.setId(rs.getLong("id"));
						result.setWord(rs.getString("word"));
						result.setPrior(rs.getFloat("prior"));
						result.setLikelihood(rs.getString("likelihood"));
						}
		});
		return result;
	}
	
}
