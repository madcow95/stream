package com.moviestream.movie.movie;


import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import com.moviestream.movie.board.domain.MovieInfoDTO;

public class GetMovie {
	
	public static void main(String[] args) throws IOException, ParseException{
		
		StringBuilder urlBuilder = new StringBuilder("http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp?collection=kmdb_new2");
		urlBuilder.append("&"+URLEncoder.encode("detail","UTF-8")+"="+URLEncoder.encode("Y","UTF-8"));
		urlBuilder.append("&" + URLEncoder.encode("title","UTF-8") + "=" + URLEncoder.encode("해리포터", "UTF-8"));
		urlBuilder.append("&" + URLEncoder.encode("ServiceKey","UTF-8")+"="+URLEncoder.encode("1PK871G36HUKL041381C","UTF-8")); // 유의
		System.out.println(urlBuilder);
		URL url = new URL(urlBuilder.toString()); HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		conn.setRequestMethod("GET");
		conn.setRequestProperty("Content-type", "application/json; UTF-8"); 
		System.out.println("Response code: " + conn.getResponseCode());
		BufferedReader rd; 
		if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
			rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		} else {
			 rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
		}
		StringBuilder sb = new StringBuilder();
		String line;
		while ((line = rd.readLine()) != null) {
			sb.append(line);
		}
		System.out.println("sb"+sb);
		rd.close();
		conn.disconnect();
		JSONParser jsonParser = new JSONParser();
		JSONObject jsonObject = (JSONObject) jsonParser.parse(sb.toString());
		JSONArray infoArray = (JSONArray) jsonObject.get("Data");
		Long totalCount = (Long)jsonObject.get("TotalCount");
		System.out.println("infoArray >>>> " + infoArray);
		// 데이터들 결과만 추출
		
		JSONObject item = (JSONObject) infoArray.get(0);
		JSONArray ResultArray = (JSONArray) item.get("Result");
		System.out.println("ResultArray >>>> " + ResultArray);
		System.out.println("ResultArraysize >>>> " + ResultArray.size());
		MovieInfoDTO movieInfo = null;
		
		List<MovieInfoDTO> movieList = new ArrayList<MovieInfoDTO>();
		String actor = "";
		for(int i = 0; i<totalCount-1; i++) {
			movieInfo = new MovieInfoDTO();
			// 감독이름 추출
			JSONObject directorObj = (JSONObject) ResultArray.get(i);
			JSONObject directorArray = (JSONObject) directorObj.get("directors");
			JSONArray directorArr = (JSONArray) directorArray.get("director");
			JSONObject Arrdirector = (JSONObject)directorArr.get(0);
			String director = (String) Arrdirector.get("directorNm");
			
			// 출연배우 추출
			JSONObject actorObj = (JSONObject) ResultArray.get(i);
			JSONObject actorArray = (JSONObject) actorObj.get("actors");
			JSONArray ActorArr = (JSONArray) actorArray.get("actor");
//			System.out.println("ActorArr >>> "+ActorArr);
			for(int j = 0; j<5; j++) {
				JSONObject actorResult = (JSONObject) ActorArr.get(j);
//				String test = (String)actorResult.get("actorNm");
				System.out.println("actorRestestult >>> " + actorResult);
			}
			
//			System.out.println("ArrActor >>> "+ArrActor);
			movieInfo.setDirector(director);
			movieInfo.setActor(actor);
			movieList.add(movieInfo);
		}
//		System.out.println("actor >>> "+actor);
		System.out.println("배우들"+movieList.get(0).getActor());
		for(int i = 0; i< movieList.size(); i++) {
		}
		
		
		
		
		
//		for(int i = 0; i < infoArray.size(); i++) {
//			System.out.println(totalCount);
//			JSONObject itemObject = (JSONObject) infoArray.get(i);
//			JSONArray array = (JSONArray) itemObject.get("Result");
//			JSONObject object = (JSONObject) array.get(i);
//			
//			// 감독명 추출
//			JSONObject direct = (JSONObject)object.get("directors");
//			JSONArray directArr = (JSONArray) direct.get("director");
//			JSONObject directorResult = (JSONObject) directArr.get(i);
//			
//			// 출연배우 추출
//			JSONObject JSONActor = (JSONObject)object.get("actors");
//			JSONArray JSONActorArr = (JSONArray) JSONActor.get("actor");
//			String actorList = "";
//			for (int j=0; j < 5; j++) {
//				JSONObject actorObj = (JSONObject)JSONActorArr.get(j);
//				actorList += actorObj.get("actorNm") + "/ ";
//			}
//			
//			// 썸네일 하나만 추출
//			String image = (String)object.get("posters");
//			String result = image.substring(image.lastIndexOf("|"));
//			
//			String title = (String)object.get("title");
//            String subtitle = (String)object.get("titleEng");
//            String director = (String)directorResult.get("directorNm");
//            String actor = actorList;
//            String link = (String)object.get("kmdbUrl");
//			String genre = (String)object.get("genre");
//			movieInfo = new MovieInfoDTO();
//            movieInfo.setTitle(title);
//            movieInfo.setSubtitle(subtitle);
//            movieInfo.setDirector(director);
//            movieInfo.setActor(actor);
//            movieInfo.setImage(result);
//            movieInfo.setLink(link);
//            movieInfo.setGenre(genre);
//            System.out.println(movieInfo.toString());
//		}
	}

}
