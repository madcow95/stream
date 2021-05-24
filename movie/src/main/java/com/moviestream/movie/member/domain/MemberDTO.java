package com.moviestream.movie.member.domain;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class MemberDTO {

	private String id;
	private String pwd;
	private String name;
	private String email;
	private String address;
	private String phone;
	private Timestamp regdate;
	private String zip_num;
}