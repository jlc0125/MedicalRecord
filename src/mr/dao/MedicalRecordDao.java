package mr.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import mr.domain.Category;
import mr.domain.MedicalRecord;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowCallbackHandler;
import org.springframework.stereotype.Repository;
@Repository
public class MedicalRecordDao {
	@Autowired
	private JdbcTemplate jdbcTemplate;
	@Autowired
	private ClassifyBrowseDao cgDao;
	
	public MedicalRecord recordByIndex(final int index){
		final MedicalRecord medicalRecord=new MedicalRecord();
		
		String sqlStr="SELECT * FROM medicalrecord WHERE recordid=?";
		jdbcTemplate.query(sqlStr,new Object[] {index},
				new RowCallbackHandler(){
					public void processRow(ResultSet rs) throws SQLException{
						medicalRecord.setContent(rs.getString("content"));
						medicalRecord.setDoctorId(rs.getLong("doctorId"));
						medicalRecord.setDoctorName(rs.getString("doctorName"));
						medicalRecord.setRecordId(index);
						medicalRecord.setRecordTitle(rs.getString("recordTitle"));
						medicalRecord.setReference(rs.getString("reference"));
						medicalRecord.setCategory(rs.getString("category"));
						medicalRecord.setCfIndex(rs.getString("cfIndex"));
						String tfidfStr=rs.getString("tfidf");
						HashMap<Integer,Double> tfidfMap=new HashMap<Integer,Double>();
						//String转map，待处理
						medicalRecord.setTfidf(tfidfMap);
					}
		});
		
		return medicalRecord;
		
	}
	
	public List<HashMap<Integer,Double>> allTfidf(){
		final List<HashMap<Integer,Double>> result=new ArrayList<HashMap<Integer,Double>>();
		String sqlStr="SELECT recordId,tfidf FROM medicalrecord ORDER BY recordId";
		jdbcTemplate.query(sqlStr, 
				new RowCallbackHandler(){
					public void processRow(ResultSet rs) throws SQLException{
						String tfidfStr=rs.getString("tfidf");
						HashMap<Integer,Double> tfidfMap=new HashMap<Integer,Double>();
						//String转map，待处理
						try{
							if(!tfidfStr.equals("")){
								String[] pares=tfidfStr.trim().split(" ");
								for(String pare:pares){
									tfidfMap.put(Integer.parseInt(pare.split(":")[0]),Double.parseDouble(pare.split(":")[1]));
								}
							}
						}catch(Exception e){
							e.printStackTrace();
							System.out.println(rs.getInt("recordid"));
						}
						result.add(tfidfMap);
					}
		});
		
		return result;
	}
	
	//根据第二分类名称获得医案集
	public List<MedicalRecord> recordByCategory(String secCateName){
		Category cate = cgDao.getSecCategory(secCateName);
		String cateId = cate.getCateId();
		final List<MedicalRecord> result=new ArrayList<MedicalRecord>();
		String sql="select * from medicalrecord where category=?";
		jdbcTemplate.query(sql,new Object[] {cateId},
				new RowCallbackHandler(){
					@Override
					public void processRow(ResultSet rs) throws SQLException {
						MedicalRecord record=new MedicalRecord();
						record.setContent(rs.getString("content"));
						record.setDoctorName(rs.getString("doctorName"));
						record.setRecordId(rs.getInt("recordId"));
						record.setRecordTitle(rs.getString("recordTitle"));
						record.setReference(rs.getString("reference"));
						record.setCfIndex(rs.getString("cfIndex"));
						result.add(record);
					}
			
		});
		return result;
		//	jdbcTemplate.queryForList(sql);
	//	return RecordList;
	}
	
	public List<MedicalRecord> recordByDoctor(String doctorName){
		final List<MedicalRecord> result=new ArrayList<MedicalRecord>();
		String sqlStr="select * from medicalrecord where doctorName like ?";
		jdbcTemplate.query(sqlStr,new Object[] {"%"+doctorName+"%"},
				new RowCallbackHandler(){
					@Override
					public void processRow(ResultSet rs) throws SQLException {
						MedicalRecord record=new MedicalRecord();
						record.setContent(rs.getString("content"));
						record.setDoctorId(rs.getLong("doctorId"));
						record.setDoctorName(rs.getString("doctorName"));
						record.setRecordId(rs.getInt("recordId"));
						record.setRecordTitle(rs.getString("recordTitle"));
						record.setReference(rs.getString("reference"));
						result.add(record);
					}
			
		});
		return result;
	}
	
	public List<MedicalRecord> recordByReference(String reference){
		final List<MedicalRecord> result=new ArrayList<MedicalRecord>();
		String sqlStr="select * from medicalrecord where reference like ?";
		jdbcTemplate.query(sqlStr,new Object[] {"%"+reference+"%"},
				new RowCallbackHandler(){
					@Override
					public void processRow(ResultSet rs) throws SQLException {
						MedicalRecord record=new MedicalRecord();
						record.setContent(rs.getString("content"));
						record.setDoctorId(rs.getLong("doctorId"));
						record.setDoctorName(rs.getString("doctorName"));
						record.setRecordId(rs.getInt("recordId"));
						record.setRecordTitle(rs.getString("recordTitle"));
						record.setReference(rs.getString("reference"));
						result.add(record);
					}
			
		});
		return result;
	}
	
	public List<MedicalRecord> recordByDoctorId(Long doctorId){
		final List<MedicalRecord> result=new ArrayList<MedicalRecord>();
		String sqlStr="select * from medicalrecord where doctorId=?";
		jdbcTemplate.query(sqlStr,new Object[] {doctorId},
				new RowCallbackHandler(){
					@Override
					public void processRow(ResultSet rs) throws SQLException {
						MedicalRecord record=new MedicalRecord();
						record.setContent(rs.getString("content"));
						record.setDoctorId(rs.getLong("doctorId"));
						record.setDoctorName(rs.getString("doctorName"));
						record.setRecordId(rs.getInt("recordId"));
						record.setRecordTitle(rs.getString("recordTitle"));
						record.setReference(rs.getString("reference"));
						result.add(record);
					}
			
		});
		return result;
	}
	
	public List<MedicalRecord> recordyDisc(String discriminate){
		final List<MedicalRecord> result=new ArrayList<MedicalRecord>();
		String sqlStr="select * from medicalrecord where content like ?";
		jdbcTemplate.query(sqlStr,new Object[] {"%"+discriminate+"%"},
				new RowCallbackHandler(){
					@Override
					public void processRow(ResultSet rs) throws SQLException {
						MedicalRecord record=new MedicalRecord();
						record.setContent(rs.getString("content"));
						record.setDoctorName(rs.getString("doctorName"));
						record.setRecordId(rs.getInt("recordId"));
						record.setRecordTitle(rs.getString("recordTitle"));
						record.setReference(rs.getString("reference"));
						result.add(record);
					}
			
		});
		return result;
	}
	

	public List<MedicalRecord> recordyTher(String therapy){
		final List<MedicalRecord> result=new ArrayList<MedicalRecord>();
		String sqlStr="select * from medicalrecord where content like ?";
		jdbcTemplate.query(sqlStr,new Object[] {"%"+therapy+"%"},
				new RowCallbackHandler(){
					@Override
					public void processRow(ResultSet rs) throws SQLException {
						MedicalRecord record=new MedicalRecord();
						record.setContent(rs.getString("content"));
						record.setDoctorName(rs.getString("doctorName"));
						record.setRecordId(rs.getInt("recordId"));
						record.setRecordTitle(rs.getString("recordTitle"));
						record.setReference(rs.getString("reference"));
						result.add(record);
					}
			
		});
		return result;
	}
	
	public List<MedicalRecord> recordyWF(String word){
		final List<MedicalRecord> result=new ArrayList<MedicalRecord>();
		String sqlStr="select * from medicalrecord where content like ?";
		jdbcTemplate.query(sqlStr,new Object[] {"%"+word+"%"},
				new RowCallbackHandler(){
					@Override
					public void processRow(ResultSet rs) throws SQLException {
						MedicalRecord record=new MedicalRecord();
						record.setContent(rs.getString("content"));
						record.setDoctorName(rs.getString("doctorName"));
						record.setRecordId(rs.getInt("recordId"));
						record.setRecordTitle(rs.getString("recordTitle"));
						record.setReference(rs.getString("reference"));
						result.add(record);
					}
			
		});
		return result;
	}
		

	public List<MedicalRecord> reocrdByContentContain(String[] words){
		final List<MedicalRecord> result=new ArrayList<MedicalRecord>();
		String sqlStr="select * from medicalrecord where (content like ?";
		for(int i=1;i<words.length;i++){
			sqlStr+=" and content like ?";
		}
		sqlStr+=")";
		Object[] condition=new Object[words.length];
		for(int i=0;i<words.length;i++){
			condition[i]="%"+words[i]+"%";
		}
		
		jdbcTemplate.query(sqlStr,condition,
						new RowCallbackHandler(){
					@Override
					public void processRow(ResultSet rs) throws SQLException {
						MedicalRecord record=new MedicalRecord();
						record.setContent(rs.getString("content"));
						record.setDoctorName(rs.getString("doctorName"));
						record.setRecordId(rs.getInt("recordId"));
						record.setRecordTitle(rs.getString("recordTitle"));
						record.setReference(rs.getString("reference"));
						result.add(record);
					}
			
			});
		
		return result;
	}

	//根据治法标签获得医案集
	public List<MedicalRecord> recordByZhifa(String zhifa){
		final List<MedicalRecord> result=new ArrayList<MedicalRecord>();
		String sql="select * from medicalrecord where zhifa like ?";
		jdbcTemplate.query(sql,new Object[] {"%"+zhifa+"%"},
				new RowCallbackHandler(){
					@Override
					public void processRow(ResultSet rs) throws SQLException {
						MedicalRecord record=new MedicalRecord();
						record.setContent(rs.getString("content"));
						record.setDoctorName(rs.getString("doctorName"));
						record.setRecordId(rs.getInt("recordId"));
						record.setRecordTitle(rs.getString("recordTitle"));
						record.setReference(rs.getString("reference"));
						record.setCfIndex(rs.getString("cfIndex"));
						result.add(record);
					}
			
		});
		return result;
	}
	
	//根据第一分类名称获得医案集
		public List<MedicalRecord> recordByFirstCategory(String firstCateName){
			Category cate = cgDao.getFirCategory(firstCateName);
			String cateId = cate.getCateId();
			final List<MedicalRecord> result=new ArrayList<MedicalRecord>();
			String sql="select * from medicalrecord where category like ? order by recordId asc LIMIT 100";
			jdbcTemplate.query(sql,new Object[] {cateId+"%"},
					new RowCallbackHandler(){
						@Override
						public void processRow(ResultSet rs) throws SQLException {
							MedicalRecord record=new MedicalRecord();
							record.setContent(rs.getString("content"));
							record.setDoctorName(rs.getString("doctorName"));
							record.setRecordId(rs.getInt("recordId"));
							record.setRecordTitle(rs.getString("recordTitle"));
							record.setReference(rs.getString("reference"));
							record.setCfIndex(rs.getString("cfIndex"));
							result.add(record);
						}
				
			});
			return result;
		}
}
