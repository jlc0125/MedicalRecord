package mr.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import mr.domain.Book;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowCallbackHandler;
import org.springframework.stereotype.Repository;

@Repository
public class BookDao {
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	public Book getById(final Long id){
		final Book result=new Book();
		String sqlStr="select * from book where id=?";
		jdbcTemplate.query(sqlStr,new Object[] {id},
				new RowCallbackHandler(){
					@Override
					public void processRow(ResultSet rs) throws SQLException {
						result.setId(id);
						result.setAuthor(rs.getString("author"));
						result.setImgLoc(rs.getString("img_loc"));
						result.setPageNum(rs.getInt("page_num"));
						result.setPublisher(rs.getString("publisher"));
						result.setTitle(rs.getString("title"));
						result.setCatalog(rs.getString("catalog"));
						result.setDa_id(rs.getInt("da_id"));
						result.setType(rs.getInt("type"));
					}
		});
		return result;
	}
	
	public List<Book> getAll(){
		final List<Book> result = new ArrayList<Book>(); 
		String sqlStr="select * from book";
		jdbcTemplate.query(sqlStr,
				new RowCallbackHandler(){
					@Override
					public void processRow(ResultSet rs) throws SQLException {
						Book book = new Book();
						book.setId(rs.getLong("id"));
						book.setAuthor(rs.getString("author"));
						book.setImgLoc(rs.getString("img_loc"));
						book.setPageNum(rs.getInt("page_num"));
						book.setPublisher(rs.getString("publisher"));
						book.setTitle(rs.getString("title"));
						book.setCatalog(rs.getString("catalog"));
						book.setDa_id(rs.getInt("da_id"));
						book.setType(rs.getInt("type"));
						result.add(book);
					}
		});
		return result;
	}
	
	public List<Book> search(String keyword){
		final List<Book> result = new ArrayList<Book>();
		String sqlStr="select * from book where title like ?";
		jdbcTemplate.query(sqlStr,
				new Object[] {"%"+keyword+"%"},
				new RowCallbackHandler(){
					@Override
					public void processRow(ResultSet rs) throws SQLException {
						Book book = new Book();
						book.setId(rs.getLong("id"));
						book.setAuthor(rs.getString("author"));
						book.setImgLoc(rs.getString("img_loc"));
						book.setPageNum(rs.getInt("page_num"));
						book.setPublisher(rs.getString("publisher"));
						book.setTitle(rs.getString("title"));
						book.setCatalog(rs.getString("catalog"));
						book.setDa_id(rs.getInt("da_id"));
						book.setType(rs.getInt("type"));
						result.add(book);
					}
		});
		return result;
	}
}
