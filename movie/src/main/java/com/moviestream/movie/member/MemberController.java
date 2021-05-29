package com.moviestream.movie.member;


import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.Random;

import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
	@RequestMapping("/findPwd")
	public void findPwd() {
	}
	@RequestMapping("/join")
	public void toJoin() {
	}
	@RequestMapping("/jusoPopup")
	public void juso() {
	}
	@RequestMapping("/changePwd")
	public void changePwd() {
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
	
	@RequestMapping(value = "/find", method = RequestMethod.POST)
	public String findId(MemberDTO mDto, Model model) throws Exception {
		log.info(mDto);
		List<MemberDTO> memList = service.getMember();
		String uri = "member/result/login_fail";
		
		if(mDto.getId() == null && mDto.getName() != null && mDto.getEmail() != null) {
			
			for(int i = 0; i< memList.size(); i++) {
				if(memList.get(i).getName().equals(mDto.getName()) && memList.get(i).getEmail().equals(mDto.getEmail())) {
					log.info(i+"번째 배열에 일치하는 회원이 있다." + memList.get(i).getId());
					String host = "smtp.gmail.com";
					final String username = "lobasketve@gmail.com";
					final String password = "sdtcow031#";
					
					String recipient = mDto.getEmail();
					
					String subject = "요청하신 정보입니다.";
					String body = "회원님의 아이디는 >>> "+memList.get(i).getId()+ "입니다.";
					
					Properties props = System.getProperties();
					
					props.put("mail.smtps.auth", "true");
					
					Session session = Session.getDefaultInstance(props);
					MimeMessage msg = new MimeMessage(session);
					
					try {
						msg.setSubject(subject);
						msg.setText(body);
						msg.setFrom(new InternetAddress(username));
						msg.addRecipient(Message.RecipientType.TO, new InternetAddress(recipient));
						
						Transport transport = session.getTransport("smtps");
						transport.connect(host, username, password);
						transport.sendMessage(msg, msg.getAllRecipients());
						transport.close();
					} catch (Exception e) {
						e.printStackTrace();
					}
					uri = "member/login";
				} 
			} // for end
		} // if end
		
		else if(mDto.getId() !=null && mDto.getName() == null && mDto.getEmail() != null){
			for(int i = 0; i < memList.size(); i++) {
				if(memList.get(i).getId().equals(mDto.getId()) && memList.get(i).getEmail().equals(mDto.getEmail())) {
					log.info(i+"번째 배열에 일치하는 회원이 있다. 비밀번호는 >>> " + memList.get(i).getPwd());
					Random rnd = new Random();
					int rndNum = rnd.nextInt(100000) + 1;
					int code = 0;
					if(rndNum >= 10000) {
						code = rndNum;
					}
					String host = "smtp.gmail.com";
					final String username = "lobasketve@gmail.com";
					final String password = "sdtcow031#";
					
					String recipient = mDto.getEmail();
					
					String subject = "인증번호 메일";
					String body = "입력해주세요 >>> "+code;
					
					Properties props = System.getProperties();
					
					props.put("mail.smtps.auth", "true");
					
					Session session = Session.getDefaultInstance(props);
					MimeMessage msg = new MimeMessage(session);
					
					try {
						msg.setSubject(subject);
						msg.setText(body);
						msg.setFrom(new InternetAddress(username));
						msg.addRecipient(Message.RecipientType.TO, new InternetAddress(recipient));
						
						Transport transport = session.getTransport("smtps");
						transport.connect(host, username, password);
						transport.sendMessage(msg, msg.getAllRecipients());
						transport.close();
					} catch (Exception e) {
						e.printStackTrace();
					}
					model.addAttribute("code", code);
					uri = "member/enterPwdCode";
				} else {
					log.info("아이디, 이메일 일치하는 회원 없음");
				}
			}
		}
		return uri;
	}
	
	@RequestMapping(value = "/changePwd", method = RequestMethod.POST)
	public String changepwd(@RequestParam("password") String pwd,
							@RequestParam("passwordCheck") String pwdChk) throws Exception {
		log.info("password AND passwordCheck >>>> " + pwd +" &&& " + pwdChk);
		return "member/login";
	}
}
