package com.moviestream.movie.security;


import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.moviestream.movie.member.domain.MemberDTO;
import com.moviestream.movie.member.mapper.MemberMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml","file:src/main/webapp/WEB-INF/spring/security-context.xml"})
@Log4j
public class MemberMapperTests {
	
	@Setter(onMethod_ = @Autowired)
	private MemberMapper mapper;

	@Test
	public void test() {
		MemberDTO mDto = mapper.read("user100");
		
		log.info("login result >>> "+mDto);
		mDto.getAuthList().forEach(auth -> {
			log.info("auth result >>> "+auth);
		});
	}

}
