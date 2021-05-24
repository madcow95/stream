package com.moviestream.movie.board.domain;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class BoardDTO {

	private int articleno;
	private String subject;
	private String content;
	private Date reg_date;
	private int readcount;
	private int ref;
	private int re_step;
	private int re_level;
	private String filename;
	private String id;
}
