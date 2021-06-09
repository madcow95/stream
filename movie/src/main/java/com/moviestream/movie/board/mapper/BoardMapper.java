package com.moviestream.movie.board.mapper;

import com.moviestream.movie.board.domain.BoardDTO;

public interface BoardMapper {
	
	public void register(BoardDTO bDto) throws Exception;
//	public void updateReadCount(BoardDTO bDto) throws Exception;
	public int modifyBoard(BoardDTO bDto) throws Exception;
	public int adminRegsiter(BoardDTO bDto) throws Exception;
	public BoardDTO adminread(int articleno) throws Exception;
	public int delFreeBoard(int articleno) throws Exception;

}
