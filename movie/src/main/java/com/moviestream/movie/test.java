package com.moviestream.movie;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/test")
public class test {
	
	@RequestMapping("/test")
	public String test2() throws Exception {
		
		return "test2";
	}
}
