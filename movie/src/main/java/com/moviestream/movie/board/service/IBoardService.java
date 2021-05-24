package com.moviestream.movie.board.service;

import java.util.List;

import com.moviestream.movie.board.domain.BoardDTO;
import com.moviestream.movie.board.domain.Criteria;
import com.moviestream.movie.board.domain.FreeCriteria;

public interface IBoardService {

	public List<BoardDTO> boardList(Criteria cri) throws Exception;
	public List<BoardDTO> freeBoard(FreeCriteria cri) throws Exception;
	public int getFreeTotalCnt(FreeCriteria cri) throws Exception;
	public int getTotalCnt(Criteria cri) throws Exception;
	public BoardDTO read(int articleno) throws Exception;
	public boolean modify(BoardDTO bDto) throws Exception;
	public boolean remove(BoardDTO bDto) throws Exception;
}
