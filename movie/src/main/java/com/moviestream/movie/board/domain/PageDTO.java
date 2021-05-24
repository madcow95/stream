package com.moviestream.movie.board.domain;

import lombok.Data;

@Data
public class PageDTO {

	private int startPage;
	private int endPage;
	private boolean prev, next;
	
	private int total;
	private Criteria cri;
	private FreeCriteria cri2;
	
	public PageDTO(Criteria cri, int total) {
		this.cri = cri;
		this.total = total;
		
		this.endPage = (int) (Math.ceil(cri.getPageNum() / 10.0)) * 10;
		this.startPage = this.endPage - 9;
		
		int realEnd = (int) ((Math.ceil(total * 1.0) / cri.getAmount()));
		if(realEnd <= this.endPage) {
			this.endPage = realEnd;
		}
		
		this.prev = this.startPage > 1;
		this.next = this.endPage < realEnd;
	}

	public PageDTO(FreeCriteria cri2, int freeTotalCnt) {
		this.cri2 = cri2;
		this.total = freeTotalCnt;
		
		this.endPage = (int) (Math.ceil(cri2.getPageNum() / 10.0)) * 10;
		this.startPage = this.endPage - 9;
		
		int realEnd = (int) ((Math.ceil(total * 1.0) / cri2.getAmount()));
		if(realEnd <= this.endPage) {
			this.endPage = realEnd;
		}
		
		this.prev = this.startPage > 1;
		this.next = this.endPage < realEnd;
	}
}
