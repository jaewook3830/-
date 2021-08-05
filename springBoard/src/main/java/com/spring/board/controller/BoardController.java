package com.spring.board.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.codehaus.jackson.JsonProcessingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.board.HomeController;
import com.spring.board.service.boardService;
import com.spring.board.vo.BoardVo;
import com.spring.board.vo.PageVo;
import com.spring.board.vo.TypeVo;
import com.spring.board.vo.UserVo;
import com.spring.common.CommonUtil;

@Controller
public class BoardController {
	
	@Autowired 
	boardService boardService;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@RequestMapping(value = "/board/boardLogin.do", method = RequestMethod.GET)
	public String boardLogin(Locale locale, Model model) throws Exception {
		return "board/boardLogin";
	}
	
	@RequestMapping(value = "/board/boardLoginAction.do", method = RequestMethod.POST)
	@ResponseBody
	public String boardLoginAction(HttpServletRequest request,@ModelAttribute("pw")String pw, @ModelAttribute("id")String id) throws Exception {
		UserVo userVo = new UserVo();
		userVo.setId(id);
		userVo.setPw(pw);
		
		HashMap<String, String> res = new HashMap<String, String>();
		CommonUtil commonUtil = new CommonUtil();
		
		int result = boardService.selectLogin(userVo);
		
		if(result > 0) {
			res.put("result", "1");
			request.getSession().setAttribute("id", id);
			request.getSession().setAttribute("login", "ok");
		}else {
			res.put("result", "0");
			int result2 = boardService.selectId(id);
			if(result2 > 0) {
				res.put("result2", "1");
			}else {
				res.put("result2", "0");
			}
		}
		String callbackMsg = commonUtil.getJsonCallBackString(" ",res);
		
		return callbackMsg;
	}
	
	@RequestMapping("/board/boardLogout.do")
	public ModelAndView logoutCommand(HttpServletRequest request) {
		request.getSession().invalidate();
		return new ModelAndView("redirect:/board/boardList.do?pageNo=0");
	}
	
	@RequestMapping(value = "/board/boardJoin.do", method = RequestMethod.GET)
	public String boardJoin(Locale locale, Model model) throws Exception {
		List<TypeVo> phoneList = new ArrayList<TypeVo>();
		
		phoneList = boardService.selectTypeList("phone");
		
		model.addAttribute("phoneList", phoneList);
		return "board/boardJoin";
	}
	
	@RequestMapping(value = "/board/id_chk.do")
	@ResponseBody
	public String boardIdCheck(@ModelAttribute("id")String id) throws Exception {
		int result = boardService.selectId(id);
		
		return String.valueOf(result);
	}
	
	@RequestMapping(value = "/board/boardJoinAction.do", method = RequestMethod.GET)
	public ModelAndView boardJoinAction(RedirectAttributes redirectAttributes, UserVo userVo, HttpServletRequest request) throws Exception {
		request.setCharacterEncoding("utf-8");
		
		List<TypeVo> phoneList = new ArrayList<TypeVo>();
		phoneList = boardService.selectTypeList("phone");
		
		for(int i = 0; i < phoneList.size(); i++) {
			if(phoneList.get(i).getCodeId().equals(userVo.getPhone1())) {
				userVo.setPhone1(phoneList.get(i).getCodeName());
				break;
			}
		}
		int result = boardService.userInsert(userVo);
		if(result > 0) {
			redirectAttributes.addFlashAttribute("msg_insert","insert_ok");
		}else {
			redirectAttributes.addFlashAttribute("msg_insert","insert_no");
		}
		return new ModelAndView("redirect:/board/boardList.do?pageNo=0");
	}	
	@RequestMapping(value = "/board/boardList.do", method = RequestMethod.GET)
	public String boardList(Locale locale, Model model,PageVo pageVo, HttpServletRequest request) throws Exception{
		List<BoardVo> boardList = new ArrayList<BoardVo>();
		List<TypeVo> typeList = new ArrayList<TypeVo>();		
		String id = (String) request.getSession().getAttribute("id");
		UserVo userVo = new UserVo();
		
		if(id != null) {
			userVo = boardService.selectUser(id);
			model.addAttribute("userVo", userVo);
		}

		int page = 1;
		
		if(pageVo.getPageNo() == 0){
			pageVo.setPageNo(page);
		}
			
		typeList = boardService.selectTypeList("menu");
		String[] arr = request.getParameterValues("chb");
		pageVo.setArr(arr);
		boardList = boardService.SelectBoardList(pageVo);
		
		model.addAttribute("typeList", typeList);
		model.addAttribute("boardList", boardList);
		model.addAttribute("totalCnt", boardList.size());
		model.addAttribute("pageNo", page);
		return "board/boardList";
	}
	
	@RequestMapping(value = "/board/{boardType}/{boardNum}/boardView.do", method = RequestMethod.GET)
	public String boardView(Locale locale, Model model
			,@PathVariable("boardType")String boardType
			,@PathVariable("boardNum")int boardNum) throws Exception{
	
		BoardVo boardVo = new BoardVo();
		
		boardVo = boardService.selectBoard(boardType,boardNum);
		
		model.addAttribute("boardType", boardType);
		model.addAttribute("boardNum", boardNum);
		model.addAttribute("board", boardVo);
		return "board/boardView";
	}
	
	@RequestMapping(value = "/board/boardWrite.do", method = RequestMethod.GET)
	public String boardWrite(Locale locale, Model model,HttpServletRequest request) throws Exception{
		List<TypeVo> typeList = new ArrayList<TypeVo>();
		UserVo userVo = new UserVo();
		String id = (String) request.getSession().getAttribute("id");
		
		if(id != null) {
			userVo = boardService.selectUser(id);
		}
		
		typeList = boardService.selectTypeList("menu");
		model.addAttribute("userVo", userVo);
		model.addAttribute("typeList", typeList);
		
		return "board/boardWrite";
	}
	
	@RequestMapping(value = "/board/boardWriteAction.do", method = RequestMethod.POST)
	@ResponseBody
	public String boardWriteAction(Locale locale,BoardVo boardVo, @RequestParam("boardType")String boardType, HttpServletRequest request) throws Exception{
		
		HashMap<String, String> result = new HashMap<String, String>();
		CommonUtil commonUtil = new CommonUtil();
		String[] bType = request.getParameterValues("bType");
		String[] bTitle = request.getParameterValues("boardTitle");
		String[] bComment = request.getParameterValues("boardComment");
		
		int resultCnt = 0;
		for(int i = 0; i < bType.length; i++) {
			boardVo.setBoardType(bType[i]);
			boardVo.setBoardTitle(bTitle[i]);
			boardVo.setBoardComment(bComment[i]);
			resultCnt = boardService.boardInsert(boardVo);;
		}
		
		result.put("success", (resultCnt > 0)?"Y":"N"); 
		String callbackMsg = commonUtil.getJsonCallBackString(" ",result);
		
		System.out.println("callbackMsg::"+callbackMsg);
		return callbackMsg;
	}
	@RequestMapping("/board/update_go.do")
	public ModelAndView update_goCommand(@RequestParam("boardType")String boardType, @RequestParam("boardNum")int boardNum) throws Exception {
		ModelAndView mv = new ModelAndView("board/boardUpdate");
		BoardVo boardVo = new BoardVo();
		
		boardVo = boardService.selectBoard(boardType,boardNum);
	
		mv.addObject("boardType", boardType);
		mv.addObject("boardNum", boardNum);
		mv.addObject("board", boardVo);
		return mv;
	}
	@RequestMapping(value="/board/delete.do", method = RequestMethod.GET)
	public ModelAndView deleteCommand(RedirectAttributes redirectAttributes,@RequestParam("boardType")String boardType, @RequestParam("boardNum")int boardNum) throws Exception{
		ModelAndView mv = new ModelAndView("redirect:/board/boardList.do?pageNo=0");
		BoardVo boardVo = new BoardVo();
		boardVo.setBoardType(boardType);
		boardVo.setBoardNum(boardNum);
		int result = boardService.delete(boardVo);
		if(result > 0) {
			redirectAttributes.addFlashAttribute("msg","delete_ok");
		}else {
			redirectAttributes.addFlashAttribute("msg","delete_no");
		}
		return mv;
	}
	
	@RequestMapping("/board/update.do")
	public ModelAndView updateCommand(RedirectAttributes redirectAttributes, HttpServletRequest request, @RequestParam("title")String title, @RequestParam("comment")String comment) throws Exception{
		
		String boardType = request.getParameter("boardType");
		
		int boardNum = Integer.parseInt(request.getParameter("boardNum"));
		
		BoardVo boardVo = new BoardVo();
		
		boardVo.setBoardType(boardType);
		boardVo.setBoardNum(boardNum);
		boardVo.setBoardTitle(title);
		boardVo.setBoardComment(comment);
		
		int result = boardService.update(boardVo);
		
		if(result > 0) {
			redirectAttributes.addFlashAttribute("msg","update_ok");
		}else {
			redirectAttributes.addFlashAttribute("msg","update_no");
		}
		return new ModelAndView("redirect:/board/"+boardType+"/"+boardNum+"/boardView.do");
	}
}
