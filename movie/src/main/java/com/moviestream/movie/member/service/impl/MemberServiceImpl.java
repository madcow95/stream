package com.moviestream.movie.member.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.moviestream.movie.member.domain.MemberDTO;
import com.moviestream.movie.member.mapper.MemberMapper;
import com.moviestream.movie.member.persistence.IMemberDAO;
import com.moviestream.movie.member.service.IMemberService;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class MemberServiceImpl implements IMemberService{
	
	@Autowired
	private IMemberDAO mDao;
	
	@Autowired
	private MemberMapper mapper;
	
	@Override
	public List<MemberDTO> getMember() throws Exception {
		
		return mapper.getMember();
	}

	@Override
	public MemberDTO login(Map<String, String> loginMap) throws Exception {
		mapper.lastLogin(loginMap.get("id"));
		return mapper.login(loginMap);
	}
	@Override
	public int id_check(String id) throws Exception {
		return mapper.id_check(id);
	}
	
	@Override
	public int join(MemberDTO mDto) throws Exception {
		mapper.join(mDto);
		return 1;
	}
	@Override
	public void authJoin(MemberDTO mDto) throws Exception {
		mapper.authJoin(mDto);
	}
	@Override
	public MemberDTO read(String id) throws Exception {
		return mapper.read(id);
	}

	@Override
	public int findAndUpdate(Map<String, String> updateMap) throws Exception {
		return mapper.findAndUpdate(updateMap);
	}

	@Override
	public int addrUpdate(MemberDTO mDto) throws Exception {
		return mapper.addrUpdate(mDto);
	}

	@Override
	public int pwdUpdate(MemberDTO mDto) throws Exception {
		return mapper.pwdUpdate(mDto);
	}

	@Override
	public int exitMem(Map<String, String> exitMap) throws Exception {
		mapper.exitAuth(exitMap);
		return mapper.exitMem(exitMap);
	}

	@Override
	public int recoverAuth(MemberDTO mDto) throws Exception {
		mapper.recoverEnable(mDto);
		return mapper.recoverAuth(mDto);
	}



}
