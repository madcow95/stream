package com.moviestream.movie.board.service.impl;

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

import com.moviestream.movie.board.domain.BoardDTO;
import com.moviestream.movie.board.domain.Criteria;
import com.moviestream.movie.board.domain.FreeCriteria;
import com.moviestream.movie.board.persistence.IBoardDAO;
import com.moviestream.movie.board.service.IBoardService;

@Service
public class BoardServiceImpl implements IBoardService{
	
	@Autowired
	private IBoardDAO bDao;

	@Override
	public List<BoardDTO> boardList(Criteria cri) throws Exception {
		return bDao.boardList(cri);
	}

	@Override
	public int getTotalCnt(Criteria cri) throws Exception {
		return bDao.getTotalCnt(cri);
	}

	@Override
	public BoardDTO read(int articleno) throws Exception {
		return bDao.read(articleno);
	}

	@Override
	public boolean modify(BoardDTO bDto) throws Exception {
		return bDao.modify(bDto) == 1;
	}

	@Override
	public boolean remove(BoardDTO bDto) throws Exception {
		return bDao.remove(bDto) == 1;
	}

	@Override
	public List<BoardDTO> freeBoard(FreeCriteria cri) throws Exception {
		return bDao.freeBoard(cri);
	}

	@Override
	public int getFreeTotalCnt(FreeCriteria cri) throws Exception {
		return bDao.getFreeTotalCnt(cri);
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


}