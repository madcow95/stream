package com.moviestream.movie.admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.moviestream.movie.member.domain.MemberDTO;
import com.moviestream.movie.member.service.IMemberService;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/admin")
@Log4j
public class AdminController {
	
	@Autowired
	private IMemberService memberService;
	
	@RequestMapping("/memberManager")
	public void memberManager(Model model) throws Exception{
		List<MemberDTO> memList = memberService.getMember();
		model.addAttribute("memList", memList);
	}
	
	@GetMapping("delMember")
	public void delMember(@RequestParam("id") String id) throws Exception {
		log.info("del Member >>> id >>> " + id);
	}
	
	@RequestMapping("/boardManager")
	public void boardManager() throws Exception{
		
	}
}
