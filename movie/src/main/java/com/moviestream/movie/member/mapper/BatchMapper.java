package com.moviestream.movie.member.mapper;

import java.util.List;

import com.moviestream.movie.member.domain.BatchDTO;

public interface BatchMapper {
	
	public List<BatchDTO> getOldUser() throws Exception;
	public void delOldUser(String id) throws Exception;
}
