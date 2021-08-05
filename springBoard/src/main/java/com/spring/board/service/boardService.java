package com.spring.board.service;

import java.util.List;

import com.spring.board.vo.BoardVo;
import com.spring.board.vo.PageVo;
import com.spring.board.vo.TypeVo;
import com.spring.board.vo.UserVo;

public interface boardService {

	public String selectTest() throws Exception;

	public List<BoardVo> SelectBoardList(PageVo pageVo) throws Exception;

	public BoardVo selectBoard(String boardType, int boardNum) throws Exception;

	public int selectBoardCnt() throws Exception;

	public int boardInsert(BoardVo boardVo) throws Exception;

	public int delete(BoardVo boardVo) throws Exception;

	public int update(BoardVo boardVo) throws Exception;

	public List<TypeVo> selectTypeList(String codeType) throws Exception;

	public int selectId(String id) throws Exception;

	public int userInsert(UserVo userVo) throws Exception;

	public int selectLogin(UserVo userVo) throws Exception;

	public UserVo selectUser(String id) throws Exception;

}
