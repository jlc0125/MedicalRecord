package mr.domain;

import java.util.HashMap;

public class MedicalRecord {
	private int recordId;
	private String recordTitle;
	private String content;
	private int doctorId;
	private String doctorName;
	private HashMap<Integer,Double> tfidf;
	public int getRecordId() {
		return recordId;
	}
	public void setRecordId(int recordId) {
		this.recordId = recordId;
	}
	public String getRecordTitle() {
		return recordTitle;
	}
	public void setRecordTitle(String recordTitle) {
		this.recordTitle = recordTitle;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getDoctorId() {
		return doctorId;
	}
	public void setDoctorId(int doctorId) {
		this.doctorId = doctorId;
	}
	public String getDoctorName() {
		return doctorName;
	}
	public void setDoctorName(String doctorName) {
		this.doctorName = doctorName;
	}
	public HashMap<Integer, Double> getTfidf() {
		return tfidf;
	}
	public void setTfidf(HashMap<Integer, Double> tfidf) {
		this.tfidf = tfidf;
	}
	
}
