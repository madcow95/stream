package com.moviestream.movie.board;

import java.net.URLEncoder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.moviestream.movie.board.domain.BoardDTO;
import com.moviestream.movie.board.domain.Criteria;
import com.moviestream.movie.board.domain.FreeCriteria;
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
	public String board() {
		return "/board/movieBoard";
	}
	@RequestMapping(value = "/movieBoardtest", method = RequestMethod.GET)
	public String boardTest() {
		return "/board/movieBoard_test";
	}
	
}
