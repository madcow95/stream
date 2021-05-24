package com.moviestream.movie.board.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.moviestream.movie.board.domain.BoardDTO;
import com.moviestream.movie.board.domain.Criteria;
import com.moviestream.movie.board.domain.FreeCriteria;
import com.moviestream.movie.board.persistence.IBoardDAO;
import com.moviestream.movie.board.service.IBoardService;

@Service
public class BoardServiceImpl implements IBoardService{
	
	@Autowired
	private IBoardDAO bDao;

	@Override
	public List<BoardDTO> boardList(Criteria cri) throws Exception {
		return bDao.boardList(cri);
	}

	@Override
	public int getTotalCnt(Criteria cri) throws Exception {
		return bDao.getTotalCnt(cri);
	}

	@Override
	public BoardDTO read(int articleno) throws Exception {
		return bDao.read(articleno);
	}

	@Override
	public boolean modify(BoardDTO bDto) throws Exception {
		return bDao.modify(bDto) == 1;
	}

	@Override
	public boolean remove(BoardDTO bDto) throws Exception {
		return bDao.remove(bDto) == 1;
	}

	@Override
	public List<BoardDTO> freeBoard(FreeCriteria cri) throws Exception {
		return bDao.freeBoard(cri);
	}

	@Override
	public int getFreeTotalCnt(FreeCriteria cri) throws Exception {
		return bDao.getFreeTotalCnt(cri);
	}


}
