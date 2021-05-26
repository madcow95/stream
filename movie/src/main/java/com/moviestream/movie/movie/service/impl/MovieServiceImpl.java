package com.moviestream.movie.movie.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.moviestream.movie.movie.domain.MovieDTO;
import com.moviestream.movie.movie.persistence.IMovieDAO;
import com.moviestream.movie.movie.service.IMovieService;

@Service
public class MovieServiceImpl implements IMovieService{
	
	@Autowired
	private IMovieDAO mDao;

	@Override
	public List<MovieDTO> getMovie() throws Exception {
		
		return mDao.getMovie();
	}
	
}