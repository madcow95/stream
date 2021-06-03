package com.moviestream.movie.member.security;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import com.moviestream.movie.member.domain.MemberDTO;
import com.moviestream.movie.member.mapper.MemberMapper;

public class LoginAccessHandler implements AuthenticationSuccessHandler{
	
	private static final Logger log = LoggerFactory.getLogger(LoginAccessHandler.class);
	
	@Autowired
	private MemberMapper mapper;

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication auth)
			throws IOException, ServletException {
		
		log.warn("Login Success");
		List<String> roleNames = new ArrayList<>();
		
		auth.getAuthorities().forEach(authority -> {
			roleNames.add(authority.getAuthority());
		});
		
		log.warn("TEST INFO : " + auth.getDetails());
		log.warn("ROLE NAMES : " + roleNames);
		
		if(roleNames.contains("ROLE_ADMIN")) {
			response.sendRedirect("/admin/adminhome");
			return;
		}
		
		if(roleNames.contains("ROLE_USER")) {
			response.sendRedirect("/");
			return;
		}
		
		response.sendRedirect("/member/login_fail");
	}

}
