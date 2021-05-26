package com.moviestream.movie.member.service;

import java.util.List;
import java.util.Map;

import com.moviestream.movie.member.domain.MemberDTO;

public interface IMemberService {
	
	public List<MemberDTO> getMember() throws Exception;
	public MemberDTO login(Map<String, String> loginMap) throws Exception;
	public int id_check(String id) throws Exception;
}