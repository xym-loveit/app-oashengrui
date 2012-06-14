package cn.trymore.core.util.excel;

import java.util.List;

public abstract class AbstractExcelParser {
	
	public static final int EXCEL_HTML = 44;
	public static final int EXCEL_TABLE_WIDTH = 1000;
	public static final int EXCECL_DEFAULT_SHEET_INDEX = 0;
	
	protected String xlsFile;
	protected int htmlTbWidth;

	public void open() throws Exception {
		open(0);
	}

	public abstract void open(int paramInt) throws Exception;

	public abstract void close();

	public abstract String xlsToHtml(int paramInt) throws Exception;

	public abstract String getCellStyle(int paramInt1, int paramInt2);

	public abstract Object getCellContent(int paramInt1, int paramInt2);

	public abstract String getCellStyle(Object paramObject);

	public abstract Object getCellContent(Object paramObject);

	public abstract Integer getRowCount();

	public abstract Integer getColumnCount();

	public abstract Object getCell(int paramInt1, int paramInt2);
	
	public abstract List<ExcelRowData> getRowData (int sheetIndex);
	
	public void setXlsFile(String xlsFile) {
		this.xlsFile = xlsFile;
	}

	public String getXlsFile() {
		return this.xlsFile;
	}

	public int getHtmlTbWidth() {
		return this.htmlTbWidth;
	}

	public void setHtmlTbWidth(int htmlTbWidth) {
		this.htmlTbWidth = htmlTbWidth;
	}
}