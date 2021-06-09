package com.moviestream.movie.member.security;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import com.moviestream.movie.member.domain.AdminDTO;
import com.moviestream.movie.member.domain.MemberDTO;
import com.moviestream.movie.member.mapper.MemberMapper;
import com.moviestream.movie.member.service.IMemberService;

public class LoginAccessHandler implements AuthenticationSuccessHandler{
	
	private static final Logger log = LoggerFactory.getLogger(LoginAccessHandler.class);
	
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication auth)
			throws IOException, ServletException {
		log.warn("Login Success");
		List<String> roleNames = new ArrayList<>();
		
		auth.getAuthorities().forEach(authority -> {
			roleNames.add(authority.getAuthority());
		});
		
		log.warn("ROLE NAMES : " + roleNames);
		log.warn("TEST INFO : " + auth.getName());
		
		if(roleNames.contains("ROLE_ADMIN")) {
			response.sendRedirect("/secLogin");
			return;
		}
		
		if(roleNames.contains("ROLE_MEMBER")) {
			response.sendRedirect("/secLogin");
			return;
		}
		
		response.sendRedirect("/member/result/login_fail");
	}

}
