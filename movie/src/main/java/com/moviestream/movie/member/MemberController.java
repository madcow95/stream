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
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
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
	@RequestMapping(value = "/login", method = RequestMethod.GET)
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
	public void changePwd(@RequestParam("id") String id, Model model) {
		log.info("코드 입력후 비밀번호 이동 페이지 id >>> " + id);
		model.addAttribute("id", id);
	}
	@GetMapping("accessDeny")
	public String accessDeny() {
		return "member/result/accessDeny";
	}
	
	@GetMapping("/login_fail")
	public void login_fail(Authentication auth) {
		log.info("login fail");
		log.info("access denied : " + auth);
	}
	
	@PostMapping("/updateForm")
	public @ResponseBody String change(@RequestBody JSONObject mDto) throws Exception {
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		
		String id = (String) mDto.get("id");
		String pwd = (String) mDto.get("pwd");
		String result = "updateForm";
		MemberDTO memList = service.read(id);
		if(encoder.matches(pwd, memList.getPwd())) {
			return result;
		} else {
			result = "fail";
			return result;
		}
	}
	@GetMapping("updateForm")
	public void changeForm() {
	}
	
	@PostMapping(value = "/id_check")
	public @ResponseBody Map<String, Integer> id_check(@RequestBody String id) throws Exception {
		Map<String, Integer> checkMap = new HashMap<>();
		int result = -1;
		id = id.replaceAll("\"", "");
		result = service.id_check(id);
		if(result > 0) {
			result = 1;
		}
		checkMap.put("message", result);
		return checkMap;
	}
	
	@RequestMapping(value = "/join", method = RequestMethod.POST)
	public String join(MemberDTO mDto, @RequestParam("DetailAddress") String detailAddr) throws Exception {
		String url = "member/result/login_fail";
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		String encodedPwd = encoder.encode(mDto.getPwd());
		String detailAddress = mDto.getAddress() + detailAddr;
		mDto.setAddress(detailAddress);
		mDto.setPwd(encodedPwd);
		int result = service.join(mDto);
		if (result > 0) {
			service.authJoin(mDto);
			url = "member/result/join_suc";
		}
		return url;
	}
	
	@RequestMapping(value = "/find", method = RequestMethod.POST)
	public String findId(MemberDTO mDto, Model model) throws Exception {
		List<MemberDTO> memList = service.getMember();
		String uri = "member/result/login_fail";
		
		if(mDto.getId() == null && mDto.getName() != null && mDto.getEmail() != null) {
			
			for(int i = 0; i< memList.size(); i++) {
				if(memList.get(i).getName().equals(mDto.getName()) && memList.get(i).getEmail().equals(mDto.getEmail())) {
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
					uri = "member/result/findid";
				} 
			} // for end
		} // if end
		
		else if(mDto.getId() !=null && mDto.getName() == null && mDto.getEmail() != null){
			BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
			for(int i = 0; i < memList.size(); i++) {
				if(memList.get(i).getId().equals(mDto.getId()) && memList.get(i).getEmail().equals(mDto.getEmail())) {
					Random rnd = new Random();
					int rndNum = rnd.nextInt(100000) + 1;
					String code = "";
					if(rndNum >= 10000) {
						code = String.valueOf(rndNum);
					}
					String bcrptCode = encoder.encode(code);
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
					model.addAttribute("code", bcrptCode);
					model.addAttribute("id", mDto.getId());
					uri = "member/enterPwdCode";
				} else {
					
				}
			}
		}
		return uri;
	}
	
	@RequestMapping(value = "/changePwd", method = RequestMethod.POST)
	public String changepwd(@RequestParam("password12") String pwd,
							@RequestParam("id") String id) throws Exception {
		String url = "member/result/login_fail";
		Map<String, String> updateMap = new HashMap<>();
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		pwd = encoder.encode(pwd);
		updateMap.put("pwd", pwd);
		updateMap.put("id", id);
		int result = service.findAndUpdate(updateMap);
		if(result > 0) {
			url = "member/result/change_suc";
		}
		return url;
	}
	
	@PostMapping("/update")
	public String updateInfo(MemberDTO mDto,
							 @RequestParam("addr1") String addr1,
							 @RequestParam("addr2") String addr2,
							 HttpSession session) throws Exception {
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		String url = "member/result/login_fail";
		String address = addr1 + addr2;
		mDto.setAddress(address);
		log.info("update mDto" + mDto);
		int result = 0;
		if(mDto.getPwd() == null || mDto.getPwd()=="") {
			result = service.addrUpdate(mDto);
			if(result > 0) {
				MemberDTO memList = service.read(mDto.getId());
				session.removeAttribute("mDto");
				session.setAttribute("mDto", memList);
				url = "member/mypage";
			}
		} else {
			String encodePwd = encoder.encode(mDto.getPwd());
			mDto.setPwd(encodePwd);
			result = service.pwdUpdate(mDto);
			if(result > 0) {
				MemberDTO memList = service.read(mDto.getId());
				session.removeAttribute("mDto");
				session.setAttribute("mDto", memList);
				url = "member/mypage";
			}
		}
		return url;
	}
	
	@PostMapping("/codeChk")
	public @ResponseBody String codeChk(@RequestBody JSONObject codeList) throws Exception {
		String result = "code_fail";
		String insertCode = (String)codeList.get("insertCode");
		String encodedCode = (String)codeList.get("encodedCode");
		String id = (String)codeList.get("id");
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		if(encoder.matches(insertCode, encodedCode)) {
			result = id;
		}
		return result;
	}
	
	@PostMapping("/exit")
	public @ResponseBody String exit(@RequestBody JSONObject exit) throws Exception {
		String result = "fail";
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		log.info(exit);
		String id = (String) exit.get("id");
		String pwd = (String) exit.get("pwd");
		MemberDTO mDto = service.read(id);
		Map<String, String> exitMap = new HashMap<String, String>();
		exitMap.put("id", id);
		exitMap.put("pwd", pwd);
		if(encoder.matches(pwd, mDto.getPwd())) {
			log.info("same pwd");
			int exitNum = service.exitMem(exitMap);
			log.info("exit result >>> "+ exitNum);
			result = "exitSucc";
		}
		return result;
	}
	
	@GetMapping("/exitResult")
	public String exitResult(HttpSession session, HttpServletRequest request) throws Exception {
		session = request.getSession();
		session.invalidate();
		return "redirect:/";
	}
	
	@PostMapping("/exitCancel")
	public String realExit(@RequestParam("cancleId") String id, @RequestParam("canclePwd") String pwd, HttpSession session, HttpServletRequest request) throws Exception {
		log.info("cancel id & cancel pwd >>> " + id + pwd);
		String returnUrl = "member/result/login_fail";
		session = request.getSession();
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		MemberDTO mDto = service.read(id);
		int result = 0;
		log.info("idcheck >>> " + mDto);
		if(encoder.matches(pwd, mDto.getPwd())) {
			result = service.recoverAuth(mDto);
			log.info("encoder check result >>> "+ result);
			if(result > 0) {
				session.invalidate();
				returnUrl = "redirect:/logout";
			}
		}
 		log.info("before return url >>> " + returnUrl);
		return returnUrl;
	}
	
	@PostMapping("/emailCheck")
	public @ResponseBody String emailCheck(@RequestParam("email") String email) throws Exception {
		String result = "canuse";
		int emailCount = 0;
		if(email != null) {
			emailCount = service.emailCheck(email);
			if(emailCount > 0) {
				result = "used";
			}
		}
		return result;
	}
}
