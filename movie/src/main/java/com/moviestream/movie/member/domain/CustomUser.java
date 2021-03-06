package com.moviestream.movie.member.domain;

import java.util.Collection;
import java.util.stream.Collectors;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import lombok.Getter;
import lombok.extern.log4j.Log4j;

@Getter
@Log4j
public class CustomUser extends User{
	
	private static final long serialVersionUID = 1L;
	private MemberDTO member;
	private AdminDTO admin;

	public CustomUser(String username, String password, Collection<? extends GrantedAuthority> authorities) {
		super(username, password, authorities);
		log.info("customuser username >>> " + username);
		log.info("customuser password >>> " + password);
		log.info("customuser authorities >>> " + authorities);
	}
	
	public CustomUser(MemberDTO mDto) {
		super(mDto.getId(), mDto.getPwd(), mDto.getAuthList().stream().map(auth -> new SimpleGrantedAuthority(auth.getAuth())).collect(Collectors.toList()));
		log.info("custom user mDto >>>> "+mDto);
		log.info("순서체크 >>>> 2");
		this.member = mDto;
	}
	
	public CustomUser(AdminDTO aDto) {
		super(aDto.getId(), aDto.getPwd(), aDto.getAdminAuthList().stream().map(auth -> new SimpleGrantedAuthority(auth.getAuth())).collect(Collectors.toList()));
		this.admin = aDto;
	}
}
