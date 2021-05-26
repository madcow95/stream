package com.moviestream.movie.member;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.moviestream.movie.member.domain.MemberDTO;
import com.moviestream.movie.member.service.IMemberService;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/member")
@Log4j
public class MemberController {
	
	@Autowired
	private IMemberService service;
	
	// 단순 페이지이동
	@RequestMapping("/login")
	public void login() {
	}
	@RequestMapping("/contract")
	public void contract() {
	}
	@RequestMapping("/mypage")
	public void mypage() {
	}
	@RequestMapping("/findid")
	public void findId() {
	}
	@RequestMapping("/findpwd")
	public void findPwd() {
	}
	@RequestMapping("/join")
	public void toJoin() {
	}
	@RequestMapping("/jusoPopup")
	public void juso() {
	}
	
	// control
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
	
	@PostMapping(value = "/id_check")
	public @ResponseBody Map<String, Object> id_check(@RequestParam("id") String id) throws Exception {
		Map<String, Object> checkMap = new HashMap<>();
		int result = -1;
		if(service.id_check(id) == 1) {
			result = 1;
		}
		checkMap.put("id", id);
		checkMap.put("message", result);
		return checkMap;
	}
	
	@RequestMapping(value = "/join", method = RequestMethod.POST)
	public String join(MemberDTO mDto) throws Exception {
		log.info(mDto);
		return "";
	}
	
	@RequestMapping(value = "/findId", method = RequestMethod.POST)
	public String findId(MemberDTO mDto) throws Exception {
		log.info(mDto);
		List<MemberDTO> memList = service.getMember();
		for(int i = 0; i< memList.size(); i++) {
			if(memList.get(i).getName().equals(mDto.getName()) && memList.get(i).getEmail().equals(mDto.getEmail())) {
				log.info("일치 회원 있음");
				break;
			}
		}
		return "";
	}
}
