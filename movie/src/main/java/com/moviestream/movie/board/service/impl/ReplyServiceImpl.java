package com.moviestream.movie.board.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.moviestream.movie.board.domain.Criteria;
import com.moviestream.movie.board.domain.ReplyDTO;
import com.moviestream.movie.board.domain.ReplyPageDTO;
import com.moviestream.movie.board.mapper.ReplyMapper;
import com.moviestream.movie.board.service.IReplyService;

@Service
public class ReplyServiceImpl implements IReplyService{
	
	@Autowired
	private ReplyMapper replyMapper;
	
	@Override
	public ReplyPageDTO getListPage(Criteria cri, int articleno) {
		
		return new ReplyPageDTO(replyMapper.getCountByBno(articleno), replyMapper.getListWithPaging(cri, articleno));
	}

	@Override
	public int register(ReplyDTO rDto) throws Exception {
		
		return replyMapper.register1(rDto);
	}

	@Override
	public int replyDelete(int rno) throws Exception {
		return replyMapper.replyDelete(rno);
	}

	@Override
	public ReplyDTO getReply(int articleno) throws Exception {
		
		return replyMapper.getReply(articleno);
	}

}
