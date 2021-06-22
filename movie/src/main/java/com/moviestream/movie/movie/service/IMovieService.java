package com.moviestream.movie.movie.service;

import java.io.InputStream;
import java.net.HttpURLConnection;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import com.google.api.services.youtube.model.SearchResult;
import com.moviestream.movie.TestDTO;
import com.moviestream.movie.board.domain.MovieInfoDTO;
import com.moviestream.movie.movie.domain.MovieDTO;

public interface IMovieService {

	public List<MovieDTO> getMovie() throws Exception;
	
	public String get(String apiUrl, Map<String, String> requestHeaders) throws Exception;
	public HttpURLConnection connect(String apiUrl) throws Exception;
	public String readBody(InputStream body) throws Exception;
	
	public int saveMovie(MovieInfoDTO mDto) throws Exception;
	
	public void delSameInfo(String link) throws Exception;
	public List<MovieInfoDTO> search(String keyword) throws Exception;
	public List<TestDTO> prettyPrint(Iterator<SearchResult> iteratorSearchResults, String query);
}
