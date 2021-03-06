package com.moviestream.movie.board;

import java.net.URLEncoder;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.moviestream.movie.board.domain.BoardAttachDTO;
import com.moviestream.movie.board.domain.BoardDTO;
import com.moviestream.movie.board.domain.Criteria;
import com.moviestream.movie.board.domain.FreeCriteria;
import com.moviestream.movie.board.domain.PageDTO;
import com.moviestream.movie.board.mapper.BoardAttachMapper;
import com.moviestream.movie.board.mapper.ReplyMapper;
import com.moviestream.movie.board.service.IBoardService;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/board")
@Log4j
public class BoardController {
	
	@Autowired
	private IBoardService service;
	
	@Autowired
	private ReplyMapper replyMapper;
	
	@Autowired
	private BoardAttachMapper attachMapper;
	
	@GetMapping("/register")
	public void registerGet() {
	}
	@GetMapping("/adminRegister")
	public void adminRegister() throws Exception {
	}
	
	@PostMapping("/register")
	public String registerPost(BoardDTO bDto, RedirectAttributes rttr) throws Exception{
		log.info("register post>>>>>>>>>>>>>>>>>>>>>."+bDto);
		
		log.info("=====================================================");
		if (bDto.getAttachList() != null) {
			bDto.getAttachList().forEach(attach -> log.info(""+attach));
		}
		log.info("=====================================================");
		
		service.register(bDto);
		
		rttr.addFlashAttribute("result", bDto.getArticleno());
		return "redirect:/board/freeBoard";
	}
	
	// ????????????
	@RequestMapping("/list")
	public void boardList(Model model, Criteria cri) throws Exception {
		model.addAttribute("aboardList", service.boardList(cri));
		model.addAttribute("pageMaker", new PageDTO(cri, service.getTotalCnt(cri)));
	}
	
	// ???????????????
	@RequestMapping("/freeBoard")
	public void freeBoard(Model model, FreeCriteria cri) throws Exception {
		log.info("freeboard >>> "+cri);
		log.info("freeboard total cnt >>> "+service.getFreeTotalCnt(cri));
		model.addAttribute("freeBoard", service.freeBoard(cri));
		model.addAttribute("pageMaker2", new PageDTO(cri, service.getFreeTotalCnt(cri)));
	}
	
	@RequestMapping({"/freeboardread","/freeboardmodify"})
	public void freeboardread(FreeCriteria cri, BoardDTO bDto, Model model) throws Exception {
		log.info("freeread >>>> " + cri + "articleno >>> " + bDto.getArticleno());
		service.updateReadCount(bDto);
		model.addAttribute("boardList", service.read(bDto.getArticleno()));
		model.addAttribute("cri", cri);
	}
	
	@RequestMapping("/freeboarddel")
	public String delFreeBoard(BoardDTO bDto, Criteria cri) throws Exception {
		log.info("??????????????? ?????? ????????? >>> " + bDto + "cri >>> " + cri);
		
		int result = replyMapper.boardDel(bDto.getArticleno());
		log.info("?????? ?????? ?????? >>>> " + result);
		if (result >= 0) {
			result = attachMapper.delFreeBoard(bDto.getArticleno());
			log.info("???????????? ?????? ?????? >>>> " + result);
			if(result >= 0) {
				result = service.delFreeBoard(bDto.getArticleno());
				log.info("????????? ?????? ?????? >>>> " + result);
			}
		}
		return "redirect:/board/freeBoard?pageNum="+cri.getPageNum();
	}
	
	@RequestMapping({"/read","/modify"})
	public void read(FreeCriteria cri, @RequestParam("articleno") int articleno, Model model) throws Exception {
		log.info("read >>>> " + cri + "articleno >>> " + articleno);
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
	
	@RequestMapping(value = "/movieBoard", method = RequestMethod.GET)
	public String board() {
		return "/board/movieBoard";
	}
	@RequestMapping(value = "/movieBoardtest", method = RequestMethod.GET)
	public String boardTest() {
		return "/board/movieBoard_test";
	}
	
	@GetMapping(value = "/getAttachList",
			produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<BoardAttachDTO>> getAttachList(int articleno) throws Exception {
		log.info("getAttachList : bno ================ " + articleno);
		
		return new ResponseEntity<>(service.getAttachList(articleno), HttpStatus.OK);
	}
	
	@GetMapping("/modify")
	public String modify(BoardDTO bDto, Model model) throws Exception {
		log.info("modify bDto"+bDto);
		BoardDTO boardList = service.read(bDto.getArticleno());
		model.addAttribute("boardList", boardList);
		return "/board/freeboardmodify";
	}
	
	@PostMapping("/modifyBoard")
	public String modifyBoard(BoardDTO bDto) throws Exception {
		log.info("modify Board bDto >>>> "+bDto);
		int result = service.modifyBoard(bDto);
		if(result > 0) {
			log.info("modify success");
		}
		return "redirect:/board/freeboardread?articleno="+bDto.getArticleno();
	}
	
	@PostMapping("/adminregister")
	public String adminRegisterPost(BoardDTO bDto, Criteria cri, Model model) throws Exception {
		int result = service.adminRegister(bDto);
		log.info("admin insert result >>>> " + result);
		model.addAttribute("aboardList", service.boardList(cri));
		
//		List<BoardDTO board> boardList = service
		return "/board/list";
	}
	
	@GetMapping("/adminboardread")
	public String adminRead(Criteria cri, BoardDTO bDto, Model model) throws Exception {
		model.addAttribute("aboardList", service.adminread(bDto.getArticleno()));
		model.addAttribute("acri", cri);
		return "/board/read";
	}
	
	@GetMapping("/adminmodify")
	public String adminModify(Criteria cri, BoardDTO bDto, Model model) throws Exception {
		log.info("admin modify cri >>> " + cri + "bDto >>>> " + bDto);
		model.addAttribute("aboardList", service.adminread(bDto.getArticleno()));
		model.addAttribute("cri", cri);
		return "board/modify";
	}
	
}
