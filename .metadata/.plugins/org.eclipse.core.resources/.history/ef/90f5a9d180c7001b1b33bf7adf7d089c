package com.moviestream.movie.board.domain;

import lombok.Data;

@Data
public class FreeCriteria {

	private int pageNum;
	private int amount;
	
	private String type;
	private String keyword;
	
	public FreeCriteria() {
		this(1,10);
	}
	
	public FreeCriteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
	
	public String[] getTypeArr() {
		return type == null ? new String[]{} : type.split("");
	}
}
