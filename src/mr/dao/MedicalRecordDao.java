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
	private CategoryDao cgDao;
	
	public MedicalRecord recordByIndex(final int index){
		final MedicalRecord medicalRecord=new MedicalRecord();
		
		String sqlStr="SELECT * FROM medicalrecord WHERE recordid=?";
		jdbcTemplate.query(sqlStr,new Object[] {index},
				new RowCallbackHandler(){
					public void processRow(ResultSet rs) throws SQLException{
						medicalRecord.setContent(rs.getString("content"));
						medicalRecord.setDoctorId(rs.getInt("doctorId"));
						medicalRecord.setDoctorName(rs.getString("doctorName"));
						medicalRecord.setRecordId(index);
						medicalRecord.setRecordTitle(rs.getString("recordTitle"));
						medicalRecord.setReference(rs.getString("reference"));
						medicalRecord.setCategory(rs.getString("category"));
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
							if(tfidfStr!=""){
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
	public List recordByCategory(String secCateName){
		Category cate = cgDao.getSecCategory(secCateName);
		int start = cate.getStartRecId();
		int end = start + cate.getRecNum()-1;
		String sql="select recordTitle,content from medicalrecord where recordId between "+ start+" and "+end;
		List RecordList = jdbcTemplate.queryForList(sql);
		return RecordList;
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
						record.setDoctorName(rs.getString("doctorName"));
						record.setRecordId(rs.getInt("recordId"));
						record.setRecordTitle(rs.getString("recordTitle"));
						record.setReference(rs.getString("reference"));
						result.add(record);
					}
			
		});
		return result;
	}
}
