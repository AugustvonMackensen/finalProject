package com.andamiro.gammi.common;

public class Paging {
	//한 페이지에 출력할 시작행과 끝행을 저장하는 객체
	private int startRow;
	private int endRow;
	private String m_id;
	
	public Paging() {}

	public Paging(int startRow, int endRow, String m_id) {
		super();
		this.startRow = startRow;
		this.endRow = endRow;
		this.m_id = m_id;
	}

	public Paging(int startRow, int endRow) {
		super();
		this.startRow = startRow;
		this.endRow = endRow;
		this.m_id = null;
	}

	public int getStartRow() {
		return startRow;
	}

	public void setStartRow(int startRow) {
		this.startRow = startRow;
	}

	public int getEndRow() {
		return endRow;
	}

	public void setEndRow(int endRow) {
		this.endRow = endRow;
	}

	public String getM_id() {
		return m_id;
	}

	public void setM_id(String m_id) {
		this.m_id = m_id;
	}

	@Override
	public String toString() {
		return "Paging [startRow=" + startRow + ", endRow=" + endRow + ", m_id=" + m_id + "]";
	}
	
}
