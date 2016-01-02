package mr.domain;

public class Book {
	private long id;
	private String title;
	private String author;
	private String publisher;
	private int pageNum;
	private String imgLoc;
	private String catalog;

	private int type;
	private int da_id;
	
	
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	public int getDa_id() {
		return da_id;
	}
	public void setDa_id(int da_id) {
		this.da_id = da_id;
	}
	public String getCatalog() {
		return catalog;
	}
	public void setCatalog(String catelog) {
		this.catalog = catelog;
	}
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	public String getPublisher() {
		return publisher;
	}
	public void setPublisher(String publisher) {
		this.publisher = publisher;
	}
	public int getPageNum() {
		return pageNum;
	}
	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
	}
	public String getImgLoc() {
		return imgLoc;
	}
	public void setImgLoc(String imgLoc) {
		this.imgLoc = imgLoc;
	}
	
	
	
}
