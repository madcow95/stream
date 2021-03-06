package com.moviestream.movie.board.service;

import com.moviestream.movie.board.domain.Criteria;
import com.moviestream.movie.board.domain.ReplyDTO;
import com.moviestream.movie.board.domain.ReplyPageDTO;

public interface IReplyService {
	
	public ReplyPageDTO getListPage(Criteria cri, int articleno);
	public int register(ReplyDTO rDto) throws Exception;
	public int replyDelete(int rno) throws Exception;
	public ReplyDTO getReply(int articleno) throws Exception;

}
