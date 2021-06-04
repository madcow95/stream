package com.moviestream.movie.member.service;

import java.util.List;
import java.util.Map;

import com.moviestream.movie.member.domain.MemberDTO;

public interface IMemberService {
	
	public List<MemberDTO> getMember() throws Exception;
	public MemberDTO login(Map<String, String> loginMap) throws Exception;
	public int id_check(String id) throws Exception;
	public MemberDTO read(String id) throws Exception;
	public int join(MemberDTO mDto) throws Exception;
	public void authJoin(MemberDTO mDto) throws Exception;
	public int findAndUpdate(Map<String, String> updateMap) throws Exception;
}
