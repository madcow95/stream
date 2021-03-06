package com.moviestream.movie.board.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.moviestream.movie.board.domain.Criteria;
import com.moviestream.movie.board.domain.ReplyDTO;

public interface ReplyMapper {
	
	public List<ReplyDTO> getListWithPaging(@Param("cri") Criteria cri, @Param("articleno") int articleno);
	public int getCountByBno(int articleno);
	public int register1(ReplyDTO rDto) throws Exception;
	public int replyDelete(int rno) throws Exception;
	public ReplyDTO getReply(int articleno) throws Exception;
	public int boardDel(int articleno) throws Exception;

}
