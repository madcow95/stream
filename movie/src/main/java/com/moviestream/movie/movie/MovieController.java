package com.moviestream.movie.movie;

import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.api.client.googleapis.json.GoogleJsonResponseException;
import com.google.api.client.http.HttpRequest;
import com.google.api.client.http.HttpRequestInitializer;
import com.google.api.client.http.HttpTransport;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.JsonFactory;
import com.google.api.client.json.jackson2.JacksonFactory;
import com.google.api.services.youtube.YouTube;
import com.google.api.services.youtube.YouTube.Search;
import com.google.api.services.youtube.model.SearchListResponse;
import com.google.api.services.youtube.model.SearchResult;
import com.moviestream.movie.board.domain.MovieInfoDTO;
import com.moviestream.movie.movie.service.IMovieService;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/movie")
@Log4j
public class MovieController {
	
	private static String PROPERTIES_FILENAME = "youtube.properties";
	
	private static final HttpTransport HTTP_TRANSPORT = new NetHttpTransport();
	
	private static final JsonFactory JSON_FACTORY = new JacksonFactory();
	
	private static final long NUMBER_OF_VIDEOS_RETURNED = 5;
	
	private static YouTube youtube;

	@Autowired
	private IMovieService service;
	
	
	@RequestMapping(value = "/enroll", method = RequestMethod.POST)
	public String enrollMovie() throws Exception{
		return "";
	}
	
	// ????????????
	@RequestMapping(value = "/boardSearch", method = RequestMethod.GET)
	public String movieBoard(@RequestParam("keyword") String keyword, Model model) throws Exception {
		String clientId = "5QM_wfDAdLPm12A5by6q"; //?????????????????? ??????????????? ????????????"
        String clientSecret = "Dxo2BaBD_q"; //?????????????????? ??????????????? ????????????"
        String text = null;
        try {
            text = URLEncoder.encode(keyword, "UTF-8");
        } catch (UnsupportedEncodingException e) {
            throw new RuntimeException("????????? ????????? ??????",e);
        }
        String apiURL = "https://openapi.naver.com/v1/search/movie.json?&query=" + text;    // json ??????
        //String apiURL = "https://openapi.naver.com/v1/search/blog.xml?query="+ text; // xml ??????

        Map<String, String> requestHeaders = new HashMap<>();
        requestHeaders.put("X-Naver-Client-Id", clientId);
        requestHeaders.put("X-Naver-Client-Secret", clientSecret);
        String responseBody = service.get(apiURL,requestHeaders);

        JSONParser jsonParser = new JSONParser();
        JSONObject jsonObject = (JSONObject) jsonParser.parse(responseBody);
        JSONArray infoArray = (JSONArray) jsonObject.get("items");
        MovieInfoDTO movieInfo = null;
        List<MovieInfoDTO> mList = new ArrayList<>();
        for(int i = 0; i < infoArray.size(); i++) {
            JSONObject itemObject = (JSONObject) infoArray.get(i);
            String title = (String)itemObject.get("title");
            String subtitle = (String)itemObject.get("subtitle");
            String director = (String)itemObject.get("director");
            String actor = (String)itemObject.get("actor");
            String image = (String)itemObject.get("image");
            String userRating = (String)itemObject.get("userRating");
            String link = (String)itemObject.get("link");
            movieInfo = new MovieInfoDTO();
            movieInfo.setTitle(title);
            movieInfo.setSubtitle(subtitle);
            movieInfo.setDirector(director);
            movieInfo.setActor(actor);
            movieInfo.setImage(image);
            movieInfo.setUserRating(userRating);
            movieInfo.setLink(link);
        	mList.add(movieInfo);
        }
        model.addAttribute("movieList", mList);
        return "/board/movieBoard";
}
	
	// ???????????????
	@RequestMapping(value = "/boardSearchtest", method = RequestMethod.GET)
	public @ResponseBody Map<String, List<MovieInfoDTO>> movieBoardPost(@RequestParam("keyword") String keyword, Model model) throws Exception {
		String clientId = "5QM_wfDAdLPm12A5by6q"; //?????????????????? ??????????????? ????????????"
		String clientSecret = "Dxo2BaBD_q"; //?????????????????? ??????????????? ????????????"
		String text = null;
		try {
			text = URLEncoder.encode(keyword, "UTF-8");
		} catch (UnsupportedEncodingException e) {
			throw new RuntimeException("????????? ????????? ??????",e);
		}
		String apiURL = "https://openapi.naver.com/v1/search/movie.json?&query=" + text;    // json ??????
		//String apiURL = "https://openapi.naver.com/v1/search/blog.xml?query="+ text; // xml ??????
		
		Map<String, String> requestHeaders = new HashMap<>();
		requestHeaders.put("X-Naver-Client-Id", clientId);
		requestHeaders.put("X-Naver-Client-Secret", clientSecret);
		String responseBody = service.get(apiURL,requestHeaders);
		JSONParser jsonParser = new JSONParser();
		JSONObject jsonObject = (JSONObject) jsonParser.parse(responseBody);
		JSONArray infoArray = (JSONArray) jsonObject.get("items");
		MovieInfoDTO movieInfo = null;
		List<MovieInfoDTO> mList = new ArrayList<>();
		if(infoArray == null) {
			return null;
		}
		for(int i = 0; i < infoArray.size(); i++) {
			JSONObject itemObject = (JSONObject) infoArray.get(i);
			String title = (String)itemObject.get("title");
			String subtitle = (String)itemObject.get("subtitle");
			String director = (String)itemObject.get("director");
			String actor = (String)itemObject.get("actor");
			String image = (String)itemObject.get("image");
			String userRating = (String)itemObject.get("userRating");
			String link = (String)itemObject.get("link");
			movieInfo = new MovieInfoDTO();
			movieInfo.setTitle(title);
			movieInfo.setSubtitle(subtitle);
			movieInfo.setDirector(director);
			movieInfo.setActor(actor);
			movieInfo.setImage(image);
			movieInfo.setUserRating(userRating);
			movieInfo.setLink(link);
			service.saveMovie(movieInfo);
			service.delSameInfo(link);
			mList.add(movieInfo);
		}
		List<MovieInfoDTO> movieList = service.search(keyword);
		Map<String, List<MovieInfoDTO>> movieMap = new HashMap<>();
		movieMap.put("searchList", movieList);
		return movieMap;
	}
	
	// ????????? ????????? ?????? ??????
	@PostMapping(value = "/youtube", produces = {MediaType.APPLICATION_JSON_UTF8_VALUE})
	public @ResponseBody String youtube(@RequestBody String title) throws Exception {
		log.info("youtube title >>>>>> " + title + "?????????");
		Properties properties = new Properties();
		try {
			InputStream in = Search.class.getResourceAsStream("/"+PROPERTIES_FILENAME);
			properties.load(in);
		} catch (IOException e) {
			System.err.println("There was an error reading " + PROPERTIES_FILENAME + ": " + e.getCause()
	          + " : " + e.getMessage());
			System.exit(1);
		}
		String videoUrl = "";
		try {
			youtube = new YouTube.Builder(HTTP_TRANSPORT, JSON_FACTORY, new HttpRequestInitializer() {
		        public void initialize(HttpRequest request) throws IOException {}
		      }).setApplicationName("youtube-cmdline-search-sample").build();
			
			String queryTerm = title + "?????????";
			
			YouTube.Search.List search = youtube.search().list("id,snippet");
			
			String apiKey = properties.getProperty("youtube.apikey");
			search.setKey(apiKey);
			search.setQ(queryTerm);
			search.setType("video");
			search.setFields("items(id/kind,id/videoId,snippet/title,snippet/thumbnails/high/url)");
			search.setMaxResults(NUMBER_OF_VIDEOS_RETURNED);
			SearchListResponse searchResponse = search.execute();
			
			List<SearchResult> searchResultList = searchResponse.getItems();
			if(searchResultList != null) {
//				videoUrl = service.prettyPrint(searchResultList.iterator(), queryTerm);
			}
		} catch (GoogleJsonResponseException e) {
			System.err.println("There was a service error: " + e.getDetails().getCode() + " : "
			          + e.getDetails().getMessage());
		} catch (IOException e) {
			System.err.println("There was an IO error: " + e.getCause() + " : " + e.getMessage());
		} catch (Throwable t) {
			t.printStackTrace();
		}
		log.info("before return videoUrl >>> " + videoUrl);
		return "psDtk7d-80U";
	}
	
}
