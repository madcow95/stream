package com.moviestream.movie.movie.service.impl;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.moviestream.movie.board.domain.MovieInfoDTO;
import com.moviestream.movie.movie.domain.MovieDTO;
import com.moviestream.movie.movie.persistence.IMovieDAO;
import com.moviestream.movie.movie.service.IMovieService;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class MovieServiceImpl implements IMovieService{
	
	@Autowired
	private IMovieDAO mDao;

	@Override
	public List<MovieDTO> getMovie() throws Exception {
		
		return mDao.getMovie();
	}
	
	@Override
	public String get(String apiUrl, Map<String, String> requestHeaders) throws Exception {
		HttpURLConnection con = connect(apiUrl);
        try {
            con.setRequestMethod("GET");
            for(Map.Entry<String, String> header :requestHeaders.entrySet()) {
                con.setRequestProperty(header.getKey(), header.getValue());
            }

            int responseCode = con.getResponseCode();
            if (responseCode == HttpURLConnection.HTTP_OK) { // 정상 호출
                return readBody(con.getInputStream());
            } else { // 에러 발생
                return readBody(con.getErrorStream());
            }
        } catch (IOException e) {
            throw new RuntimeException("API 요청과 응답 실패", e);
        } finally {
            con.disconnect();
        }
	}

	@Override
	public HttpURLConnection connect(String apiUrl) throws Exception {
		try {
            URL url = new URL(apiUrl);
            return (HttpURLConnection)url.openConnection();
        } catch (MalformedURLException e) {
            throw new RuntimeException("API URL이 잘못되었습니다. : " + apiUrl, e);
        } catch (IOException e) {
            throw new RuntimeException("연결이 실패했습니다. : " + apiUrl, e);
        }
	}

	@Override
	public String readBody(InputStream body) throws Exception {
		InputStreamReader streamReader = new InputStreamReader(body);

        try (BufferedReader lineReader = new BufferedReader(streamReader)) {
            StringBuilder responseBody = new StringBuilder();


            String line;
            while ((line = lineReader.readLine()) != null) {
                responseBody.append(line);
            }

            return responseBody.toString();
        } catch (IOException e) {
            throw new RuntimeException("API 응답을 읽는데 실패했습니다.", e);
        }
	}

	@Override
	public int saveMovie(MovieInfoDTO mDto) throws Exception {
		return mDao.saveMovie(mDto);
	}

	@Override
	public void delSameInfo(String link) throws Exception {
		mDao.delSameInfo(link);
	}

	@Override
	public List<MovieInfoDTO> search(String keyword) throws Exception {
		return mDao.search(keyword);
	}
	
}
