package com.moviestream.movie.board.persistence;

import java.util.List;

import com.moviestream.movie.board.domain.BoardDTO;
import com.moviestream.movie.board.domain.Criteria;
import com.moviestream.movie.board.domain.FreeCriteria;

public interface IBoardDAO {
	
	public List<BoardDTO> boardList(Criteria cri) throws Exception;
	public List<BoardDTO> freeBoard(FreeCriteria cri) throws Exception;
	public int getFreeTotalCnt(FreeCriteria cri) throws Exception;
	public int getTotalCnt(Criteria cri) throws Exception;
	public BoardDTO read(int articleno) throws Exception;
	public int modify(BoardDTO bDto) throws Exception;
	public int remove(BoardDTO bDto) throws Exception;
	
	public void create(BoardDTO bDto) throws Exception;
	public void updateViewCount(BoardDTO bDto) throws Exception;
}
