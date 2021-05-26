package com.moviestream.movie.board;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.moviestream.movie.board.domain.BoardDTO;
import com.moviestream.movie.board.domain.Criteria;
import com.moviestream.movie.board.domain.FreeCriteria;
import com.moviestream.movie.board.domain.MovieInfoDTO;
import com.moviestream.movie.board.domain.PageDTO;
import com.moviestream.movie.board.service.IBoardService;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/board")
@Log4j
public class BoardController {
	
	@Autowired
	private IBoardService service;
	
	// 공지사항
	@RequestMapping("/list")
	public void boardList(Model model, Criteria cri) throws Exception {
		model.addAttribute("boardList", service.boardList(cri));
		model.addAttribute("pageMaker", new PageDTO(cri, service.getTotalCnt(cri)));
	}
	
	// 자유게시판
	@RequestMapping("/freeBoard")
	public void freeBoard(Model model, FreeCriteria cri) throws Exception {
		model.addAttribute("freeBaord", service.freeBoard(cri));
		model.addAttribute("pageMaker", new PageDTO(cri, service.getFreeTotalCnt(cri)));
	}
	
	@RequestMapping({"/read","/modify"})
	public void read(Criteria cri, @RequestParam("articleno") int articleno, Model model) throws Exception {
		model.addAttribute("boardList", service.read(articleno));
		model.addAttribute("cri", cri);
	}
	
	@RequestMapping(value = "/modify", method = RequestMethod.POST)
	public String modify(BoardDTO bDto,Criteria cri, RedirectAttributes redirect) throws Exception {
		String uri = "update_fail";
		String encodeKeyword = URLEncoder.encode(cri.getKeyword(), "UTF-8");
		String encodeType = URLEncoder.encode(cri.getType(), "UTF-8");
		if(service.modify(bDto) == true) {
			uri = "redirect:/board/read?pageNum="+cri.getPageNum()+"&keyword="+encodeKeyword+"&type="+encodeType+"&articleno="+bDto.getArticleno();
		}
		
		return uri;
	}
	
	@RequestMapping(value = "/remove")
	public String remove(BoardDTO bDto, Criteria cri) throws Exception {
		log.info("remove artNo >>>> "+bDto.getArticleno());
		String uri = "remove_fail";
		if(service.remove(bDto) == true) {
			String encodeKeyword = URLEncoder.encode(cri.getKeyword(), "UTF-8");
			String encodeType = URLEncoder.encode(cri.getType(), "UTF-8");
			uri = "redirect:/board/list?pageNum="+cri.getPageNum()+"&keyword="+encodeKeyword+"&type="+encodeType;
		}
		return uri;
	}
	
//	@RequestMapping("/movieBoard")
//	public void ready(Model model) throws IOException{
//		StringBuilder urlBuilder = new StringBuilder("http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp?collection=kmdb_new2");
//		urlBuilder.append("&"+URLEncoder.encode("detail","UTF-8")+"="+URLEncoder.encode("N","UTF-8"));
//		urlBuilder.append("&" + URLEncoder.encode("title","UTF-8") + "=" + URLEncoder.encode("극한직업", "UTF-8"));
//		urlBuilder.append("&" + URLEncoder.encode("ServiceKey","UTF-8")+"="+URLEncoder.encode("1PK871G36HUKL041381C","UTF-8")); // 유의
//		URL url = new URL(urlBuilder.toString()); HttpURLConnection conn = (HttpURLConnection) url.openConnection();
//		conn.setRequestMethod("GET");
//		conn.setRequestProperty("Content-type", "application/json; UTF-8"); 
//		System.out.println("Response code: " + conn.getResponseCode());
//		BufferedReader rd; 
//		if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
//			rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
//		} else {
//			 rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
//		}
//		StringBuilder sb = new StringBuilder();
//		String line; 
//		while ((line = rd.readLine()) != null) {
//			sb.append(line); 
//		}
//		rd.close();
//		conn.disconnect();
//		List<StringBuilder> movieList = new ArrayList<StringBuilder>();
//		movieList.add(sb);
//		log.info(movieList);
//		model.addAttribute("movieList", movieList);
//	}
	
	@RequestMapping(value = "/movieBoard", method = RequestMethod.GET)
	public void board() {
	}
	
	@RequestMapping(value = "/boardSearch", method = RequestMethod.GET)
	public @ResponseBody JSONArray movieBoard(@RequestParam("keyword") String keyword) throws Exception {
		String clientId = "5QM_wfDAdLPm12A5by6q"; //애플리케이션 클라이언트 아이디값"
        String clientSecret = "Dxo2BaBD_q"; //애플리케이션 클라이언트 시크릿값"
        log.info("keyword >>> " + keyword);
        String text = null;
        try {
            text = URLEncoder.encode(keyword, "UTF-8");
        } catch (UnsupportedEncodingException e) {
            throw new RuntimeException("검색어 인코딩 실패",e);
        }
        String apiURL = "https://openapi.naver.com/v1/search/movie.json?query=" + text;    // json 결과
        //String apiURL = "https://openapi.naver.com/v1/search/blog.xml?query="+ text; // xml 결과

        Map<String, String> requestHeaders = new HashMap<>();
        requestHeaders.put("X-Naver-Client-Id", clientId);
        requestHeaders.put("X-Naver-Client-Secret", clientSecret);
        String responseBody = service.get(apiURL,requestHeaders);

        JSONParser jsonParser = new JSONParser();
        JSONObject jsonObject = (JSONObject) jsonParser.parse(responseBody);
        JSONArray infoArray = (JSONArray) jsonObject.get("items");
        List<MovieInfoDTO> mList = new ArrayList<>();
        MovieInfoDTO movieInfo = null;
        for(int i = 0; i < infoArray.size(); i++) {
        	movieInfo = new MovieInfoDTO();
            System.out.println("=item_" + i + "============================");
            JSONObject itemObject = (JSONObject) infoArray.get(i);
            System.out.println("title:\t" + itemObject.get("title"));
            System.out.println("subtitle:\t" + itemObject.get("subtitle"));
            System.out.println("director:\t" + itemObject.get("director"));
            System.out.println("actor:\t" + itemObject.get("actor"));
            System.out.println("image:\t" + itemObject.get("image"));
            System.out.println("userRating:\t" + itemObject.get("userRating") + "\n");
            String title = (String)itemObject.get("title");
            String subtitle = (String)itemObject.get("subtitle");
            String director = (String)itemObject.get("director");
            String actor = (String)itemObject.get("actor");
            String image = (String)itemObject.get("image");
            String userRating = (String)itemObject.get("userRating");
            movieInfo.setTitle(title);
            movieInfo.setTitle(subtitle);
            movieInfo.setTitle(director);
            movieInfo.setTitle(actor);
            movieInfo.setTitle(image);
            movieInfo.setTitle(userRating);
//            mListDto = new MovieListDTO();
//            mListDto.setTitle((String) itemObject.get("title"));
//            mListDto.setSubtitle((String) itemObject.get("subtitle"));
//            mListDto.setDirector((String) itemObject.get("director"));
//            mListDto.setActor((String) itemObject.get("actor"));
//            mListDto.setUserRating((String) itemObject.get("userRating"));
            if(movieInfo != null) {
            	mList.add(movieInfo);
            }
        }
        for(MovieInfoDTO movie : mList) {
        	log.info(movie.toString());
        }
//        log.info("mList size >>> " + mList.size());
//        for(int i = 0; i > mList.size(); i++) {
//        	mList.get(i).toString();
//        }
//        Map<String, Object> listMap = new HashMap<>();
//        listMap.put("list", mList);
//        log.info("listMap List 체크 >>>> " + listMap.size());
//        log.info("listMap List 체크 >>>> " + listMap.get("list"));
//        return infoArray;
        if(infoArray != null) {
        	log.info("있다");
        }
        return infoArray;
}
}