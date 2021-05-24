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
	
	@RequestMapping("/list")
	public void boardList(Model model, Criteria cri) throws Exception {
		log.info("list >>>> " + cri);
		model.addAttribute("boardList", service.boardList(cri));
		model.addAttribute("pageMaker", new PageDTO(cri, service.getTotalCnt(cri)));
	}
	
	@RequestMapping("/freeBoard")
	public void freeBoard(Model model, FreeCriteria cri) throws Exception {
		log.info("freeBoard >>>> "+cri);
		model.addAttribute("freeBaord", service.freeBoard(cri));
		model.addAttribute("pageMaker", new PageDTO(cri, service.getFreeTotalCnt(cri)));
	}
	
	@RequestMapping({"/read","/modify"})
	public void read(Criteria cri, @RequestParam("articleno") int articleno, Model model) throws Exception {
		log.info("read or modify get >>>> "+cri);
		model.addAttribute("boardList", service.read(articleno));
		model.addAttribute("cri", cri);
	}
	
	@RequestMapping(value = "/modify", method = RequestMethod.POST)
	public String modify(BoardDTO bDto,Criteria cri, RedirectAttributes redirect) throws Exception {
		log.info("modify bDto post >>>> "+bDto);
		log.info("modify cri  post >>>> "+cri);
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
	
	@RequestMapping("/board_ready")
	public void ready() {
	}
}
