package com.moviestream.movie.member;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin")
public class AdminController {

	@RequestMapping("/adminhome")
	public String adminHome() {
		return "member/admin/adminhome";
	}
}
