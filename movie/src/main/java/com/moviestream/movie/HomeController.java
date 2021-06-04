package com.moviestream.movie;

import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.moviestream.movie.board.domain.MovieInfoDTO;
import com.moviestream.movie.member.domain.MemberDTO;
import com.moviestream.movie.member.mapper.MemberMapper;
import com.moviestream.movie.member.service.IMemberService;
import com.moviestream.movie.movie.mapper.MovieMapper;
import com.moviestream.movie.movie.service.IMovieService;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Autowired
	private IMovieService service;
	
	@Autowired
	private IMemberService memberService;
	
	@Autowired
	private MovieMapper mapper;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model, HttpServletRequest request) throws Exception{
//		request.get
		logger.info("Welcome home! The client locale is {}.", locale);
		logger.info("");
		List<MovieInfoDTO> movieList = mapper.getMovie();
		model.addAttribute("movieList", movieList);
		return "index";
	}
	
	@RequestMapping("/logout")
	public String logout(HttpSession session) throws Exception {
		session.invalidate();
		return "redirect:/";
	}
	
	@RequestMapping("/test")
	public List<MovieInfoDTO> test(Model model) throws Exception{
		List<MovieInfoDTO> movieList = mapper.getMovie();
		model.addAttribute("movieList", movieList);
		return movieList;
	}
	
	@GetMapping("/login")
	public String login(String error, String logout,
						@ModelAttribute("mDto") MemberDTO mDto) {
		return "/member/login";
		
	}
	@PostMapping("/loginPost")
	public String loginpost(@RequestParam("username") String id, @RequestParam("password") String pwd, Model model, HttpSession session) throws Exception {
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		log.info("login id >>> "+id);
		String returnUrl = "";
		MemberDTO mDto = memberService.read(id);
		Map<String, String> loginMap = new HashMap<>();
		if(mDto != null) {
			if(encoder.matches(pwd, mDto.getPwd())) {
				log.info("info same");
				loginMap.put("id", id);
				loginMap.put("pwd", mDto.getPwd());
				MemberDTO memList = memberService.login(loginMap);
				model.addAttribute("memInfo", memList);
				returnUrl = "index";
			} else {
				returnUrl = "member/result/login_fail";
			}
		}else {
			returnUrl = "member/result/login_fail";
			
		}
		return returnUrl;
	}
	
}
