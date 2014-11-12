package mr.domain;

public class ZZNaiveBayes {
	private Long id;
	private String word;
	private Float prior;
	private String likelihood;
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getWord() {
		return word;
	}
	public void setWord(String word) {
		this.word = word;
	}
	public Float getPrior() {
		return prior;
	}
	public void setPrior(Float prior) {
		this.prior = prior;
	}
	public String getLikelihood() {
		return likelihood;
	}
	public void setLikelihood(String likelihood) {
		this.likelihood = likelihood;
	}
}
