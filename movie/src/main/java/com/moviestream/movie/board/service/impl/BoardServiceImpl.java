package com.moviestream.movie.board.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.moviestream.movie.board.domain.BoardAttachDTO;
import com.moviestream.movie.board.domain.BoardDTO;
import com.moviestream.movie.board.domain.Criteria;
import com.moviestream.movie.board.domain.FreeCriteria;
import com.moviestream.movie.board.mapper.BoardAttachMapper;
import com.moviestream.movie.board.mapper.BoardMapper;
import com.moviestream.movie.board.persistence.IBoardDAO;
import com.moviestream.movie.board.service.IBoardService;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class BoardServiceImpl implements IBoardService{
	
	@Autowired
	private IBoardDAO bDao;
	
	@Autowired
	private BoardMapper mapper;
	
	@Autowired
	private BoardAttachMapper attachMapper;

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

	@Transactional
	@Override
	public void register(BoardDTO bDto) throws Exception {
		
		bDao.create(bDto);
		log.info("bsimpl bDto >>> "+bDto);
		
		if(bDto.getAttachList() == null || bDto.getAttachList().size() <= 0) {
			return;
		}
		bDto.getAttachList().forEach(attach -> {
			attach.setArticleno(bDto.getArticleno());
			try {
				attachMapper.insert(attach);
			} catch (Exception e) {
				e.printStackTrace();
			}
		});
	}

	@Override
	public List<BoardAttachDTO> getAttachList(int articleno) throws Exception {
		return attachMapper.findByArticleno(articleno);
	}

	@Override
	public void updateReadCount(BoardDTO bDto) throws Exception {
		bDao.updateViewCount(bDto);
	}

	@Override
	public int modifyBoard(BoardDTO bDto) throws Exception {
		return mapper.modifyBoard(bDto);
	}

	@Override
	public int adminRegister(BoardDTO bDto) throws Exception {
		
		return mapper.adminRegsiter(bDto);
	}

	@Override
	public BoardDTO adminread(int articleno) throws Exception {
		return mapper.adminread(articleno);
	}

	@Override
	public int delFreeBoard(int articleno) throws Exception {
		return mapper.delFreeBoard(articleno);
	}

}
