package com.moviestream.movie.member.domain;

import java.io.Serializable;

import lombok.Data;

@Data
public class MemberAuth implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String id;
	private String auth;
}
