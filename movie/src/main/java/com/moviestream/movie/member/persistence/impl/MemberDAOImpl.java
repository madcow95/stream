package com.moviestream.movie.member.persistence.impl;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.moviestream.movie.member.domain.MemberDTO;
import com.moviestream.movie.member.persistence.IMemberDAO;

@Repository
public class MemberDAOImpl implements IMemberDAO{
	
	@Autowired SqlSession session;

	@Override
	public List<MemberDTO> getMember() throws Exception {

		return session.selectList("MemberMapper.getMember");
	}

	@Override
	public MemberDTO login(Map<String, String> loginMap) throws Exception {
		
		return session.selectOne("MemberMapper.login", loginMap);
	}

	@Override
	public int id_check(String id) throws Exception {
		return session.selectOne("id", id);
	}

	@Override
	public int pwdChange(Map<String, String> changeMap) throws Exception {
		return session.update("changePwd", changeMap);
	}

}
