package mr.domain;

import java.util.Date;

public class Revision {
	private int revisionId;
	private int revisionType;
	private String advise;
	private String comment;
	private int agree;
	private int disagree;
	private int state;
	private Date createDate;

	public int getRevisionId() {
		return revisionId;
	}
	public void setRevisionId(int revisionId) {
		this.revisionId = revisionId;
	}
	public int getRevisionType() {
		return revisionType;
	}
	public void setRevisionType(int revisionType) {
		this.revisionType = revisionType;
	}
	public String getAdvise() {
		return advise;
	}
	public void setAdvise(String advise) {
		this.advise = advise;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}

	public int getAgree() {
		return agree;
	}
	public void setAgree(int agree) {
		this.agree = agree;
	}
	public int getDisagree() {
		return disagree;
	}
	public void setDisagree(int disagree) {
		this.disagree = disagree;
	}

	public int getState() {
		return state;
	}
	public void setState(int state) {
		this.state = state;
	}
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
}
