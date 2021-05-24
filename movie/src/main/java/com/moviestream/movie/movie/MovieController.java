package com.moviestream.movie.movie;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.moviestream.movie.movie.service.IMovieService;

@Controller
public class MovieController {

	@Autowired
	private IMovieService service;
	
	private Logger logger = LoggerFactory.getLogger(MovieController.class);
	
	@RequestMapping(value = "/enroll", method = RequestMethod.POST)
	public String enrollMovie() throws Exception{
		return "";
	}
}
