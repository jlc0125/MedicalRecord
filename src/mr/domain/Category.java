package mr.domain;

public class Category {
	private String CateId;
	private String CateName;
	private int startRecId;
	private int RecNum;
	
	public int getStartRecId() {
		return startRecId;
	}
	public void setStartRecId(int startRecId) {
		this.startRecId = startRecId;
	}
	public int getRecNum() {
		return RecNum;
	}
	public void setRecNum(int recNum) {
		RecNum = recNum;
	}
	
	public String getCateId() {
		return CateId;
	}
	public void setCateId(String cateId) {
		CateId = cateId;
	}
	public String getCateName() {
		return CateName;
	}
	public void setCateName(String cateName) {
		CateName = cateName;
	}
}
