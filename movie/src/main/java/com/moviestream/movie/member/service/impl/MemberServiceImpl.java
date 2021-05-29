package com.moviestream.movie.member.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.moviestream.movie.member.domain.MemberDTO;
import com.moviestream.movie.member.persistence.IMemberDAO;
import com.moviestream.movie.member.service.IMemberService;

@Service
public class MemberServiceImpl implements IMemberService{
	
	@Autowired
	private IMemberDAO mDao;
	
	@Override
	public List<MemberDTO> getMember() throws Exception {
		
		return mDao.getMember();
	}

	@Override
	public MemberDTO login(Map<String, String> loginMap) throws Exception {
		
		return mDao.login(loginMap);
	}

	@Override
	public int id_check(String id) throws Exception {
		return mDao.id_check(id);
	}

}
