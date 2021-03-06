package com.moviestream.movie.member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.ui.ModelMap;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import lombok.extern.log4j.Log4j;

@Log4j
public class LoginInterceptor extends HandlerInterceptorAdapter{
	
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		
		HttpSession session = request.getSession();
		ModelMap modelMap = modelAndView.getModelMap();
		log.info("modelmap >>>> "+modelMap);
		Object memInfo = modelMap.get("memInfo");
		log.info("memInfo >>>>> "+memInfo);
		log.info("memInfo auth >>>>> "+memInfo);
		
		if(memInfo != null) {
			log.info("intercept login success >>>> "+memInfo);
			session.setAttribute("mDto", memInfo);
			
			Object dest = session.getAttribute("dest");
			if(dest == null) {
				dest = "/";
			}
			log.info("LoginInterceptro dest >>>> "+dest);
			modelAndView.setViewName("redirect:" + (String)dest);
		}
	}
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session = request.getSession();
		
		if(session.getAttribute("mDto") != null) {
			log.info("clear login data before>..............");
			session.removeAttribute("mDto");
		}
		return true;
	}

}
