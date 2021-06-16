package com.moviestream.movie.member.domain;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.List;

import lombok.Data;

@Data
public class MemberDTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String id;
	private String pwd;
	private String name;
	private String email;
	private String zip_num;
	private String address;
	private String phone;
	private boolean enabled;
	private Timestamp regdate;
	private Timestamp lastlogin;
	private List<MemberAuth> authList;
}