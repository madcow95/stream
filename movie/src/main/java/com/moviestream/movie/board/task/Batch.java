package com.moviestream.movie.board.task;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.moviestream.movie.board.mapper.BoardAttachMapper;
import com.moviestream.movie.member.domain.BatchDTO;
import com.moviestream.movie.member.mapper.BatchMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Component
@Log4j
public class Batch {
	
	@Setter(onMethod_ = {@Autowired})
	private BoardAttachMapper mapper;
	
	@Autowired
	private BatchMapper bMapper;
	
	@Scheduled(cron = "* * 2 * * *")
	public void checkFiles() throws Exception {
		log.warn("Old User check task running >>>>>>>>>>>>>>>>>>>>>>.");
		
		// status가 N인 회원들
		List<BatchDTO> UserList = bMapper.getOldUser();
		for(int i = 0; i < UserList.size(); i++) {
			log.info(UserList.get(i).getId());
			bMapper.delOldUser(UserList.get(i).getId());
		}
	}

}
