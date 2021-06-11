package com.moviestream.movie.board.domain;

import java.sql.Timestamp;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class BoardDTO {

	private int articleno;
	private String title;
	private String content;
	private int readcount;
	private Timestamp regdate;
	private Timestamp updatedate;
	private String id;
	
	private List<BoardAttachDTO> attachList;
}
