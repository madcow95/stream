package com.moviestream.movie.board.mapper;

import java.util.List;

import com.moviestream.movie.board.domain.BoardAttachDTO;

public interface BoardAttachMapper {
	
	public void insert(BoardAttachDTO attachDto) throws Exception;
	public List<BoardAttachDTO> findByArticleno(int articleno) throws Exception;
	public int delFreeBoard(int articleno) throws Exception;
	
	public List<BoardAttachDTO> getOldFiles() throws Exception;

}
