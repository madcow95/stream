package com.moviestream.movie.movie.service;

import java.util.List;

import com.moviestream.movie.movie.domain.MovieDTO;

public interface IMovieService {

	public List<MovieDTO> getMovie() throws Exception;
}
