package com.moviestream.movie.board.domain;

import java.sql.Date;
import java.sql.Timestamp;

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
	private int readcount;
	private Timestamp regdate;
	private int updatedate;
	private String filename;
	private String id;
}
