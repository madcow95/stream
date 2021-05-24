package com.moviestream.movie.movie.domain;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class MovieDTO {

	private int m_code;
	private String m_name;
	private String m_content;
	private String m_img;
	private String m_video;
	private char m_bestyn;
	private Date m_indate;
}
