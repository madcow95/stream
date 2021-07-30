package com.moviestream.movie.member.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class BatchDTO {
	
	private String id;
	private String pw;
	private String name;
	private String nick;
	private String addr;
	private String email;
	private String birth;
	private String status;

}
