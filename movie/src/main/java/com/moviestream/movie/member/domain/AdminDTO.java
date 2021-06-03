package com.moviestream.movie.member.domain;

import java.io.Serializable;
import java.util.List;

import lombok.Data;

@Data
public class AdminDTO implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String id;
	private String pwd;
	private String name;
	private List<MemberAuth> adminAuthList;
}
