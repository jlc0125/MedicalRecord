package mr.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

import mr.domain.MedicalRecord;
import mr.domain.MedicalRecordSimilarity;
import mr.web.IKAnalizer;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowCallbackHandler;
import org.springframework.stereotype.Repository;

@Repository
public class MedicalRecordSimilarityDao {
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	
	public List<Integer> getSimRecord(int recordId,final int size){
		String sqlStr="SELECT * FROM medical_record_similarity WHERE record_id="+recordId;
		final List<Integer> retval=new ArrayList<Integer>();
		jdbcTemplate.query(sqlStr, new RowCallbackHandler() {
			@Override
			public void processRow(ResultSet rs) throws SQLException {
				// TODO Auto-generated method stub
				String simString=rs.getString("similarity");
				String[] part=simString.split(" ");
				for(int i=1;i<size+1;i++){
					retval.add(Integer.valueOf(part[i].split(":")[0]));
				}
			}
		});
		return retval;
	}
	
	public void createTable(){
		String sqlStr="CREATE TABLE IF NOT EXISTS medical_record_similarity (record_id int PRIMARY KEY,similarity text)";
		jdbcTemplate.execute(sqlStr);
		
		final List<MedicalRecord> records=new ArrayList<MedicalRecord>(); 
		sqlStr="SELECT recordid,content FROM medicalrecord";
		jdbcTemplate.query(sqlStr, new RowCallbackHandler() {
			@Override
			public void processRow(ResultSet rs) throws SQLException {
				// TODO Auto-generated method stub
				MedicalRecord record=new MedicalRecord();
				record.setRecordId(rs.getInt("recordid"));
				record.setContent(rs.getString("content"));
				records.add(record);
			}
		});
		List<RecordWord> recordWords=new ArrayList<RecordWord>();
		for(MedicalRecord record:records){
			RecordWord rw=new RecordWord(record.getRecordId(),IKAnalizer.IKAnalysis(record.getContent()).split(" "));
			recordWords.add(rw);
			//System.out.println(rw.norm2);
		}
		
		
		for(int i=0;i<recordWords.size();i++){
			System.out.println(i);
			MedicalRecordSimilarity mrsRecord=new MedicalRecordSimilarity();
			mrsRecord.setRecordId(recordWords.get(i).id);
			String similarity="";
			List<SimUnit> sims=new ArrayList<SimUnit>();
			for(int j=0;j<recordWords.size();j++){
				int fenzi=0;
				int pi=0,pj=0;
				RecordWord rwi=recordWords.get(i);
				RecordWord rwj=recordWords.get(j);
				while(pi<rwi.wordSet.size() && pj<rwj.wordSet.size()){
					if(rwi.wordSet.get(pi).compareTo(rwj.wordSet.get(pj))>0) pj++;
					else if(rwi.wordSet.get(pi).compareTo(rwj.wordSet.get(pj))<0) pi++;
					else {
						fenzi+=rwi.counts.get(pi)*rwj.counts.get(pj);
						pi++;pj++;
					}
				}
				double sim=0.0;
				if(rwi.norm2*rwj.norm2>0){
					sim=fenzi/(rwi.norm2*rwj.norm2);
				}
				sims.add(new SimUnit(j,sim));
			}
			Collections.sort(sims);//逆序，从大到小
			int knearest=100;
			for(int k=0;k<knearest;k++){
				similarity+=String.format("%d:%.3f ",new Object[]{sims.get(k).id+1,sims.get(k).sim});
			}
			//System.out.println(similarity);
			mrsRecord.setSimilarity(similarity.trim());
			sqlStr=String.format("INSERT INTO medical_record_similarity VALUES(%d,'%s')",new Object[]{
					mrsRecord.getRecordId(),
					mrsRecord.getSimilarity()
			});
			jdbcTemplate.execute(sqlStr);
		}
		
		
	}
	
	public void dropTable(){
		String sqlStr="DROP TABLE IF EXISTS medical_record_similarity";
		jdbcTemplate.execute(sqlStr);
	}	
	
	private class SimUnit implements Comparable<SimUnit>{
		int id;
		double sim;
		
		SimUnit(int id,double sim){
			this.id=id;
			this.sim=sim;
		}
		
		@Override
		public int compareTo(SimUnit that) {
			if(this.sim>that.sim) return -1;
			else if (this.sim<that.sim) return 1;
			else return 0;
		}
	}
	
	private class RecordWord{
		int id;
		List<String> wordSet;
		List<Integer> counts;
		double norm2;
		RecordWord(int id,String[] words){
			this.id=id;
			Arrays.sort(words);
			wordSet=new ArrayList<String>();
			counts=new ArrayList<Integer>();
			int i=0;
			int count=1;
			while(i<words.length){
				while(i+1<words.length && words[i].equals(words[i+1])) {
					i++;
					count++;
				}
				wordSet.add(words[i]);
				counts.add(count);
				count=1;
				i++;
			}
			norm2=0.0;
			for(int c:counts){
				norm2+=c*c;
			}
			norm2=Math.sqrt(norm2);
		}
	}
}
