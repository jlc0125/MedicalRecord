package mr.domain;

import org.codehaus.jackson.map.annotate.JsonSerialize;

@JsonSerialize(include=JsonSerialize.Inclusion.NON_NULL)
public class Drug {
	private String name;
	private Leaf[] children;
	
	public Drug() {
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Leaf[] getChildren() {
		return children;
	}

	public void setChildren(Leaf[] children) {
		this.children = children;
	}
	
}
