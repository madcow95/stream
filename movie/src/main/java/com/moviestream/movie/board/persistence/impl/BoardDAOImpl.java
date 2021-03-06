package com.moviestream.movie.board.persistence.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.moviestream.movie.board.domain.BoardDTO;
import com.moviestream.movie.board.domain.Criteria;
import com.moviestream.movie.board.domain.FreeCriteria;
import com.moviestream.movie.board.persistence.IBoardDAO;

@Repository
public class BoardDAOImpl implements IBoardDAO{

	@Autowired
	private SqlSession session;
	
	@Override
	public List<BoardDTO> boardList(Criteria cri) throws Exception {
		return session.selectList("boardList", cri);
	}

	@Override
	public int getTotalCnt(Criteria cri) throws Exception {
		return session.selectOne("getTotalCnt",cri);
	}

	@Override
	public BoardDTO read(int articleno) throws Exception {
		return session.selectOne("freeboardread", articleno);
	}

	@Override
	public int modify(BoardDTO bDto) throws Exception {
		return session.update("modify", bDto);
	}

	@Override
	public int remove(BoardDTO bDto) throws Exception {
		return session.delete("remove", bDto);
	}

	@Override
	public List<BoardDTO> freeBoard(FreeCriteria cri) throws Exception {
		return session.selectList("freeBoardList", cri);
	}

	@Override
	public int getFreeTotalCnt(FreeCriteria cri) throws Exception {
		return session.selectOne("getFreeTotalCnt", cri);
	}

	@Override
	public void create(BoardDTO bDto) throws Exception {
		session.insert("register", bDto);
		
	}

	@Override
	public void updateViewCount(BoardDTO bDto) throws Exception {
		session.update("updateViewCount",bDto);
	}


}
