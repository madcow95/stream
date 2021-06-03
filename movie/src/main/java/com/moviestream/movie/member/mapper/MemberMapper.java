package com.moviestream.movie.member.mapper;

import java.util.List;
import java.util.Map;

import com.moviestream.movie.member.domain.AdminDTO;
import com.moviestream.movie.member.domain.MemberDTO;

public interface MemberMapper {
	public List<MemberDTO> getMember();
	public MemberDTO read(String id);
	public AdminDTO adminread(String id);
	
	public MemberDTO login(Map<String, String> loginMap) throws Exception;
	
	public int authJoin(MemberDTO mDto) throws Exception;
	public int join(MemberDTO mDto) throws Exception;

}