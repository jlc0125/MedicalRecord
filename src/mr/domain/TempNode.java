package mr.domain;

public class TempNode {
	private int index;
	private String name;
	private String pinci;
	
	public TempNode() {
	}
	
	public TempNode(int index, String name, String pinci) {
		this.index = index;
		this.name = name;
		this.pinci = pinci;
	}

	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPinci() {
		return pinci;
	}
	public void setPinci(String pinci) {
		this.pinci = pinci;
	}

	public int getIndex() {
		return index;
	}

	public void setIndex(int index) {
		this.index = index;
	}
	
}
