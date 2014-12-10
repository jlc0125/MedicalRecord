package mr.domain;

public class Drug {
	private int id;
	private String name;
	private String pinyin;
	private String abbr;
	private String pinci;
	private String[] drug;
	private String[] symptom;
	private String[] recipe;
	
	public Drug() {
	}
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPinyin() {
		return pinyin;
	}
	public void setPinyin(String pinyin) {
		this.pinyin = pinyin;
	}
	public String getAbbr() {
		return abbr;
	}
	public void setAbbr(String abbr) {
		this.abbr = abbr;
	}
	public String getPinci() {
		return pinci;
	}
	public void setPinci(String pinci) {
		this.pinci = pinci;
	}
	public String[] getDrug() {
		return drug;
	}
	public void setDrug(String[] drug) {
		this.drug = drug;
	}
	public String[] getSymptom() {
		return symptom;
	}
	public void setSymptom(String[] symptom) {
		this.symptom = symptom;
	}
	public String[] getRecipe() {
		return recipe;
	}
	public void setRecipe(String[] recipe) {
		this.recipe = recipe;
	}

}
