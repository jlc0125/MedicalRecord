package mr.domain;

public class Prescription {
	private Long id;
	private String name;
	private String dosage;
	private Integer medNum;
	public Integer getMedNum() {
		return medNum;
	}
	public void setMedNum(Integer medNum) {
		this.medNum = medNum;
	}
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDosage() {
		return dosage;
	}
	public void setDosage(String dosage) {
		this.dosage = dosage;
	}
	
}
