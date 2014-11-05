package mr.dao;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.IncorrectResultSizeDataAccessException;
import org.springframework.stereotype.Repository;

import mr.domain.Word;
@Repository
public class WordDao {
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	public int indexOfWord(String word){
		String sqlStr="SELECT wordId FROM dictionary WHERE word=?";
		try{
			return jdbcTemplate.queryForInt(sqlStr,new Object[] {word});
		}catch(IncorrectResultSizeDataAccessException e){
			return -1;
		}
		
		//可能字典中没有这个词，待处理
	}
}
