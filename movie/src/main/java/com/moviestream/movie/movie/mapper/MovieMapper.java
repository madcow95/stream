package com.moviestream.movie.movie.mapper;

import java.util.List;

import com.moviestream.movie.board.domain.MovieInfoDTO;

public interface MovieMapper {
	
	public List<MovieInfoDTO> getMovie() throws Exception;

}
