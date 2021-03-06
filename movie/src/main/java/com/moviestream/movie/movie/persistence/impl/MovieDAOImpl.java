package com.moviestream.movie.movie.persistence.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.moviestream.movie.board.domain.MovieInfoDTO;
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

	@Override
	public int saveMovie(MovieInfoDTO mDto) throws Exception {
		return session.update("saveMovie", mDto);
	}

	@Override
	public void delSameInfo(String link) throws Exception {
		session.delete("delSameInfo", link);
	}

	@Override
	public List<MovieInfoDTO> search(String keyword) throws Exception {
		return session.selectList("search", keyword);
	}

}
