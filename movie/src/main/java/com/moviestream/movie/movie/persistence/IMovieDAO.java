package com.moviestream.movie.movie.persistence;

import java.util.List;

import com.moviestream.movie.board.domain.MovieInfoDTO;
import com.moviestream.movie.movie.domain.MovieDTO;

public interface IMovieDAO {

	public List<MovieDTO> getMovie() throws Exception;
	
	public int saveMovie(MovieInfoDTO mDto) throws Exception;
	
	public void delSameInfo(String link) throws Exception;
	public List<MovieInfoDTO> search(String keyword) throws Exception;
}
