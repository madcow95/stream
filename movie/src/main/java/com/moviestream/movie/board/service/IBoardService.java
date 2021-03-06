package com.moviestream.movie.board.service;

import java.util.List;

import com.moviestream.movie.board.domain.BoardAttachDTO;
import com.moviestream.movie.board.domain.BoardDTO;
import com.moviestream.movie.board.domain.Criteria;
import com.moviestream.movie.board.domain.FreeCriteria;

public interface IBoardService {

	// 공지사항
	public List<BoardDTO> boardList(Criteria cri) throws Exception;
	public int getTotalCnt(Criteria cri) throws Exception;
	
	
	public BoardDTO adminread(int articleno) throws Exception;
	public BoardDTO read(int articleno) throws Exception;
	public int adminRegister(BoardDTO bDto) throws Exception;
	
	public boolean modify(BoardDTO bDto) throws Exception;
	public boolean remove(BoardDTO bDto) throws Exception;
	
	// 자유게시판
	public List<BoardDTO> freeBoard(FreeCriteria cri) throws Exception;
	public int getFreeTotalCnt(FreeCriteria cri) throws Exception;
	public void register(BoardDTO bDto) throws Exception;
	public List<BoardAttachDTO> getAttachList(int articleno) throws Exception;
	public void updateReadCount(BoardDTO bDto) throws Exception;
	public int delFreeBoard(int articleno) throws Exception;
	public int modifyBoard(BoardDTO bDto) throws Exception;
	
}
