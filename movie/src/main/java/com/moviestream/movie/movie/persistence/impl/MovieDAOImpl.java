package com.moviestream.movie.movie.persistence.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.moviestream.movie.movie.domain.MovieDTO;
import com.moviestream.movie.movie.persistence.IMovieDAO;

@Repository
public class MovieDAOImpl implements IMovieDAO{
	
	@Autowired
	private SqlSession session;

	@Override
	public List<MovieDTO> getMovie() throws Exception {
		
		return session.selectList("movieList");
	}

}
