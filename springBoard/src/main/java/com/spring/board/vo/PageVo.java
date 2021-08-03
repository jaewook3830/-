package com.spring.board.vo;

public class PageVo {
	
	private int pageNo = 0;
	private String[] array;
	public int getPageNo() {
		return pageNo;
	}

	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}

	public String[] getArr() {
		return array;
	}

	public void setArr(String[] arr) {
		this.array = arr;
	}
}
