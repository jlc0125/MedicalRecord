package mr.domain;

import java.util.HashMap;

public class MedicalRecord {
	private int recordId;
	private String recordTitle;
	private String content;
	private Long doctorId;
	private String doctorName;
	private HashMap<Integer,Double> tfidf;
	private String category;
	private String reference;
	private String cfIndex;
	public String getCfIndex() {
		return cfIndex;
	}
	public void setCfIndex(String cfIndex) {
		this.cfIndex = cfIndex;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getReference() {
		return reference;
	}
	public void setReference(String reference) {
		this.reference = reference;
	}
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
	public Long getDoctorId() {
		return doctorId;
	}
	public void setDoctorId(Long doctorId) {
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
