package com.spring.board.dao.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.board.dao.BoardDao;
import com.spring.board.vo.BoardVo;
import com.spring.board.vo.PageVo;
import com.spring.board.vo.TypeVo;
import com.spring.board.vo.UserVo;

@Repository
public class BoardDaoImpl implements BoardDao{
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public String selectTest() throws Exception {
		// TODO Auto-generated method stub
		
		String a = sqlSession.selectOne("board.boardList");
		
		return a;
	}
	/**
	 * 
	 * */
	@Override
	public List<BoardVo> selectBoardList(PageVo pageVo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("board.boardList",pageVo);
	}
	
	@Override
	public int selectBoardCnt() throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("board.boardTotal");
	}
	
	@Override
	public BoardVo selectBoard(BoardVo boardVo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("board.boardView", boardVo);
	}
	
	@Override
	public int boardInsert(BoardVo boardVo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.insert("board.boardInsert", boardVo);
	}
	
	@Override
	public int delete(BoardVo boardVo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.delete("board.delete", boardVo);
	}
	
	@Override
	public int update(BoardVo boardVo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.update("board.update", boardVo);
	}
	
	@Override
	public List<TypeVo> selectTypeList(String codeType) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("board.typeList", codeType);
	}
	
	@Override
	public int selectId(String id) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("id_chk", id);
	}
	
	@Override
	public int userInsert(UserVo userVo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.insert("userInsert", userVo);
	}
	
	@Override
	public int selectLogin(UserVo userVo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("login", userVo);
	}
	
	@Override
	public UserVo selectUser(String id) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("userSelect",id);
	}
}
