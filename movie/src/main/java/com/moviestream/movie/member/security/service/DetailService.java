package com.moviestream.movie.member.security.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.moviestream.movie.member.domain.CustomUser;
import com.moviestream.movie.member.domain.MemberDTO;
import com.moviestream.movie.member.mapper.MemberMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
public class DetailService implements UserDetailsService{
	
	@Setter(onMethod_ = {@Autowired})
	private MemberMapper mapper;

	@Override
	public UserDetails loadUserByUsername(String userName) throws UsernameNotFoundException {
		
		log.warn("Load User By UserName  >>> "+userName);
		MemberDTO mDto = mapper.read(userName);
		log.warn("queried by member mapper >>>>>> "+mDto);
		log.warn("순서 체크 >>>>>> 1");
			return mDto == null ? null : new CustomUser(mDto);
	}

}
