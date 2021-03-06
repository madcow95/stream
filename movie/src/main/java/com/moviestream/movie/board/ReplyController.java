package com.moviestream.movie.board;


import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.moviestream.movie.board.domain.Criteria;
import com.moviestream.movie.board.domain.ReplyDTO;
import com.moviestream.movie.board.domain.ReplyPageDTO;
import com.moviestream.movie.board.service.IReplyService;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/replies")
@Log4j
public class ReplyController {
	
	@Autowired
	private IReplyService replyService;

	@GetMapping(value = "/pages/{articleno}/{page}", produces = { MediaType.APPLICATION_JSON_UTF8_VALUE })
	public ResponseEntity<ReplyPageDTO> getlist(@PathVariable("articleno") int articleno, @PathVariable("page") int page, Model model)
			throws Exception {
		Criteria cri = new Criteria(page, 10);
		return new ResponseEntity<>(replyService.getListPage(cri, articleno), HttpStatus.OK);
	}
	
	@PostMapping(value = "/new", 
		     consumes = "application/json", 
		     produces = {MediaType.TEXT_PLAIN_VALUE})		//화면으로부터  json데이터로 넘어오는 데이터 타입이 객체와 일치하면 그 객체에 넣어준다?
	public ResponseEntity<String> create(@RequestBody ReplyDTO rDto) throws Exception{
		log.info("reply new >>>> "+rDto.toString());
		int insertCount = replyService.register(rDto);
	
		return insertCount == 1 ? new ResponseEntity<>("댓글작성완료", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@GetMapping("/delete")
	public String replyDel(@RequestParam("rno") int rno,
						 @RequestParam("articleno") int articleno) throws Exception {
		log.info("rno delete >>>> " + rno);
		log.info("articleno delete >>>> " + articleno);
		int result = replyService.replyDelete(rno);
		if(result > 0) {
			log.info("result >> success");
		} else {
			log.info("result >> del fail");
		}
		return "redirect:/board/freeboardread?articleno="+articleno;
	}
	
	@PostMapping("/modify")
	public void replyModify(@RequestBody JSONObject replyList, Model model) throws Exception {
		log.info("modify rno >>> "+ replyList.get("rno"));
		log.info("modify replyText >>> "+ replyList.get("replyText"));
//		ReplyDTO rDto = replyService.getReply(rno);
//		log.info("rDto >>>> " + rDto);
		
	}
}
