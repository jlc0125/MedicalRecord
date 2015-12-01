package mr.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import mr.domain.BookComment;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowCallbackHandler;
import org.springframework.stereotype.Repository;


@Repository
public class BookCommentDao {
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	public BookComment commentById(final Long id){
		final BookComment result=new BookComment();
		String sqlStr="select * from book_comment where id=?";
		jdbcTemplate.query(sqlStr,new Object[] {id},
				new RowCallbackHandler(){
					@Override
					public void processRow(ResultSet rs) throws SQLException {
						result.setId(id);
						result.setBookId(rs.getLong("book_id"));
						result.setContent(rs.getString("content"));
						result.setCreateTime(rs.getDate("create_time"));
						result.setPage(rs.getInt("page"));
						result.setUserId(rs.getLong("user_id"));						
					}
		});
		return result;
	}
	
	public void addComment(long bid, long uid, int page, String content){
		String sqlStr=String.format("insert into book_comment (book_id,user_id,page,content) values(%d,%d,%d,'%s')",new Object[]{bid,uid,page,content});
		
		jdbcTemplate.execute(sqlStr);
		
	}
	
	public List<BookComment> commnetByPage(long bid, int page){
		final List<BookComment> retval= new ArrayList<BookComment>();
		String sqlStr = "select * from book_comment where book_id = ? and page= ?";
		jdbcTemplate.query(sqlStr, new Object[]{bid, page},new RowCallbackHandler(){
			@Override
			public void processRow(ResultSet rs) throws SQLException {
				BookComment bc = new BookComment(); 
				bc.setId(rs.getLong("id"));
				bc.setBookId(rs.getLong("book_id"));
				bc.setContent(rs.getString("content"));
				bc.setCreateTime(rs.getDate("create_time"));
				bc.setPage(rs.getInt("page"));
				bc.setUserId(rs.getLong("user_id"));
				retval.add(bc);
			}
		});
		return retval;
	}
}