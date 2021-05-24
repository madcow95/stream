package com.moviestream.movie.member;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.moviestream.movie.member.domain.MemberDTO;
import com.moviestream.movie.member.service.IMemberService;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/member")
@Log4j
public class MemberController {
	
	private org.slf4j.Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	@Autowired
	private IMemberService service;
	
	@RequestMapping("/login")
	public void login() throws Exception {
	}
	
	@RequestMapping("/contract")
	public void contract() {
	}
	
	@RequestMapping("/mypage")
	public void mypage() {
	}
	
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String login(@RequestParam("id") String id,
					  @RequestParam("password") String pwd,
					  HttpSession session) throws Exception{
		
		String uri = "/member/result/login_fail";
		List<MemberDTO> memList = service.getMember();
		Map<String, String> loginMap = new HashMap<>();
		
		for(int i = 0; i < memList.size(); i++) {
			if(memList.get(i).getId().equals(id) && memList.get(i).getPwd().equals(pwd)) {
				loginMap.put("id", id);
				loginMap.put("pwd", pwd);
				session.setAttribute("memList", service.login(loginMap));
				uri="redirect:/";
			}
		}
		return uri;
	}
	
	@RequestMapping("/find")
	public void find() {
	}
	
}
