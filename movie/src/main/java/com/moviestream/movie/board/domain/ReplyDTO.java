package com.moviestream.movie.board.domain;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class ReplyDTO {
	
	private int rno;
	private int articleno;
	
	private String replytext;
	private String id;
	
	private Timestamp regdate;
	private Timestamp updatedate;

}
