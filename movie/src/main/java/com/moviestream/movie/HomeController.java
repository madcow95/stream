package com.moviestream.movie;

import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.moviestream.movie.board.domain.MovieInfoDTO;
import com.moviestream.movie.movie.domain.MovieDTO;
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
	private MovieMapper mapper;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) throws Exception{
		logger.info("Welcome home! The client locale is {}.", locale);
		List<MovieDTO> movieList = service.getMovie();
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
	
}
