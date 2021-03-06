package com.moviestream.movie.member.security;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.stereotype.Service;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class LoginFailHandler implements AuthenticationFailureHandler{

	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response, AuthenticationException exception)
			throws IOException, ServletException {
		log.info("login fail class");
		if(exception instanceof AuthenticationException) {
			request.setAttribute("loginFailMsg", "회원정보가 일치하지 않습니다.");
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("/login");
		log.info("실패순서 1");
		dispatcher.forward(request, response);
	}

}
