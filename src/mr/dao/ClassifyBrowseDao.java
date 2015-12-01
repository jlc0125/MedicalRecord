package mr.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import mr.domain.Category;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowCallbackHandler;
import org.springframework.stereotype.Repository;

@Repository
public class ClassifyBrowseDao {
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	//获取第一分类
	public List getFirCategoryList(){
		String sql = "select * from first_category";
	/*	List cateList = new ArrayList();
		final Category category = new Category();
		jdbcTemplate.queryForList(sql, new RowCallbackHandler() {
			public void processRow(ResultSet rs) throws SQLException {
				category.setCateId(rs.getString("cate_id"));
				category.setCateName(rs.getString("cate_name"));
			}
		});
		return category;*/
		List cateList = jdbcTemplate.queryForList(sql);
		return cateList;
	}
	//根据分类名获取第一分类信息
	public Category getFirCategory(final String firCateName){		
		String sql="select cate_id,startRecId,recNum from first_category where cate_name=?";
		final Category cate = new Category();
		jdbcTemplate.query(sql, new Object[] {firCateName},
				new RowCallbackHandler() {
					public void processRow(ResultSet rs) throws SQLException {
						cate.setCateId(rs.getString("cate_id"));
						cate.setCateName(firCateName);
						cate.setStartRecId(rs.getInt("startRecId"));
						cate.setRecNum(rs.getInt("recNum"));
					}
				});
		return cate;
	}
	//根据第一分类获得第二分类
	public List getSecCategoryList(String FirCateId){
		String sql = "select * from second_category "
				+ " where cate_id like ?";
		List cateList = jdbcTemplate.queryForList(sql, new Object[] {FirCateId + "%"});
		return cateList;
	}
	//根据分类名获得第二分类信息
	public Category getSecCategory(final String secCateName){		
		String sql="select cate_id,startRecId,recNum from second_category where cate_name=?";
		final Category cate = new Category();
		jdbcTemplate.query(sql, new Object[] {secCateName},
				new RowCallbackHandler() {
					public void processRow(ResultSet rs) throws SQLException {
						cate.setCateId(rs.getString("cate_id"));
						cate.setCateName(secCateName);
						cate.setStartRecId(rs.getInt("startRecId"));
						cate.setRecNum(rs.getInt("recNum"));
					}
				});
		return cate;
	}
	
	public int getMatchCount(String num) {
		String sqlStr = " SELECT count(*) FROM result2 "
				+ " WHERE one<? or two<? or three<? or four<? or five<? or six<? or seven<? or eight<?";
		return jdbcTemplate.queryForInt(sqlStr, new Object[] { num,num,num,num,num,num,num,num });
	}
}
