package cn.trymore.core.util.excel;

import java.util.ArrayList;
import java.util.List;

public class ExcelRowData {
	private int rowId = 0;
	private List<String> rowList = new ArrayList<String>();
	private List<String> rowStyleList = new ArrayList<String>();
	
	public ExcelRowData(){
		
	}
	
	public void setRowId(int rowid){
		this.rowId = rowid;
	}

	public List<String> getRowStyleList() {
		return rowStyleList;
	}

	public void setRowStyleList(List<String> rowStyleList) {
		this.rowStyleList = rowStyleList;
	}

	public boolean setRowStyle(String style) {
		return this.rowStyleList.add(style);
	}
	
	public int getRowId(){
		return this.rowId;
	}
	
	public boolean setRowData(String rowdata){
		return this.rowList.add(rowdata);
	}
	
	public List<String> getRowData(){
		return this.rowList;
	}
	
	public List<String> getRowList() {
		return rowList;
	}

	public void setRowList(List<String> rowList) {
		this.rowList = rowList;
	}
}
